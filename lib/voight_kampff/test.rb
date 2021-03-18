module VoightKampff
  class Test
    CRAWLERS_FILENAME = 'crawler-user-agents.json'

    attr_accessor :user_agent_string

    def initialize(user_agent_string)
      @user_agent_string = user_agent_string
    end

    def agent
      @agent ||= matching_crawler || {}
    end

    def human?
      agent.empty?
    end

    def bot?(type = nil)
      if !human?
        return true if type.nil?
        return false if @agent["types"].nil?

        @agent["types"].include?(type.to_s)
      else
        false
      end
    end
    alias :replicant? :bot?

    private

    def lookup_paths
      # These paths should be orderd by priority
      base_paths = []
      base_paths << VoightKampff.custom_root if VoightKampff.custom_root?
      base_paths << Rails.root if defined? Rails
      base_paths << VoightKampff.root
      base_paths.map { |p| p.join('config', CRAWLERS_FILENAME) }
    end

    def preferred_path
      lookup_paths.find { |path| File.exists? path }
    end

    def matching_crawler
      if match = crawler_regexp.match(@user_agent_string)
        index = match.named_captures.compact.first[0].sub(/match/, '').to_i
        crawlers[index]
      end
    end

    def crawler_regexp
      @@crawler_regexp ||= begin
        # NOTE: This is admittedly a bit convoluted but the performance gains make it worthwhile
        index = -1
        crawler_patterns = crawlers.map{|c| index += 1; "(?<match#{index}>#{c["pattern"]})" }.join("|")
        crawler_patterns = "(#{crawler_patterns})"
        Regexp.new(crawler_patterns, Regexp::IGNORECASE)
      end
    end

    def crawlers
      @@crawlers ||= JSON.load(File.open(preferred_path, 'r'))
    end
  end
end

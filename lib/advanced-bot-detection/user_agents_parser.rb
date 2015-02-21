module AdvancedBotDetection
  class UserAgentsParser
    # To generate a new user_agents.yml file run rake advanced_bot_detection:import_user_agents
    # This class is designed to work with http://www.user-agents.org/allagents.xml

    require 'nokogiri'
    require 'httpclient'

    def initialize(url)
      @url = url
      @xml = HTTPClient.new.get_content(url)
    end

    def agents
      agents = []
      xml = Nokogiri::XML(@xml)
      xml.xpath('//user-agent').each do |agent|
        agents << {
          'string' => agent.xpath('String').text,
          'string_match' => 'exact', # exact or regex
          'types' => agent.xpath('Type').text.split.map { |t| clarify_type(t) }.compact,
          'description' => agent.xpath('Description').text
        }
      end
      agents
    end

    def to_array
      agents
    end
    alias_method :to_a, :to_array

    def to_yaml
      agents.to_yaml
    end

    private

    def clarify_type(type)
      case type.downcase.to_sym
        when :b then 'browser'
        when :c then 'checker'
        when :d then 'downloader'
        when :p then 'proxy'
        when :r then 'crawler'
        when :s then 'spam'
      end
    end
  end
end

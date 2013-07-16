module ActionDispatch

  class Request

    def human?
      voight_kampff_test.human?
    end

    def bot?
      voight_kampff_test.bot?
    end
    alias :replicant? :bot?

    def browser?
      voight_kampff_test.browser?
    end

    def checker?
      voight_kampff_test.checker?
    end

    def downloader?
      voight_kampff_test.downloader?
    end

    def proxy?
      voight_kampff_test.proxy?
    end

    def crawler?
      voight_kampff_test.crawler?
    end

    def spam?
      voight_kampff_test.spam?
    end

    private

    def voight_kampff_test
      @voight_kampff ||= VoightKampff::Test.new(user_agent)
    end

  end

end

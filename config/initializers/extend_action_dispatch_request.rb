module ActionDispatch
  class Request
    def human?
      agent_tester.human?
    end

    def bot?
      agent_tester.bot?
    end

    def browser?
      agent_tester.browser?
    end

    def checker?
      agent_tester.checker?
    end

    def downloader?
      agent_tester.downloader?
    end

    def proxy?
      agent_tester.proxy?
    end

    def crawler?
      agent_tester.crawler?
    end

    def spam?
      agent_tester.spam?
    end

    private

    def agent_tester
      @advanced_bot_detection ||= AdvancedBotDetection::Test.new(user_agent)
    end
  end
end

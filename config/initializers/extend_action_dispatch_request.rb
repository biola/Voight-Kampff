module ActionDispatch
  class Request
    def human?
      voight_kampff_test.human?
    end

    def bot?
      voight_kampff_test.bot?
    end
    alias :replicant? :bot?

    private

    def voight_kampff_test
      @voight_kampff_test ||= VoightKampff::Test.new(user_agent)
    end
  end
end

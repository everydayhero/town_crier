module TownCrier
  class PublishError < Exception
    attr_reader :original_exception

    def initialize msg, original_exception
      super msg
      @original_exception = original_exception
    end
  end
end

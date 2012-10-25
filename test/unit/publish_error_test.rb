require 'test_helper'

module TownCrier
  class PublishErrorTest < MiniTest::Unit::TestCase
    def test_original_exception
      exception = Exception.new
      error     = PublishError.new "the message", exception

      assert_equal exception, error.original_exception
    end
  end
end

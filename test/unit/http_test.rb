require 'test_helper'

module TownCrier
  class HTTPTest < MiniTest::Unit::TestCase
    include TownCrier::Lint::Tests

    def model
      HTTP.new nil
    end
  end
end

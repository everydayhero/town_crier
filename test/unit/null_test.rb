require 'test_helper'

module TownCrier
  class NullTest < MiniTest::Unit::TestCase
    include TownCrier::Lint::Tests

    def model
      Null.new nil
    end
  end
end

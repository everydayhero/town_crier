require 'test_helper'

module TownCrier
  class AMQPTest < MiniTest::Unit::TestCase
    include TownCrier::Lint::Tests

    def model
      AMQP.new nil
    end
  end
end

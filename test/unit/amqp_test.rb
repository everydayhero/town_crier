require 'test_helper'

module TownCrier
  class AMQPTest < MiniTest::Unit::TestCase
    include TownCrier::Lint::Tests

    def test_publish_raises_an_exception_when_cannot_publish
      publisher = AMQP.new
      exchange  = MiniTest::Mock.new
      exchange.expect :publish, Exception.new, [String]
      publisher.exchange = exchange

      assert_raises TownCrier::PublishError do
        publisher.publish '{}'
      end
    end

    def model
      AMQP.new
    end
  end
end

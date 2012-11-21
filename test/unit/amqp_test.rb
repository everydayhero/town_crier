require 'test_helper'

module TownCrier
  class AMQPTest < MiniTest::Unit::TestCase
    include TownCrier::Lint::Tests

    def test_publish_raises_an_exception_when_cannot_publish
      publisher = AMQP.new
      exchange = MiniTest::Mock.new
      exchange.expect :publish, Exception.new, [String]

      client = MiniTest::Mock.new
      client.expect :start, true
      client.expect :stop, true
      client.expect :exchange, exchange, [Hash]
      publisher.client_class = MiniTest::Mock.new
      publisher.client_class.expect :new, client, [Hash]

      assert_raises TownCrier::PublishError do
        publisher.publish '{}'
      end
    end

    def model
      AMQP.new
    end
  end

end

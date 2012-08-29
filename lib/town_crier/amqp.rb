module TownCrier
  class AMQP
    attr_accessor :key, :config
    attr_writer :client, :exchange

    def initialize attributes = nil
      attributes ||= {}

      self.key    = attributes[:key]
      self.config = attributes.fetch(:config) do
        TownCrier.default_options[:amqp][:config]
      end
    end

    def publish payload
      exchange.publish payload, :content_type => 'application/json',
                                :persistent   => true,
                                :key          => key
    end

    def client
      @client ||= begin
        client = Bunny.new config
        client.start
        client
      end
    end

    def exchange
      @exchange ||= client.exchange TownCrier.default_options[:amqp][:exchange],
                                    :durable => true
    end
  end
end
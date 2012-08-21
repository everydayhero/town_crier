module Publishers
  class AMQP
    attr_accessor :key, :config
    attr_writer :client, :exchange

    def initialize attributes = nil
      attributes ||= {}

      key    = attributes[:key]
      config = attributes.fetch(:config) do
        Publishers.default_options[:amqp][:config]
      end
    end

    def publish data
      exchange.publish data, :content_type => 'application/json',
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
      @exchange ||= client.exchange Publishers.default_options[:amqp][:exchange],
                                    :durable => true
    end
  end
end

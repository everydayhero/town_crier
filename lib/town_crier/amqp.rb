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

    def publish payload, options = {}
      exchange.publish payload, :content_type => 'application/json',
                                        :persistent   => true,
                                        :key          => options[:test] ? "test.#{key}" : key
    rescue => e
      raise PublishError.new('A publishing error occurred', e)
    ensure
      client.stop
      reset_client!
    end

    def client
      client ||= Bunny.new config
      client.start
      client
    end

    def reset_client!
      @client = nil
      @exchange = nil
    end

    def exchange
      @exchange ||= client.exchange 'town_crier',
                                    :durable => true,
                                    :type    => :topic
    end
  end
end

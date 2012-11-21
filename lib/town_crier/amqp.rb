module TownCrier
  class AMQP
    attr_accessor :key, :config
    attr_writer :client_class, :exchange

    def initialize attributes = nil
      attributes ||= {}

      self.key    = attributes[:key]
      self.config = attributes.fetch(:config) do
        TownCrier.default_options[:amqp][:config]
      end
    end

    def publish payload, options = {}
      client = client_class.new config
      client.start
      exchange(client).publish payload, :content_type => 'application/json',
                                        :persistent   => true,
                                        :key          => options[:test] ? "test.#{key}" : key
    rescue => e
      raise PublishError.new('A publishing error occurred', e)
    ensure
      client.stop
    end

    def client_class
      @client_class ||= Bunny
    end

    def exchange client
      client.exchange   'town_crier',
                        :durable => true,
                        :type    => :topic
    end
  end
end

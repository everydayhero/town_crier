require 'net/http'

module TownCrier
  class HTTP
    attr_reader :hosts

    def initialize attributes = nil
      attributes ||= {}

      self.hosts = attributes.fetch(:hosts) do
        TownCrier.default_options[:hosts]
      end
    end

    def publishers
      {'http' => NonSSL, 'https' => SSL}
    end

    def publisher_for uri
      publisher = publishers.fetch uri.to_s.split('://').first, NonSSL
      publisher.new uri
    end

    def publish payload
      hosts.each { |uri| publisher_for(uri).publish payload }
    end

    def hosts= hosts
      @hosts = hosts.map { |_, url| URI(url + '/api/private/receive') }
    end

    class NonSSL
      attr_accessor :uri

      def initialize uri
        self.uri = uri
      end

      def http
        @http ||= Net::HTTP.new uri.host, uri.port
      end

      def publish payload
        request.set_form_data :payload => payload
        http.request request
      rescue Exception => e
        Rails.logger.info "Couldn't send payload to #{uri}."
      end

      def request
        @request ||= Net::HTTP::Post.new uri.request_uri
      end

      def uri= uri
        @uri = URI uri
      end
    end

    class SSL < NonSSL
      def http
        @http ||= begin
          http = Net::HTTP.new uri.host, uri.port
          http.use_ssl     = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
          http
        end
      end
    end
  end
end

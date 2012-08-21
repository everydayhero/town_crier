module Publishers
  class Null
    def initialize attributes = nil
    end

    def publish data
      Rails.logger.info "published: #{data}"
    end
  end
end

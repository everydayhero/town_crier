require "bunny"
require "publishers/amqp"
require "publishers/http"
require "publishers/null"
require "publishers/railtie"
require "publishers/version"

module Publishers
  def self.default_options
    @default_options ||= {
      :amqp  => {
        :config   => {
          :user     => 'guest',
          :password => 'guest',
          :pass     => 'guest'
        },
        :exchange => ''
      },
      :hosts => {}
    }
  end

  def self.default_publisher
    @default_publisher ||= begin
      publisher = default_options.fetch(:publisher) { AMQP }
      "Publishers::#{publisher}".constantize
    end
  end

  def self.default_publisher= new_publisher
    @default_publisher = new_publisher
  end

  def self.new options
    default_publisher.new options
  end
end

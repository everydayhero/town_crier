require "bunny"
require "town_crier/amqp"
require "town_crier/http"
require "town_crier/null"
require "town_crier/publish_error"
require "town_crier/lint"
require "town_crier/railtie" if defined?(Rails)
require "town_crier/version"

module TownCrier
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
      publisher = default_options.fetch(:publisher) { "AMQP" }
      "TownCrier::#{publisher}".constantize
    end
  end

  def self.default_publisher= new_publisher
    @default_publisher = new_publisher
  end

  def self.new options
    default_publisher.new options
  end
end

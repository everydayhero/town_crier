require "bunny"
require "publishers/amqp"
require "publishers/http"
require "publishers/null"
require "publishers/railtie"
require "publishers/version"

module Publishers
  def self.default_options
    @default_options = {
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
end

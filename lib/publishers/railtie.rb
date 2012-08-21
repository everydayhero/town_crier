require 'publishers'

module Publishers
  class Railtie < Rails::Railtie
    initializer 'publishers.initialize' do |app|
      if app.config.respond_to?(:publisher_defaults)
        Publishers.default_options.merge! app.config.publisher_defaults
      end
    end
  end
end

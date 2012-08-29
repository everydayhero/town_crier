require 'town_crier'

module TownCrier
  class Railtie < Rails::Railtie
    initializer 'town_crier.initialize' do |app|
      if app.config.respond_to?(:town_crier_defaults)
        TownCrier.default_options.merge! app.config.town_crier_defaults
      end
    end
  end
end

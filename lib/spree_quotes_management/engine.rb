module SpreeQuotesManagement
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_quotes_management'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer "spree_quotes_management.environment", before: :load_config_initializers, after: "spree.environment" do |app|
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/models/spree/app_configuration/*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
      # app.config.spree.class.include(Spree::Core::EnvironmentExtension)
      # app.config.spree.add_class('quote_preferences')
      # app.config.spree.quote_preferences = SpreeQuotesManagement::QuoteConfiguration.new
      # SpreeQuotesManagement::Config = app.config.spree.quote_preferences
      SpreeQuotesManagement::Config = SpreeQuotesManagement::QuoteConfiguration.new
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end

require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

FeatureFlags = Konf.new("config/features.yml")[Rails.env]
EnabledFeatures = FeatureFlags.map{|feature, enabled| feature if enabled }.compact

module FeatureFlagsExample
  class Application < Rails::Application

    config.autoload_paths += EnabledFeatures.map{|f| "features/#{f}/lib" }

    config.before_initialize do
      EnabledFeatures.each do |feature|
        feature_engine = feature.camelcase.constantize::Engine
        feature_engine.instance.run_initializers :default, self
      end
    end

  end
end

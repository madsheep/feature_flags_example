FeatureFlagsExample::Application.routes.draw do

  root to: 'application#index'

  EnabledFeatures.each do |feature|
    feature_klass = feature.camelcase.constantize
    mount feature_klass::Engine, at: feature
  end
end

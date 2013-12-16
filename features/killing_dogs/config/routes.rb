KillingDogs::Engine.routes.draw do
  root to: 'dogs#index'
  get "something", to: 'somewhere#sometime'
end

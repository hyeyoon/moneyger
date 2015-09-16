Rails.application.routes.draw do
  devise_for :user
  root :to => 'moneyger#dashboard'
  
  match ":controller(/:action(/:id))", :via => [:get, :post]
end

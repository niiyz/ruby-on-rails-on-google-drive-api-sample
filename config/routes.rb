Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'order', to: 'orders#index'
  get 'order2', to: 'orders#create'
end

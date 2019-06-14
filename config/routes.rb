Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/file', to: 'files#index'
  post '/file/upload', to: 'files#create'
end

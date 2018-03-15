Rails.application.routes.draw do
  get 'visitors/index'

  post 'visitors/import'

  root to: "visitors#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

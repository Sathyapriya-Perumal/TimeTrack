Rails.application.routes.draw do
  devise_for :users

  root to: "login#index"
  
  get "login/clockin"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

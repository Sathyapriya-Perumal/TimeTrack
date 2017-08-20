Rails.application.routes.draw do
  devise_for :users

  root to: "login#index"

  get "login/clockin"
  get "login/clockin_ledger", to: "login#clockin_ledger", as: :clockin_ledger_logins
  get "login/user", to: "login#user_ledger", as: :user_ledger_login
  match "users/:id" => "login#destroy_user", via: :delete, as: :destory_user_login
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

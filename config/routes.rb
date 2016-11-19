Rails.application.routes.draw do
  devise_scope :user do
    get "/sign_in", to: "devise/sessions#new" # custom path to login/sign_in
    get "/sign_up", to: "devise/registrations#new", as: "new_user_registration" # custom path to sign_up/registration
  end

  devise_for :users, :controllers => { :registrations => :registrations }
  root 'static_pages#landing'
  post '/match_request', to: 'matches#match_request'
  get '/dashboard', to: 'matches#dashboard'
end

Rails.application.routes.draw do
  devise_scope :user do
    get "/sign_in" => "devise/sessions#new" # custom path to login/sign_in
    get "/sign_up" => "devise/registrations#new", as: "new_user_registration" # custom path to sign_up/registration
  end

  devise_for :users
  root 'static_pages#landing'
  get '/make_match', to: 'matches#make_match'
  get '/match_found', to: 'matches#match_found'
  get '/match_not_found', to: 'matches#match_not_found'
end

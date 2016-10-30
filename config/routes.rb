Rails.application.routes.draw do

  devise_for :users
  root 'static_pages#landing'
  get '/make_match', to: 'matches#make_match'
  get '/match_found', to: 'matches#match_found'
  get '/match_not_found', to: 'matches#match_not_found'
end

Rails.application.routes.draw do
  resources :teams
  root to: 'teams#index'

  get 'create_all_teams', to: 'teams#create_all_teams'
  get 'delete_all_teams', to: 'teams#delete_all_teams'
  get 'create_all_players', to: 'players#create_all_players'
  get 'delete_all_players', to: 'players#delete_all_players'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

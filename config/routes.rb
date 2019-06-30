Rails.application.routes.draw do
  resources :answers
  resources :questions
  resources :items
  resources :events
  resources :transportations
  resources :weathers
  resources :categories
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'answers/remove'

  root 'questions#index'
end

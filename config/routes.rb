Rails.application.routes.draw do
  get 'searches/search' => 'searches#search', as: "search"
  devise_for :users#, controllers: {registrations: 'users/registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  resources :blogs do
    resources :blogcomments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:show, :index, :edit, :update] do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
end

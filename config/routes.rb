Rails.application.routes.draw do
  root 'mains#top'

# for mains
  get 'mains/top'
  get 'mains/about'
  get 'mains/contact'

# for users(default devise), to use custome controllers, to display show page
  devise_for :users,
              controllers: { omniauth_callbacks: "users/omniauth_callbacks",
                             passwords: "users/passwords",
                             registrations: 'users/registrations',
                             sessions: 'users/sessions' }
  resources :users, :only => [:show, :index] do
    member do
      get :following, :followers
    end
  end

# for posts and likes
  resources :posts do
    resources :likes, only: [:create, :destroy]
  end

# for comments
  resources :comments, only: [:edit, :create, :update, :destroy]

# for shares
  resources :shares, only: [:create, :destroy]

# for relationships
  resources :relationships, only: [:create, :destroy]

# for catch mail in the local
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

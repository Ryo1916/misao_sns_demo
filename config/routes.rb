Rails.application.routes.draw do
  root 'mains#top'
  get 'mains/top'
  get 'mains/about'
  get 'mains/contact'
  devise_for :users,
              controllers: { omniauth_callbacks: "users/omniauth_callbacks",
                             passwords: "users/passwords",
                             registrations: 'users/registrations',
                             sessions: 'users/sessions' }
  resources :users, :only => [:show]
  # get 'users/:id' => 'users#show'
  resources :posts
  post "likes/create" => "likes#create"
  post "likes/destroy" => "likes#destroy"

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  root to: "homepage#show"

  resources :users, only: [:new, :create]

  namespace :loans do
    resource :borrower_step, only: [:show, :create], controller: "borrower_step"
    resource :isbn_step,     only: [:show, :create], controller: "isbn_step"
  end

  resources :loans, only: [:index, :new, :create, :destroy]
end

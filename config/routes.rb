Rails.application.routes.draw do
  devise_for :users
  root to: "homepage#show"

  namespace :loans do
    resource :borrower_step, only: [:show, :create], controller: "borrower_step"
    resource :isbn_step,     only: [:show, :create], controller: "isbn_step"
  end

  resources :loans, only: [:index, :new, :create, :destroy]
  resources :borrowed_books, only: [:index]

  resource :settings, only: [:show]
end

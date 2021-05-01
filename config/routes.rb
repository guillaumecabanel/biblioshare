Rails.application.routes.draw do
  resources :users, only: [:new, :create]

  namespace :loans do
    resource :borrower_step, only: [:show, :create], controller: "borrower_step"
    resource :title_step,    only: [:show, :create], controller: "title_step"
  end

  resources :loans, only: [:show, :new]
end

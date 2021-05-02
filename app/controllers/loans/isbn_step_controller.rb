class Loans::IsbnStepController < ApplicationController
  before_action :require_user

  def show
    render 'loans/isbn_step'
  end

  def create
    session[:loan]["isbn"] = params[:isbn]

    redirect_to new_loan_path
  end
end

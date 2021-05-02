class Loans::BorrowerStepController < ApplicationController
  before_action :require_user

  def show
    @users = User.all

    render 'loans/borrower_step'
  end

  def create
    session[:loan] = {}
    session[:loan]["borrower_id"] = params[:user]

    redirect_to loans_isbn_step_path
  end
end

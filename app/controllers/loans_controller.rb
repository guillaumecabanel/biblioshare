class LoansController < ApplicationController
  before_action :require_user

  def show
    @loan = Loan.find(params[:id])
  end

  def new
    redirect_to loans_borrower_step_path
  end
end

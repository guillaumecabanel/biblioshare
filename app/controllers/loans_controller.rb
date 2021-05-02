class LoansController < ApplicationController
  before_action :require_user

  def show
    @loan = Loan.find(params[:id])
  end

  def new
    @loan = Loan.new(
      borrower_id: session[:loan]["borrower_id"],
      isbn: session[:loan]["isbn"]
    )
  end

  def create
    @loan = Loan.new(loan_params)
    @loan.lender = current_user

    @loan.save

    redirect_to loan_path(@loan)
  end

  private

  def loan_params
    params.require(:loan).permit(:borrower_id, :isbn)
  end
end

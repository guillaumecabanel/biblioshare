class Loans::TitleStepController < ApplicationController
  def show
  end

  def create
    session[:loan].merge!(params.require(:loan).permit(:title))

    @loan = Loan.create(
      lender: current_user,
      borrower: User.find(session[:loan]["borrower_id"]),
      title: session[:loan]["title"]
    )

    redirect_to loan_path(@loan)
  end
end

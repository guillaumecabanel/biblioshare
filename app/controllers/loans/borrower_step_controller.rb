class Loans::BorrowerStepController < ApplicationController
  def show
    @users = User.all
  end

  def create
    session[:loan] = {}
    session[:loan].merge!(params.require(:loan).permit(:borrower_id))

    redirect_to loans_title_step_path
  end
end

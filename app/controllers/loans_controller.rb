class LoansController < ApplicationController
  before_action :require_user

  def show
    @loan = Loan.find(params[:id])
  end

  def new
    isbn = session[:loan]["isbn"]
    response = HTTParty.get("http://openlibrary.org/api/volumes/brief/isbn/#{isbn}.json")
    book = JSON.parse(response.body, symbolize_names: true)

    @loan = Loan.new(
      borrower_id: session[:loan]["borrower_id"],
      isbn: isbn,
      title: book[:records].values.first[:data][:title],
      author: book[:records].values.first[:data][:authors].map { |author| author[:name] }.to_sentence
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
    params.require(:loan).permit(:borrower_id, :isbn, :title, :author)
  end
end

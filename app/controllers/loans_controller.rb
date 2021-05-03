class LoansController < ApplicationController
  before_action :require_user

  def new
    isbn = session[:loan]["isbn"]
    response = HTTParty.get("http://openlibrary.org/api/volumes/brief/isbn/#{isbn}.json")
    book = JSON.parse(response.body, symbolize_names: true)

    if book == []
      redirect_to loans_isbn_step_path(retry: true)
    else
      @loan = Loan.new(
        borrower_id: session[:loan]["borrower_id"],
        isbn: isbn,
        title: book[:records].values.first[:data][:title],
        author: book[:records].values.first[:data][:authors].map { |author| author[:name] }.to_sentence
      )
    end
  end

  def create
    @loan = Loan.new(loan_params)
    @loan.lender = current_user

    @loan.save

    redirect_to loans_path
  end

  def index
    @loans = current_user.loaned_books
  end

  def destroy
    @loan = Loan.find(params[:id])
    @loan.destroy

    redirect_to loans_path
  end

  private

  def loan_params
    params.require(:loan).permit(:borrower_id, :isbn, :title, :author)
  end
end

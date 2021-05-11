class LoansController < ApplicationController
  before_action :require_user

  def new
    isbn = session[:loan]["isbn"]

    response = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=isbn:#{isbn}&key=#{ENV["GOOGLE_BOOK_API"]}")
    book_data = JSON.parse(response.body, symbolize_names: true)

    if book_data[:totalItems].zero?
      redirect_to loans_isbn_step_path(retry: true)
    else
      book = book_data[:items].first

      @loan = Loan.new(
        borrower_id: session[:loan]["borrower_id"],
        isbn: isbn,
        title: book.dig(:volumeInfo, :title),
        author: book.dig(:volumeInfo, :authors)&.to_sentence,
        picture_url: book.dig(:imageLinks, :medium) || ""
      )
    end
  end

  def create
    @loan = Loan.new(loan_params)
    @loan.lender = current_user

    @loan.save

    respond_to do |format|
      format.turbo_stream do
        # render turbo_stream: turbo_stream.append(:loans, partial: "loans/loan", locals: { loan: @loan })
        # @loan.broadcast_append_to current_user, :loans, partial: "loans/loan", locals: { loan: @loan }
        @loan.broadcast_append_to(@loan.borrower, :borrowed_books,
          partial: "borrowed_books/borrowed_book",
          locals: { borrowed_book: @loan },
          target: "borrowed_books"
        )
        redirect_to loans_path
      end

      format.html { redirect_to loans_path}
    end
  end

  def index
    @loans = current_user.loaned_books
  end

  def destroy
    @loan = Loan.find(params[:id])
    @loan.destroy

    respond_to do |format|
      format.turbo_stream do
        # render turbo_stream: turbo_stream.remove(@loan)
        @loan.broadcast_remove_to current_user, :loans
        @loan.broadcast_remove_to @loan.borrower, :borrowed_books
      end

      format.html { redirect_to loans_path }
    end

  end

  private

  def loan_params
    params.require(:loan).permit(:borrower_id, :isbn, :title, :author, :picture_url)
  end
end

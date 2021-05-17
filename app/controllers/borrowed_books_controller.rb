class BorrowedBooksController < ApplicationController
  def index
    @borrowed_books = current_user.borrowed_books
  end
end

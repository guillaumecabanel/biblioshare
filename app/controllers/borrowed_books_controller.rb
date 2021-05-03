class BorrowedBooksController < ApplicationController
  before_action :require_user

  def index
    @borrowed_books = current_user.borrowed_books
  end
end

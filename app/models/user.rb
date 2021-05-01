class User < ApplicationRecord
  has_many :loaned_books, foreign_key: :lender_id, class_name: "Loan"
  has_many :borrowed_books, foreign_key: :borrower_id, class_name: "Loan"
end

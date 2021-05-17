class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :loaned_books, foreign_key: :lender_id, class_name: "Loan"
  has_many :borrowed_books, foreign_key: :borrower_id, class_name: "Loan"

  def initials
    return email.first.upcase unless full_name.present?

    full_name.split[0..1].map(&:first).join.upcase
  end

  def full_name
    @full_name || email.match(/([^@]+)@/)[1].capitalize
  end
end

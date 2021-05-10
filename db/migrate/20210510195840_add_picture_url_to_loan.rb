class AddPictureUrlToLoan < ActiveRecord::Migration[6.1]
  def change
    add_column :loans, :picture_url, :string
  end
end

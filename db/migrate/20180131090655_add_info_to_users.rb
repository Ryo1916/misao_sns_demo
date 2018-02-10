class AddInfoToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :date_of_birth, :date, :after => :encrypted_password
  end
end

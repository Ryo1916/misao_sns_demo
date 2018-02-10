class AddAddressToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :address, :string, :after => :date_of_birth
  end
end

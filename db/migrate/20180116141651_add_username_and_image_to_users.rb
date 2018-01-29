class AddUsernameAndImageToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string, :after => :id
    add_column :users, :image_name, :string, :after => :encrypted_password
  end
end

class AddLatlngToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :latitude, :float, limit: 24, :after => :address
    add_column :users, :longitude, :float, limit: 24, :after => :latitude
  end
end

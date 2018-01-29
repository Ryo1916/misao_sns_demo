class AddColumnsToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :latitude, :float, limit: 24
    add_column :posts, :longitude, :float, limit: 24
    add_column :posts, :address, :string
  end
end

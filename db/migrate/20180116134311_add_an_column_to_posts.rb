class AddAnColumnToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :image_name, :string
  end
end
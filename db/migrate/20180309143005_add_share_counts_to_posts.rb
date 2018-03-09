class AddShareCountsToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :shares_count, :integer
  end
end

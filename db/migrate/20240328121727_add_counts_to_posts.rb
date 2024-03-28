class AddCountsToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :comments_count, :integer, default: 0, null: false
    add_column :posts, :likes_count, :integer, default: 0, null: false
    add_column :posts, :views_count, :integer, default: 0, null: false
    add_column :posts, :unique_views_count, :integer, default: 0, null: false
    add_column :posts, :like_rate, :float, default: 0, null: false
  end
end

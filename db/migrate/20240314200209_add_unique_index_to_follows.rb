class AddUniqueIndexToFollows < ActiveRecord::Migration[7.1]
  def change
    add_index :follows, [:follower_id, :following_id], unique: true
  end
end

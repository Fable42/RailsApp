class RenameFollowingToFolloweeInFollows < ActiveRecord::Migration[7.1]
  def change
    rename_column :follows, :following_id, :followee_id
  end
end


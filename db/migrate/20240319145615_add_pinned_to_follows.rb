class AddPinnedToFollows < ActiveRecord::Migration[7.1]
  def change
    add_column :follows, :pinned, :boolean
  end
end

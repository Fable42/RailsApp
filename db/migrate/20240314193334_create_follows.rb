class CreateFollows < ActiveRecord::Migration[7.1]
  def change
    create_table :follows do |t|
      t.references :follower, references: :user
      t.references :following, references: :user

      t.timestamps
    end
  end
end

class CreateViews < ActiveRecord::Migration[7.1]
  def change
    create_table :views do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.datetime :viewed_at
      t.integer :view_time
    end
  end
end

class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: true, foreign_key: false
      t.references :comment, null: true, foreign_key: false

      t.timestamps

    end
    add_index :likes, [:user_id, :post_id], unique: true
    add_index :likes, [:user_id, :comment_id], unique: true
  end
end

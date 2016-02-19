class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :category
      t.integer :position
      t.integer :user_id, null: false
      t.timestamps null: false
    end
  end
end

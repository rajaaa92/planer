class ChangeStringToText < ActiveRecord::Migration
  def change
    change_column :items, :name, :text
    change_column :projects, :name, :text
  end
end

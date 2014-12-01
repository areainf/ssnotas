class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :username, :string 
    add_column :users, :active, :boolean, default: true
    add_index :users, :username, :unique => true
  end
end

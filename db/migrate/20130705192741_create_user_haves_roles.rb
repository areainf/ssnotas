class CreateUserHavesRoles < ActiveRecord::Migration
  def change
    create_table :user_haves_roles do |t|
      t.integer :user_id, :unique => true
      t.integer :rol_id
      t.timestamps
    end
  end
end

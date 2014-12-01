class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, :unique => true
      t.string :description

      t.timestamps
    end
  end
end

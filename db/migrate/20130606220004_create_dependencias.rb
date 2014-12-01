class CreateDependencias < ActiveRecord::Migration
  def change
    create_table :dependencias do |t|
      t.string :nombre
      t.string :descripcion
      t.integer :codigo
      t.integer :subcodigo

      t.timestamps
    end
  end
end

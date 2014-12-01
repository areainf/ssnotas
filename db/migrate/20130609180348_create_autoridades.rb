class CreateAutoridades < ActiveRecord::Migration
  def change
    create_table :autoridades do |t|
      t.string :cargo
      t.string :descripcion

      t.timestamps
    end
  end
end

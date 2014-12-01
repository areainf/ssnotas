class CreateTiposNotas < ActiveRecord::Migration
  def change
    create_table :tipos_notas do |t|
      t.string :nombre
      t.string :descripcion

      t.timestamps
    end
  end
end

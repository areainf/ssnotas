class CreateEstadosNota < ActiveRecord::Migration
  def change
    create_table :estados_nota do |t|
      t.string :nombre
      t.string :descripcion

      t.timestamps
    end
  end
end

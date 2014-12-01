class CreateDestinatarios < ActiveRecord::Migration
  def change
    create_table :destinatarios do |t|
      t.string :nombre
      t.string :apellido
      t.string :descripcion
      t.integer :autoridad_id
      t.integer :es_autoridad_actual

      t.timestamps
    end
  end
end

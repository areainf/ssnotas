class CreateNotas < ActiveRecord::Migration
  def change
    create_table :notas do |t|
      t.string :tema
      t.text :descripcion
      t.date :fecha_ingreso
      t.string :codigo
      t.integer :tipo_nota_id
      t.integer :remitente_id
      t.integer :destinatario_id
      t.date :fecha_eliminada
      t.date :fecha_finalizada

      t.timestamps
    end
  end
end

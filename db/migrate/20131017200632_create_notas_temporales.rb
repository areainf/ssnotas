class CreateNotasTemporales < ActiveRecord::Migration
  def change
    create_table :notas_temporales do |t|
      t.string :tema
      t.string :descripcion
      t.date :fecha_nota
      t.date :fecha_carga
      t.string :codigo, :unique => true
      t.references :tipo_nota, index: true
      t.references :remitente, index: true
      t.string :remitente
      t.references :destinatario, index: true
      t.string :destinatario
      t.references :cargado_por, index: true
      t.references :dependencia, index: true
      t.integer :estado
      t.references :nota, index: true

      t.timestamps
    end
  end
end

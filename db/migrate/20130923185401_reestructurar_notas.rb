class ReestructurarNotas < ActiveRecord::Migration
  def change
	add_column :notas, :fecha_nota, :date
	add_column :notas, :fecha_carga, :date
	add_column :notas, :tipo, :integer
	add_column :notas, :estado, :integer
	add_column :notas, :cargado_por_id, :integer, references: :users
	add_column :notas, :recibido_por_id, :integer, references: :users
	add_column :notas, :parent_id, :integer, references: :notas
	change_column :notas, :remitente_id , :integer, references: :entidades
	change_column :notas, :destinatario_id, :integer, references: :entidades
  end
 def down
    change_table :notas do |t|
	t.remove  :fecha_nota
	t.remove  :fecha_carga
	t.remove  :tipo
	t.remove  :estado
	t.remove  :cargado_por_id
	t.remove  :recibido_por_id
	t.remove  :parent_id
	
   end
	add_column :notas, :fecha_finalizada , :date
 end
 def up
	remove_column :notas, :fecha_finalizada
	change_column :notas, :remitente_id , :integer, references: :entidades
	change_column :notas, :destinatario_id, :integer, references: :entidades
 end
end

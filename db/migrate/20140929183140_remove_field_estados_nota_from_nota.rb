class RemoveFieldEstadosNotaFromNota < ActiveRecord::Migration
	def up
    remove_column :notas, :estado_notas_id
  end

  def down
    add_column :notas, :estado_notas_id, :references
  end
end

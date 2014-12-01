class RenameRemitenteDestinatarioNotasTemporales < ActiveRecord::Migration
  def change
	rename_column :notas_temporales, :remitente, :texto_remitente
	rename_column :notas_temporales, :destinatario, :texto_destinatario
  end
end

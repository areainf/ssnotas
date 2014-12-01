class RenameDestinatarioEsAutoridadActual < ActiveRecord::Migration
  def up
   rename_column :destinatarios, :es_autoridad_actual, :nro_autoridad
  end

  def self.down
    rename_column :destinatarios, :nro_autoridad, :es_autoridad_actual
  end
end

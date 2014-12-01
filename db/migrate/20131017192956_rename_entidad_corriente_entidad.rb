class RenameEntidadCorrienteEntidad < ActiveRecord::Migration
  def change
	rename_column :entidades, :entidad_corriente, :es_actual
  end
end

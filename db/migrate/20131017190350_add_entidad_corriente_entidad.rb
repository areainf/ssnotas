class AddEntidadCorrienteEntidad < ActiveRecord::Migration
  def change
    add_column :entidades, :entidad_corriente, :boolean , defaults: true
  end
end

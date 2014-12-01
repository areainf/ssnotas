class AddCargadoPorMesaEntradaNota < ActiveRecord::Migration
  def change
    add_column :notas, :cargado_mesa_entrada, :boolean , defaults: true
  end
end

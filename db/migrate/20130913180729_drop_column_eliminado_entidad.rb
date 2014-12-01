class DropColumnEliminadoEntidad < ActiveRecord::Migration
  def change
	remove_column :entidades, :eliminado
  end
end

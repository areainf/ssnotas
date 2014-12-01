class AddEliminadaNota < ActiveRecord::Migration
  def change
	add_column :notas, :eliminada, :boolean, :default => 0
  end
  def down
    remove_column :notas, :eliminada
  end
end

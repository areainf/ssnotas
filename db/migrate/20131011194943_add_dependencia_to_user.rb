class AddDependenciaToUser < ActiveRecord::Migration
  def change
	add_reference :users, :dependencia
  end
end

class AddDependenciaToUsuario < ActiveRecord::Migration
  def change
    add_reference :users, :dependencia, index: true
  end
end

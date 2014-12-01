class AddAliasOrganismoDependencia < ActiveRecord::Migration
  def change
    add_column :dependencias, :alias, :string , unique: true
    add_column :organismos, :alias, :string , unique: true
  end
end

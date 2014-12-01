 class AddOrganismoIdToDependencias < ActiveRecord::Migration
  def change
     add_column :dependencias, :organismo_id, :integer
  end
end

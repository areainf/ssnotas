class CreateOrganismos < ActiveRecord::Migration
  def change
    create_table :organismos do |t|
      t.string :nombre
      t.text :descripcion
      t.integer :codigo

      t.timestamps
    end
  end
end

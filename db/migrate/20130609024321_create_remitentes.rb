class CreateRemitentes < ActiveRecord::Migration
  def change
    create_table :remitentes do |t|
      t.string :nombre
      t.string :descripcion
      t.integer :dependencia_id

      t.timestamps
    end
  end
end

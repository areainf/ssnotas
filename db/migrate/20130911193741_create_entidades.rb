class CreateEntidades < ActiveRecord::Migration
  def change
    create_table :entidades do |t|
      t.references :persona
      t.references :dependencia
      t.references :cargo
      t.boolean :es_facultad, :default => 0
      t.references :user
      t.boolean :eliminado, :default => 0

      t.timestamps
    end
  end
end

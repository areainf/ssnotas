class CreateNotasPersona < ActiveRecord::Migration
  def change
    create_table :notas_persona do |t|
      t.references :persona, index: true
      t.references :nota, index: true

      t.timestamps
    end
  end
end

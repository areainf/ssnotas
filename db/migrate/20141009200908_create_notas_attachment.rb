class CreateNotasAttachment < ActiveRecord::Migration
  def change
    create_table :notas_attachment do |t|
      t.integer :nota_id
      t.string :filescan

      t.timestamps
    end
  end
end

class AddNroReferenciaNota < ActiveRecord::Migration
  def change
    add_column :notas, :nro_referencia, :string
  end
end

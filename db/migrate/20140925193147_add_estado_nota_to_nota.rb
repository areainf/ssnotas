class AddEstadoNotaToNota < ActiveRecord::Migration
  def change
  	    add_reference :notas, :estado_nota, index: true
  end
end

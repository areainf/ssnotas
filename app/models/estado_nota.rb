class EstadoNota < ActiveRecord::Base
  has_paper_trail
  has_many :notas
  attr_accessible :nombre, :descripcion
  validates :nombre, :presence =>{:message=>"Debe ingresar el nombre"},
  					 :uniqueness => { :message => "No se puede repetir el Nombre" }

	def self.simpleSearch(complextext)
      if !complextext.blank?
          strwhere = "nombre LIKE '%?%' or descripcion LIKE '%?%'"
          sqlwhere = Util::prepare_query(complextext,strwhere)
          where(sqlwhere)
      else
          scoped
      end
	end
end

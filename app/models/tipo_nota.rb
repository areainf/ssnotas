class TipoNota < ActiveRecord::Base
  has_paper_trail
  has_many :notas, :dependent=>:restrict
  attr_accessible :descripcion, :nombre
  validates :nombre, :presence =>{:message=>"Debe ingresar el nombre"} , :uniqueness => { :message => "No se puede repetir el Nombre" }

  def self.search(search)
    if search  then
      where('nombre LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
     #REALIZA UNA BUSQUEDA SIMPLE DE UNA O MAS PALABRAS
  #complextext: puede contener palabras + y *
  def self.simpleSearch(complextext)
      if !complextext.blank?
          strwhere = "nombre LIKE '%?%'"
          sqlwhere = Util::prepare_query(complextext,strwhere)
          where(sqlwhere)
      else
          scoped
      end
  end
end

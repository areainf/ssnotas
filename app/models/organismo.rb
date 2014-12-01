class Organismo < ActiveRecord::Base

  has_paper_trail  #:meta => {:user_id => if User.current.nil? then 0 else User.current.id end }
  self.per_page = 10
  #ID en la base de datos de la facultad de cs exactas
  ID_FCEFQyN = 1

  has_many :dependencias, :dependent=>:restrict

  attr_accessible :codigo, :descripcion, :nombre, :alias
  validates :nombre, :presence =>{:message=>"Debe ingresar el nombre"}
  validates :codigo, :uniqueness => {:message => "No se puede repetir el Codigo" }


  before_validation :generateCode
  def generateCode
    if self.codigo==nil  then
        temp=Organismo.maximum(:codigo)
        self.codigo=temp==nil ? 1 : temp+1
    end
  end

  def self.search(search)
    if search  then
      where('nombre LIKE ? or codigo LIKE ?', "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end

   #REALIZA UNA BUSQUEDA SIMPLE DE UNA O MAS PALABRAS
  #complextext: puede contener palabras + y *
  def self.simpleSearch(complextext)
      if !complextext.blank?
          strwhere = "nombre LIKE '%?%' or codigo LIKE '%?%'"
          sqlwhere = Util::prepare_query(complextext,strwhere)
          where(sqlwhere)
      else
          scoped
      end
  end

  def alias_or_name
      if self.alias.blank?
        self.nombre
      else
        self.alias
      end
  end

end

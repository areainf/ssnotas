class Dependencia < ActiveRecord::Base
  #registrar los cambios
  has_paper_trail
  default_scope order('nombre ASC')
  has_many :entidades, :dependent=>:restrict
  belongs_to :organismo

  attr_accessible :codigo, :descripcion, :nombre,  :organismo_id, :organismo, :alias
  validates :nombre, :presence =>{:message=>"Debe ingresar el nombre"}
  validates :codigo, :uniqueness => {:message => "No se puede repetir el Codigo" }
  #validates :organismo_id, :presence =>{:message=>"Debe seleccionar un organismo"}
  validates_uniqueness_of :nombre, scope: :organismo_id, :message => 'La dependencia ya existe en el Organismo seleccionado'

  #Antes de validar chequear si tiene codigo, sino crearlo
  before_validation :generateCode

  #Se fija si tiene codigo, sino lo crea
  def generateCode
    if self.codigo==nil  then
        temp=Dependencia.maximum(:codigo)
        self.codigo=temp==nil ? 1 : temp+1
    end

  end

=begin
  #No se si se esta usando 15-04-14
  def self.search(textsearch)
    if !textsearch.blank?  then
      joins("LEFT JOIN `organismos` ON dependencias.organismo_id = organismos.id").where('dependencias.nombre LIKE ? or organismos.nombre LIKE ? or dependencias.codigo = ?', "%#{textsearch}%", "%#{textsearch}%","#{textsearch}")
    else
      scoped.joins("LEFT JOIN `organismos` ON dependencias.organismo_id = organismos.id")
    end
  end
=end
  #REALIZA UNA BUSQUEDA SIMPLE DE UNA O MAS PALABRAS
  #complextext: puede contener palabras + y *
  def self.simpleSearch(complextext)
      if !complextext.blank?
          strwhere = "dependencias.nombre LIKE '%?%' or organismos.nombre LIKE '%?%' or dependencias.codigo = '?'"
          sqlwhere = Util::prepare_query(complextext,strwhere)
          joins("LEFT JOIN `organismos` ON dependencias.organismo_id = organismos.id").where(sqlwhere)
      else
          scoped.joins("LEFT JOIN `organismos` ON dependencias.organismo_id = organismos.id")
      end

  end



  def fullname
      name = ""
      if !self.organismo.nil?
          name += self.organismo.nombre+' -> '
      end
      name += self.nombre
  end
  def alias_or_name
      if self.alias.blank?
        self.nombre
      else
        self.alias
      end
  end
  def alias_or_fullname
      name = ""
      if !self.organismo.nil?
          name += self.organismo.alias_or_name+' -> '
      end
      name += self.alias_or_name
  end
end

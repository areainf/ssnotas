class Entidad < ActiveRecord::Base
  has_paper_trail
  attr_accessible :persona_id, :dependencia_id, :cargo_id, :user_id, :es_facultad, :es_actual
  belongs_to :persona
  belongs_to :dependencia
  belongs_to :cargo
  belongs_to :user
  has_many :notas_enviadas,  class_name: "Nota", foreign_key: "remitente_id", :dependent=>:restrict
  has_many :notas_recibidas,  class_name: "Nota", foreign_key: "destinatario_id", :dependent=>:restrict
  validates :user,
    :uniqueness => { :case_sensitive => false, :message => 'El Usuario ha sido previamente asignado a otra entidad'},
    :unless => Proc.new {|c| c.user.blank?}
  validate :valid_entidad
  validates_uniqueness_of :persona_id, scope: [:dependencia, :cargo], :message => 'La Entidad ya existe en el sistema'


  def self.search(search)
    if search  then
      search = Util::escape_sql_string(search)
      ##joins(:dependencia,:cargo,:persona).where('personas.nombre LIKE ? or personas.apellido LIKE ? or dependencias.nombre  LIKE ? or cargos.nombre  LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
      joins("LEFT JOIN dependencias as dep on entidades.dependencia_id = dep.id  LEFT JOIN cargos as c on entidades.cargo_id = c.id LEFT JOIN personas as p on p.id=entidades.persona_id").where('p.nombre LIKE ? or p.apellido LIKE ? or dep.nombre  LIKE ? or c.nombre  LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end

  #REALIZA UNA BUSQUEDA SIMPLE DE UNA O MAS PALABRAS
  #complextext: puede contener palabras + y *
  def self.simpleSearch(complextext)
      if !complextext.blank?
          strwhere = "personas.nombre LIKE '%?%' or personas.apellido LIKE '%?%' or dependencias.nombre  LIKE '%?%' or cargos.nombre  LIKE '%?%'"
          sqlwhere = Util::prepare_query(complextext,strwhere)
          Entidad.joins(" LEFT JOIN dependencias on entidades.dependencia_id = dependencias.id  LEFT JOIN cargos on entidades.cargo_id = cargos.id LEFT JOIN personas on personas.id=entidades.persona_id").where(sqlwhere)
      else
          scoped.joins(" LEFT JOIN dependencias on entidades.dependencia_id = dependencias.id  LEFT JOIN cargos on entidades.cargo_id = cargos.id LEFT JOIN personas on personas.id=entidades.persona_id")
      end

  end

  def fullname
      @name=""
      if !self.cargo.nil?
          @name += self.cargo.nombre
      end
      if !self.persona.nil?
          @name += ' '+self.persona.fullname
      end
      if !self.dependencia.nil?
          if @name.size > 0
              @name += ' -> '
          end
          @name += "["
          if !self.dependencia.organismo.nil?
              @name += self.dependencia.organismo.nombre+' -> '
          end
          @name += self.dependencia.nombre+'] '
      end
      return @name;
  end

  def alias_or_fullname
      @name=""
      if !self.cargo.nil?
          @name += self.cargo.nombre
      end
      if !self.persona.nil?
          @name += ' '+self.persona.fullname
      end
      if !self.dependencia.nil?
          if @name.size > 0
              @name += ' -> '
          end
          @name += self.dependencia.alias_or_fullname
      end
      return @name;
  end

  def cargoname
      @name=""
      if !self.cargo.nil?
          @name += self.cargo.nombre
      end
      if !self.persona.nil?
          @name += ' '+self.persona.fullname
      end
      return @name;
  end

  def self.facultad
      ##joins(:dependencia).merge(Dependencia.where(:organismo_id => Organismo::ID_FCEFQyN))
      where(:es_facultad => true , :es_actual => true)
  end
private
  def valid_entidad
    if self.persona.blank? && self.dependencia.blank?
      errors.add(:persona, "Debe seleccionar una Persona o Dependencia")
    end
=begin
    if self.cargo.blank?
      errors.add(:cargo, "Debe seleccionar un Cargo")
    end
=end
  end

end

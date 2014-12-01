class Persona < ActiveRecord::Base
  has_paper_trail
  attr_accessible :apellido, :nombre, :email
  has_many :entidades, :dependent=>:restrict
  has_many :notas_from, through: :entidades, :source => :notas_enviadas ,:dependent=>:restrict
  has_many :notas_to, through: :entidades, :source => :notas_recibidas ,:dependent=>:restrict
  validate :valid_nombre_o_apellido
  validates :email,
    :email_format => {:message => 'El email no es valido'},
    :unless => Proc.new {|c| c.email.blank?}

  validates :email,
    :uniqueness => { :case_sensitive => false, :message => 'El email ha sido previamente registrado en el sistema'},
    :unless => Proc.new {|c| c.email.blank?}
  validates_uniqueness_of :apellido, scope: [:nombre, :email], :message => 'La persona ya existe en el sistema'


  #validates :email, uniqueness: true
  #validates :email, :email_format => {:message => 'El email no es valido'}
  #validates :nombre, :presence =>{:message=>"Debe ingresar el nombre"}
  #validates :apellido, :presence =>{ :if => "nombre.blank?", :message=>"Debe ingresar el Apellido"}
   def self.search(search)
    if search  then
      where('nombre LIKE ? or apellido LIKE ? or email LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end
  def fullname
    apellido+', '+nombre
  end
  def valid_nombre_o_apellido
    if self.nombre.blank? && self.apellido.blank?
      errors.add(:nombre, "Debe ingresar Nombre o Apellido")
    end
  end
end

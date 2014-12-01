class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :registerable, :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :timeout_in => 60.minutes
  belongs_to :rol
  belongs_to :dependencia
  belongs_to :entidad
  has_paper_trail
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :rol_id, :dependencia_id

  def isAdmin
      self.rol.nil? ? false : self.rol.isAdmin
  end
  def isSecAdm
      self.rol.nil? ? false : self.rol.isSecAdm
  end
  def isSecDep
    self.rol.nil? ? false : self.rol.isSecDep
  end
  #Usuarios que no sean administradores y que ademas no tengan personas relacionadas
  def self.missing
  joins("LEFT OUTER JOIN roles ON users.rol_id = roles.id").where("roles.name != ? or rol_id is null ",'admin')
  end
end

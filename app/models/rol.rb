class Rol < ActiveRecord::Base
  has_paper_trail
  ROL_SEC_DPTO=3
  ROL_SEC_FAC=2
  ROL_ADMIN=1

  def self.rolesNoAdmin
    where("id != ?",ROL_ADMIN)
  end

  def isAdmin
    self.id==ROL_ADMIN
  end
  def isSecAdm
    self.id==ROL_SEC_FAC
  end

  def isSecDep
      self.id==ROL_SEC_DPTO
  end
end

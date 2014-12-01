class Cargo < ActiveRecord::Base
  has_paper_trail
  has_many :entidades, :dependent=>:restrict
  attr_accessible :nombre, :descripcion
  validates :nombre, :presence =>{:message=>"Debe ingresar el nombre del cargo"} , :uniqueness => { :message => "No se puede repetir el Cargo" }


=begin
  #No se si se esta usando 15-04-14

  def self.search(search)
    if search  then
      where('nombre LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
=end
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

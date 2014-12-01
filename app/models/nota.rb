class Nota < ActiveRecord::Base
  has_paper_trail
  #default_scope  :conditions => ["eliminada = ?",0]
  scope :no_eliminada, -> { where(eliminada: "0") }
  default_scope { where(eliminada: "0") }

  after_initialize :init
  #constante de clase
  TIPO_ENTRADA = 0
  TIPO_SALIDA = 1
  ESTADO_PENDIENTE = 0
  ESTADO_CIRCULACION = 1

# == relations
  belongs_to :destinatario, :class_name => "Entidad"
  belongs_to :remitente, :class_name => "Entidad"
  belongs_to :tipo_nota
  belongs_to :estado_nota
  belongs_to :cargado_por, :class_name => "User"
  belongs_to :recibido_por, :class_name => "User"
  belongs_to :parent, :class_name => "Nota"
  has_many :notas_asociadas, :class_name => "Nota", :foreign_key => "parent_id", :dependent=>:restrict
  has_many :nota_persona
  has_many :personas, through: :nota_persona, :class_name => "Persona"  
  has_one :nota_temporal, :dependent => :restrict
  has_many :nota_attachments
  accepts_nested_attributes_for :nota_attachments



  
# == Atributes
  attr_accessible :codigo, :descripcion, :destinatario_id, :fecha_eliminada, :fecha_nota, :fecha_carga, :tipo, :estado, :cargado_por_id, :recibido_por_id, :parent_id, :fecha_ingreso, :remitente_id, :tema, :tipo_nota_id, :cargado_mesa_entrada, :nro_referencia, :estado_nota_id
  attr_accessor :persona_ref_tokens

# == Validaciones
  validates :codigo, uniqueness: true
  validates :destinatario_id , :presence =>{:message=>"Debe seleccionar un Destinatario"}
  validate :ensure_remitente_exists
  validates :tipo_nota_id, :presence =>{:message=>"Debe seleccionar un Tipo de Notas"}
  validates :fecha_nota, :presence =>{:message=>"Debe ingresar la Fecha"}
  validates :tema , :presence =>{:message=>"Debe ingresar el Tema de la nota"}


  @valid_search_field = {"cd:" =>"notas.codigo LIKE '%?%'", "desc:" => "notas.descripcion LIKE '%?%'", "dest:" => "destinatarios.nombre  LIKE '%?%'  or destinatarios.apellido LIKE '%?%'  or autoridades.cargo  LIKE '%?%' ", "notas.fi:"=>"fecha_ingreso  LIKE '%?%' ", "rm:"=>"remitentes.nombre LIKE '%?%'", "tm:"=>"notas.tema LIKE '%?%'", "tn:"=>"tipos_notas.nombre LIKE '%?%'"}
  before_create :generateCode
  after_save :addPersonasReferencia
  
  def self.nextCode(fecha)
    precode=fecha.strftime("%Y")
    last_note=Nota.unscoped.where(["codigo LIKE ?","%"+precode]).order(:codigo => :desc).first
    last_note_temporal=NotaTemporal.where(["codigo LIKE ?","%"+precode]).order(:codigo => :desc).first
    nextnumber = 1
    nextnumbertemp = 1
    if last_note != nil then
        codigo_ant=last_note.codigo
        lastnumber=codigo_ant[0..precode.size]
        while lastnumber.sub!(/^0/, '') do end
        nextnumber = lastnumber.to_i + 1
    end
    if last_note_temporal != nil then
        codigo_ant=last_note_temporal.codigo
        lastnumber=codigo_ant[0..precode.size]
        while lastnumber.sub!(/^0/, '') do end
        nextnumbertemp = lastnumber.to_i + 1
    end

    nextnumber = nextnumber > nextnumbertemp ? nextnumber : nextnumbertemp
    sprintf( "%05d", nextnumber )+precode

  end


  def generateCode
    if self.codigo.nil?
      self.codigo = Nota.nextCode(self.fecha_nota)
    end
  end


    #REALIZA UNA BUSQUEDA SIMPLE DE UNA O MAS PALABRAS
    #complextext: puede contener palabras + y *
    def self.simpleSearch(complextext)
        if !complextext.blank?
            strwhere = "tema like '%?%' or 
                        notas.descripcion like '%?%' or 
                        remitentes_personas.nombre  like '%?%' or 
                        remitentes_personas.apellido  like '%?%' or 
                        remitentes_cargos.nombre  like '%?%' or 
                        destinatarios_personas.nombre  like '%?%' or 
                        destinatarios_personas.apellido  like '%?%' or 
                        destinatarios_cargos.nombre  like '%?%' or 
                        DATE_FORMAT(fecha_nota,'%d%m%Y') like '%?%' or 
                        DATE_FORMAT(fecha_carga,'%d%m%Y') like '%?%'  or 
                        DATE_FORMAT(fecha_ingreso,'%d%m%Y') like '%?%' or
                        codigo like '%?%' or
                        persona_referencia.nombre like '%?%' or
                        persona_referencia.apellido like '%?%'"

            sqlwhere = Util::prepare_query(complextext,strwhere)
            Nota.joins(
                "LEFT JOIN entidades as remitentes on notas.remitente_id=remitentes.id LEFT JOIN personas as remitentes_personas on remitentes.persona_id=remitentes_personas.id LEFT JOIN cargos as remitentes_cargos on remitentes.cargo_id = remitentes_cargos.id
                 LEFT JOIN entidades as destinatarios on notas.destinatario_id=destinatarios.id LEFT JOIN personas as destinatarios_personas on destinatarios.persona_id=destinatarios_personas.id LEFT JOIN cargos as destinatarios_cargos on destinatarios.cargo_id = destinatarios_cargos.id
                 LEFT JOIN notas_persona as notapersona on notas.id = notapersona.nota_id LEFT JOIN personas as persona_referencia on persona_referencia.id = notapersona.persona_id
                "
            ).where(sqlwhere)
        else
            scoped
        end
    end

    #retorna verdadero si la dependencia es remitente o destinatario de la nota
    def haveDependencia(dep_id)
        r_id = remitente.dependencia_id == dep_id unless remitente.nil?
        d_id = destinatario.dependencia_id == dep_id unless destinatario.nil?
        return r_id || d_id
    end
  def logic_destroy
    if self.notas_asociadas.empty?
       self.update_columns(:eliminada =>1,:fecha_eliminada=>Time.now)
    else
         raise 'Contiene notas asociadas'
    end
  end
  def persona_ref_tokens=(persona_ref_tokens)
    @persona_ref_tokens = persona_ref_tokens
  end
private

  def init
        self.tipo ||= TIPO_ENTRADA unless ! self.respond_to? :tipo
        self.estado ||= ESTADO_PENDIENTE  unless ! self.respond_to? :estado
  end

  #valida que este y exista el remitente
  def ensure_remitente_exists
    begin
      Entidad.find(self.remitente_id)
    rescue ActiveRecord::RecordNotFound
        errors.add(:remitente,'Debe seleccionar un Remitente')
    end

  end

  def addPersonasReferencia
    if (!persona_ref_tokens.nil?)
      persona_ref_tokens.each do |persona|
        nota_persona.create(:persona_id => persona)
      end
    end
  end
end

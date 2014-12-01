class NotaTemporal < ActiveRecord::Base
  has_paper_trail

  scope :notas_dependencia_user, lambda { |user|
    where("notas_temporales.dependencia_id = ?", user.dependencia_id)
  }


  belongs_to :tipo_nota
  belongs_to :destinatario, :class_name => "Entidad"
  belongs_to :remitente, :class_name => "Entidad"
  belongs_to :cargado_por, :class_name => "User"
  belongs_to :nota
  belongs_to :dependencia

  attr_accessible :codigo, :descripcion, :destinatario_id, :fecha_nota, :fecha_carga,  :estado, :cargado_por_id, :remitente_id, :tema, :tipo_nota_id, :dependencia_id, :texto_destinatario, :texto_remitente, :nota_id

  validates :texto_destinatario , :presence =>{:message=>"Debe seleccionar un Destinatario"},  if: "destinatario_id.nil?"
  validates :texto_remitente , :presence =>{:message=>"Debe seleccionar un Remitente"},  if: "remitente_id.nil?"
  validates :tipo_nota_id, :presence =>{:message=>"Debe seleccionar un Tipo de Nota"}
  validates :fecha_nota, :presence =>{:message=>"Debe ingresar la Fecha"}
  validates :tema , :presence =>{:message=>"Debe ingresar el Tema de la nota"}

  before_create :generateCode
  before_save :remove_text_from_to
  def generateCode
    self.codigo = Nota.nextCode(self.fecha_nota)
  end

  ####
  ## Si Destinatario esta definido, borrar texto_destinatario
  ## Si Remitente esta definido, borrar texto_remitente
  ####

  def remove_text_from_to
      if !self.destinatario_id.blank?
        self.texto_destinatario = ""
      end
      if !self.remitente_id.blank?
        self.texto_remitente = ""
      end
  end

    ##Copia los valores de una nota temporal a nota
    def to_nota
        @nota = Nota.new
        @nota.codigo = self.codigo
        @nota.descripcion = self.descripcion
        @nota.destinatario_id = self.destinatario_id
        @nota.fecha_nota = self.fecha_nota
        @nota.fecha_carga = self.fecha_carga
        @nota.estado = self.estado
        @nota.cargado_por_id = self.cargado_por_id
        @nota.remitente_id = self.remitente_id
        @nota.tema = self.tema
        @nota.tipo_nota_id = self.tipo_nota_id
        @nota
    end
    def ingresada?
      return self.estado == Nota::ESTADO_CIRCULACION && !self.nota_id.nil?
    end

    #REALIZA UNA BUSQUEDA SIMPLE DE UNA O MAS PALABRAS
    #complextext: puede contener palabras + y *
    def self.simpleSearch(complextext)
        if !complextext.blank?
            strwhere = "tema like '%?%' or notas_temporales.descripcion like '%?%' or texto_remitente like '%?%' or texto_destinatario like '%?%' or remitentes_personas.nombre  like '%?%' or remitentes_personas.apellido  like '%?%' or remitentes_cargos.nombre  like '%?%' or destinatarios_personas.nombre  like '%?%' or destinatarios_personas.apellido  like '%?%' or destinatarios_cargos.nombre  like '%?%' or DATE_FORMAT(fecha_nota,'%d%m%Y') like '%?%' or DATE_FORMAT(fecha_carga,'%d%m%Y') like '%?%'  or codigo like '%?%'"
            sqlwhere = Util::prepare_query(complextext,strwhere)
            joins(
                "LEFT JOIN entidades as remitentes on notas_temporales.remitente_id=remitentes.id LEFT JOIN personas as remitentes_personas on remitentes.persona_id=remitentes_personas.id LEFT JOIN cargos as remitentes_cargos on remitentes.cargo_id = remitentes_cargos.id
                 LEFT JOIN entidades as destinatarios on notas_temporales.destinatario_id=destinatarios.id LEFT JOIN personas as destinatarios_personas on destinatarios.persona_id=destinatarios_personas.id LEFT JOIN cargos as destinatarios_cargos on destinatarios.cargo_id = destinatarios_cargos.id
                "
            ).where(sqlwhere)
        else
            scoped.joins(
                "LEFT JOIN entidades as remitentes on notas_temporales.remitente_id=remitentes.id LEFT JOIN personas as remitentes_personas on remitentes.persona_id=remitentes_personas.id LEFT JOIN cargos as remitentes_cargos on remitentes.cargo_id = remitentes_cargos.id
                 LEFT JOIN entidades as destinatarios on notas_temporales.destinatario_id=destinatarios.id LEFT JOIN personas as destinatarios_personas on destinatarios.persona_id=destinatarios_personas.id LEFT JOIN cargos as destinatarios_cargos on destinatarios.cargo_id = destinatarios_cargos.id
                "
            )
        end
    end


end

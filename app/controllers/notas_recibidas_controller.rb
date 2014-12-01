class NotasRecibidasController < ApplicationController
  #before_action :can_execute
  before_filter :authenticate_user!
  before_action :authenticate_secDep
  # GET /notas
  # GET /notas.json
  def index
      # @notas = Nota.paginate(:page => params[:page], :per_page => params[:rows])
      find_nota
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @notas }
      end
  end

  #Realiza la busqueda de notas
  #El texto a buscar viene en el parametro term
  #Retorna una vista parcial de row_index
  def search
      find_nota
      respond_to do |format|
          format.html{render :partial=> "row_index"}
          format.json { render json: @dependencias }
          format.js {  }
      end
  end

  def show
    @nota_recibida = Nota.find(params[:id])
    user=current_user
    if !@nota_recibida.haveDependencia(user.dependencia_id)
        flash[:error] = "No tiene permisos suficientes para ejecutar "+params[:action]
        redirect_to :log_in # halts request cycle
    end
  end

  private
    def find_nota
      #INICIO ORDENACION
      $valid_sort=['tema','remitente','destinatario','fecha_nota','fecha_ingreso','tipo_nota_id']
      sort = "comun"
      if params[:sort]!=nil && $valid_sort.include?(params[:sort]) 
        dir = params[:direction] == 'desc' ? "desc" : "asc"
        if params[:sort] == 'remitente' || params[:sort] == 'destinatario' 
          order = "personas.apellido #{dir}, personas.nombre  #{dir}"
          sort = params[:sort]=='remitente' ? "remitente" : "destinatario"
        else
          order=params[:sort]+" " + dir
        end
      else
        order = "fecha_nota DESC"
      end
      #FIN ORDENACION
      s=session[:term]#params[:search] || params[:term]
      if s!=nil then
         s = s.gsub('%', '\%').gsub('_', '\_').gsub("'","\'").gsub('"','\"')
      end
      user = current_user
      @notas = Nota.includes(:destinatario).where('entidades.dependencia_id = ?',user.dependencia_id).references(:destinatario)


      if !s.blank?
          q = "%#{s}%"
          @notas = @notas.simpleSearch(s).paginate(:page => params[:page], :per_page => params[:rows])
      else
          @notas = @notas.paginate(:page => params[:page], :per_page => params[:rows])
      end
      logger.info("\n\n\n\n\n\n\n#{@notas.count}\n\n\n\n\n")
@notas = @notas.order(order)
      if sort == "comun"
          @notas = @notas.order(order)
      elsif sort == "remitente"
          @notas = @notas.joins("LEFT JOIN entidades as entidad on remitente_id = entidad.id").
                  joins("LEFT JOIN personas as personas on entidad.persona_id = personas.id").order(order)
      else
          @notas = @notas.joins("LEFT JOIN entidades as entidad on destinatario_id = entidad.id").
                  joins("LEFT JOIN personas as personas on entidad.persona_id = personas.id").order(order)
      end
  end

=begin

    def can_execute
       #if is_current_user_admin || is_current_user_sec_adm
       #  return true
       #end
       if is_current_user_sec_dep
          return true
       else
          flash[:error] = "No tiene permisos suficientes para ejecutar "+params[:action]
          redirect_to :log_in # halts request cycle
        end

    end
=end
end


class NotasTemporalesController < ApplicationController
  include NotasHelper
  include ApplicationHelper
  helper_method :str_attr_estado

  before_action :set_nota_temporal, only: [:procesar,:show, :edit, :update, :destroy,:cupon, :barcode, :shortcut]
  #before_action :can_execute
  before_filter :authenticate_user!
  before_action :authenticate_secDep

  # GET /notas_temporales

  def index
      #INICIO ORDENACION
      find_notas_temporales
  end
  def search
    find_notas_temporales
    respond_to do |format|
          format.html{render :partial=> "row_index"}
          format.json { render json: @dependencias }
          format.js {  }
      end
  end

  # GET /notas_temporales/1
  def show
    if @nota_temporal.ingresada? #@nota_temporal.estado == Nota::ESTADO_CIRCULACION && !@nota_temporal.nota_id.nil?
        @nota = @nota_temporal.nota
        render :show_nota
    end
  end


 # GET /notas_temporales/1/cupon
  def cupon
    generate_barcode(@nota_temporal.codigo)
    @barcode = url_for :controller => 'notas_temporales', :action => 'barcode'
    @pdf = Prawn::Document.new
    @pdf.text "Hello, World!"
    respond_to do |format|
        format.pdf
        format.html
    end
  end
  def barcode

     path = store_dir_barcode(@nota_temporal.codigo)
     #send_data path, :type => 'image/png', :filename => 'barcode.png'
     render :text => open(path, "rb").read
  end

  # GET /notas_temporales/new
  def new
     @user = current_user
     @nota_temporal = NotaTemporal.new
     @nota_temporal.fecha_carga = Time.now
     @dependencia = Dependencia.find(@user.dependencia_id)
     @remitentes = Entidad.where(dependencia_id: @user.dependencia_id)
     @destinatarios = Entidad.facultad
     @tipos_notas = TipoNota.all
     respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @nota }
     end
  end

  # GET /notas_temporales/1/edit
  def edit
      if @nota_temporal.estado == Nota::ESTADO_PENDIENTE
          @user = current_user
          @dependencia = Dependencia.find(@user.dependencia_id)
          @remitentes = Entidad.where(dependencia_id: @user.dependencia_id)
          @destinatarios = Entidad.facultad
          if !@nota_temporal.destinatario_id.nil?
            @destinatarios = @destinatarios << Entidad.find(@nota_temporal.destinatario_id)
          end
          @tipos_notas = TipoNota.all
      else
          flash[:error] = "No puede editar la nota, ya paso por mesa de entrada"
          redirect_to notas_temporales_url
      end
  end

  # POST /notas_temporales
  def create
      @nota_temporal = NotaTemporal.new(nota_temporal_params)
      #autocalcular atributos
      @user = current_user
      @nota_temporal.fecha_carga = Time.now
      @nota_temporal.estado=Nota::ESTADO_PENDIENTE
      @nota_temporal.cargado_por_id=@user.id
      @nota_temporal.dependencia_id=@user.dependencia_id

    if @nota_temporal.save
      redirect_to @nota_temporal, notice: 'Se guardo correctamente la nota, deberia mostrarle una pagina con el codigo para que lo pueda imprimir y llevarlo a mesa de entrada de la facultad.'
    else
        @dependencia = Dependencia.find(@user.dependencia_id)
        @remitentes = Entidad.where(dependencia_id: @user.dependencia_id)
        @destinatarios = Entidad.facultad
        @tipos_notas = TipoNota.all
        render action: 'new'
    end
  end

  # PATCH/PUT /notas_temporales/1
  def update
    if @nota_temporal.estado == Nota::ESTADO_PENDIENTE
        if @nota_temporal.update(nota_temporal_params)
          redirect_to @nota_temporal, notice: 'Se actualizo correctamente la nota.'
        else
          render action: 'edit'
        end
    else
          flash[:error] = "No puede editar la nota, ya paso por mesa de entrada"
          redirect_to notas_temporales_url
   end
  end

  # DELETE /notas_temporales/1
  def destroy
    if @nota_temporal.estado == Nota::ESTADO_PENDIENTE && @nota_temporal.nota==nil
        @nota_temporal.destroy
        redirect_to notas_temporales_url, notice: 'Se elimino correctamente la nota.'
    else
          flash[:error] = "No puede eliminar la nota, ya paso por mesa de entrada"
          redirect_to notas_temporales_url
    end
  end

  #Realiza la busqueda de notas temporales
  #El texto a buscar viene en el parametro term
  #Retorna una vista parcial de row_index
  def find_notas_temporales

      #INICIO ORDENACION
      valid_sort=['remitente','destinatario','fecha_nota','tipo_nota_id','estado', "tema", "codigo"]
      sort="comun"
      order=""
      if params[:sort]!=nil && valid_sort.include?(params[:sort]) then
          $dir=params[:direction]=='desc' ? "desc":"asc"
          if params[:sort]=='remitente'
            order="remitentes.apellido #{$dir}, remitentes.nombre  #{$dir}"
          elsif params[:sort]=='destinatario' then
              order="destinatarios.apellido #{$dir}, destinatarios.nombre  #{$dir}"

          else
              order=params[:sort]+" " + $dir
          end
      else
          order="fecha_nota ASC"
      end
      #FIN ORDENACION
      #user = current_user
      s=params[:term] || session[:term]
=begin
      if !s.blank?
          q = "%#{s}%"
          entRem = Entidad.search(s).where("dependencia_id = ?",user.dependencia_id).select("entidades.id")
          entDest = Entidad.search(s).select("entidades.id")
          @notas_temporales = NotaTemporal.simpleSearch(s).where(:dependencia_id => user.dependencia_id).paginate(:page => params[:page], :per_page => params[:rows])
      else
          @notas_temporales = NotaTemporal.where("notas_temporales.dependencia_id = ? ",user.dependencia_id).paginate(:page => params[:page], :per_page => params[:rows])
      end
=end
      @notas_temporales = NotaTemporal.notas_dependencia_user(current_user).simpleSearch(s).paginate(:page => params[:page], :per_page => params[:rows]).order(order)
=begin
      if sort == "comun"
          @notas_temporales = @notas_temporales.order(order)
      elsif sort == "remitente"
          @notas_temporales = @notas_temporales.joins(:remitente=>:persona).order(order)
      else
          @notas_temporales = @notas_temporales.joins(:destinatario=>:persona).order(order)
      end
=end
  end

  private
    # Metodo compartido para obtener la nota por el id y ademas controlar
    # que el usuario puede tener acceso a estas notas
    def set_nota_temporal
      @nota_temporal = NotaTemporal.find(params[:id])
      @user = current_user
      if @nota_temporal.dependencia_id != @user.dependencia_id
          flash[:error] = "No puede acceder a esta nota"
          redirect_to :log_in # halts request cycle
      end
    end


    # Only allow a trusted parameter "white list" through.
    def nota_temporal_params
      params.require(:nota_temporal).permit(:tema, :descripcion, :fecha_nota, :tipo_nota_id, :remitente_id, :texto_remitente, :destinatario_id, :texto_destinatario, :cargado_por_id, :estado, :nota_id)
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

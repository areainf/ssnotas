class DependenciasController < ApplicationController
#before_action :can_execute
  before_filter :authenticate_user!
  before_action :authenticate_manager
  # GET /dependencias
  # GET /dependencias.json
  def index
      find_dependencias
      respond_to do |format|
          format.html
          format.json { render :json => @dependencias.to_json(:methods => :alias_or_fullname, :only => [:id, :codigo, :nombre])}

      end
  end


  #Realiza la busqueda de dependencias
  #El texto a buscar viene en el parametro term
  #Retorna una vista parcial de row_index
  def search
      find_dependencias
      respond_to do |format|
          format.html{render :partial=> "row_index"}
          format.json { render json: @dependencias }
          format.js {  }
      end
  end


  # GET /dependencias/1
  # GET /dependencias/1.json
  def show
    @dependencia = Dependencia.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dependencia }
    end
  end

  # GET /dependencias/new
  # GET /dependencias/new.json
  def new

    @dependencia = Dependencia.new
    @organismo = Organismo.all
    if (params[:remote]) then
        render "new", :layout => false

    else
      respond_to do |format|
        format.html
        format.json { render json: @dependencia }
      end
    end
  end

  # GET /dependencias/1/edit
  def edit
    @dependencia = Dependencia.find(params[:id])
    @organismo = Organismo.all
    if params[:remote]
        render :partial=> "form"
        return;
    end

  end

  # POST /dependencias
  # POST /dependencias.json
  def create
    @dependencia = Dependencia.new(dependencia_params)

    respond_to do |format|
      if @dependencia.save
        logger.info { params }
        format.html { redirect_to @dependencia, notice: 'Dependencia se creo correctamente.' }
        format.json { render json: @dependencia, status: :created, location: @dependencia }
        format.js {
           if params.has_key?("listado")
              @listado=true
           else
             @listado = false
           end
          }
      else
        @organismo = Organismo.all
        format.html { render action: "new" }
        format.json { render json: @dependencia.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /dependencias/1
  # PUT /dependencias/1.json
  def update
    @dependencia = Dependencia.find(params[:id])

    respond_to do |format|
      if @dependencia.update_attributes(dependencia_params)
        format.html { redirect_to @dependencia, notice: 'Dependencia se actualizo correctamente.' }
        format.json { head :no_content }
        format.js{}
      else
        format.html { render action: "edit" }
        format.json { render json: @dependencia.errors, status: :unprocessable_entity }
        format.js{}
      end
    end
  end

  # DELETE /dependencias/1
  # DELETE /dependencias/1.json
  def destroy
    @dependencia = Dependencia.find(params[:id])
    begin
      @dependencia.destroy
    rescue ActiveRecord::DeleteRestrictionError => e
      flash[:error]="No se pudo eliminar porque otros dependen de el\n(#{e})"
    end
    respond_to do |format|
      format.html { redirect_to dependencias_url }
      format.json { head :no_content }
    end
  end
  def delete
    $ok = true
    @dependencia = Dependencia.find(params[:id])
    begin
        @dependencia.destroy
    rescue ActiveRecord::DeleteRestrictionError => e
          $ok = false
    end
    respond_to do |format|
        format.html{redirect_to cargos_url, notice: "Se elimino la dependencia #{dependencia.nombre}."}
        format.js{$ok}
    end
  end

private
  def dependencia_params
    params.require(:dependencia).permit(:codigo, :descripcion, :nombre,  :organismo_id, :organismo, :alias)
  end
  def can_execute
    if is_current_user_admin || is_current_user_sec_adm
      return true
    else
      flash[:error] = "No tiene permisos suficientes para ejecutar "+params[:action]
      redirect_to :log_in # halts request cycle
    end
  end
  def find_dependencias
      $valid_sort=['nombre','codigo','organismo']
      if params[:sort]!=nil && $valid_sort.include?(params[:sort]) then
          $dir=params[:direction]=='desc' ? "desc":"asc"
          if params[:sort]=='organismo' then
              $order="organismos.nombre " + $dir
          else
              $order=params[:sort]+" " + $dir
          end
      else
          $order="nombre ASC"
      end
      #$s=params[:search] || params[:term]
      $s=params[:term] || session[:term]
      if $s!=nil then
          $s=$s.gsub('%', '\%').gsub('_', '\_')
      end
      if params.key?(:fixed_organismo_id)
              @dependencias = Dependencia.where(organismo_id: params[:fixed_organismo_id]).simpleSearch($s).reorder($order).paginate(:page => params[:page], :per_page => params[:rows])
      else
          @dependencias = Dependencia.simpleSearch($s).reorder($order).paginate(:page => params[:page], :per_page => params[:rows])
      end
  end


end

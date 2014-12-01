class TiposNotasController < ApplicationController
  before_filter :authenticate_user!
  before_action :authenticate_manager

  # GET /tipos_notas
  # GET /tipos_notas.json

  def index
    find_tipo_notas
  end
  def search
    find_tipo_notas
    respond_to do |format|
          format.html{render :partial=> "row_index"}
          format.js {  }
      end
  end

  # GET /tipos_notas/1
  # GET /tipos_notas/1.json
  def show
    @tipo_nota = TipoNota.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tipo_nota }
    end
  end

  # GET /tipos_notas/new
  # GET /tipos_notas/new.json
  def new
    @tipo_nota = TipoNota.new
    if (params[:remote]) then
        render :partial=>"form"
    else
        respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @tipo_nota }
        end
      end
  end

  # GET /tipos_notas/1/edit
  def edit
      @tipo_nota = TipoNota.find(params[:id])
      if params[:remote]
          render :partial=> "form"
          return;
      end
  end

  # POST /tipos_notas
  # POST /tipos_notas.json
  def create
    @tipo_nota = TipoNota.new(tipo_nota_params)

    respond_to do |format|
      if @tipo_nota.save
        format.html { redirect_to @tipo_nota, notice: 'El Tipo de nota se creo correctamente.' }
        format.json { render json: @tipo_nota, status: :created, location: @tipo_nota }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @tipo_nota.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /tipos_notas/1
  # PUT /tipos_notas/1.json
  def update
    @tipo_nota = TipoNota.find(params[:id])

    respond_to do |format|
      if @tipo_nota.update_attributes(tipo_nota_params)
        format.html { redirect_to @tipo_nota, notice: 'Tipo de nota se actualizo correctamente.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @tipo_nota.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /tipos_notas/1
  # DELETE /tipos_notas/1.json
  def destroy
    @tipo_nota = TipoNota.find(params[:id])
    begin
      @tipo_nota.destroy
      flash[:notice]= 'El Tipo de Notas se elimino correctamente.'
      #@msj_delete= 'El Tipo de Notas se elimino correctamente.'
    rescue ActiveRecord::DeleteRestrictionError => e
      flash[:error]="No se pudo eliminar porque otros dependen de el\n(#{e})"
      #@msj_delete = "No se pudo eliminar porque otros dependen de el\n(#{e})"
      #@error_delete = true
    end

    respond_to do |format|
      format.html { redirect_to tipos_notas_url }
      format.json { head :no_content }
    end
  end
  def delete
    $ok = true
    @tipo_nota = TipoNota.find(params[:id])
    begin
        @tipo_nota.destroy
    rescue ActiveRecord::DeleteRestrictionError => e
          $ok = false
    end
    respond_to do |format|
        format.html{redirect_to cargos_url, notice: "Se elimino el Tipo de Documentación "+@organismo.nombre}
        format.js{$ok}
    end
  end
private
  def tipo_nota_params
    params.require(:tipo_nota).permit(:descripcion, :nombre)
  end
  def can_execute
      if is_current_user_admin || is_current_user_sec_adm
        return true
      else
        flash[:error] = "No tiene permisos suficientes para ejecutar "+params[:action]
        redirect_to :log_in # halts request cycle
      end
    end
  def find_tipo_notas
      if params[:sort]!=nil && params[:sort]=="nombre" then
        $dir=params[:direction]=='desc' ? "desc":"asc"
        $order="nombre " + $dir
      else
        $order="nombre ASC"
      end
      $s=session[:term]#params[:search] || params[:term]
      if $s!=nil then
        $s=$s.gsub('%', '\%').gsub('_', '\_')
      end

      #@tipos_notas = TipoNota.search($s).order($order).paginate(:page => params[:page], :per_page => params[:rows])
      @tipos_notas = TipoNota.simpleSearch($s).order($order).paginate(:page => params[:page], :per_page => params[:rows])
  end
end

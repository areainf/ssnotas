class CargosController < ApplicationController
  before_action :set_cargo, only: [:show, :edit, :update, :destroy, :delete]
  before_filter :authenticate_user!
  before_action :authenticate_manager
  #before_action :can_execute

  # GET /cargos
  def index
    find_cargos
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @cargos.to_json(:only => [:id, :nombre])}
    end

  end

  #Realiza la busqueda de cargos
  #El texto a buscar viene en el parametro term
  #Retorna una vista parcial de row_index
  def search
      find_cargos
      logger.info params
      respond_to do |format|
          format.html{render :partial=> "row_index"}
          format.json { render json: @cargos }
          format.js {  }
      end

  end

  # GET /cargos/1
  def show
    @cargo = Cargo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cargo }
    end
  end

  # GET /cargos/new
  def new
    @cargo = Cargo.new
    if params[:remote]
        render :partial=> "form"
        return;
    end

  end

  # GET /cargos/1/edit
  def edit
    @cargo = Cargo.find(params[:id])
    if params[:remote]
        render :partial=> "form"
        return;
    end
  end

  # POST /cargos
  def create
    @cargo = Cargo.new(cargo_params)
    respond_to do |format|
      if @cargo.save
        format.html{
          logger.info("HTML")
          redirect_to @cargo, notice: 'El Cargo se creo correctamente.'}
        format.json {
          logger.info("JSON")
          render json: @cargo, status: :created, location: @cargo }
        format.js{}
      else
        format.html { render action: "new" }
        format.json { render json: @cargo.errors, status: :unprocessable_entity }
        format.js{}
      end
    end

  end

  # PATCH/PUT /cargos/1
  def update
    if @cargo.update(cargo_params)
      respond_to do |format|
          format.html{redirect_to @cargo, notice: 'El cargo se modifico correctamente.'}
          format.js{}
      end
    else
       respond_to do |format|
          format.html{render action: 'edit'}
          format.js{}
        end
    end
  end

  # DELETE /cargos/1
  def destroy
    @cargo.destroy
    redirect_to cargos_url, notice: 'El cargo se elimino.'
  end
  def delete
    $ok = true
    begin
        @cargo.destroy
    rescue ActiveRecord::DeleteRestrictionError => e
          $ok = false
    end
    respond_to do |format|
        format.html{redirect_to cargos_url, notice: 'El cargo se elimino.'}
        format.js{$ok}
    end
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cargo
      @cargo = Cargo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def cargo_params
      params.require(:cargo).permit(:nombre, :descripcion)
    end
=begin
    def can_execute
      if is_current_user_admin || is_current_user_sec_adm
        return true
      else
        flash[:error] = "No tiene permisos suficientes para ejecutar "+params[:action]
        redirect_to :log_in # halts request cycle
      end
    end
=end

    def find_cargos
        if params[:sort]!=nil && params[:sort]=="nombre" then
          dir=params[:direction]=='desc' ? "desc":"asc"
          order="nombre " + dir
        else
          order="nombre ASC"
        end

        s=params[:term] || session[:term]
        ###TENGO QUE ASEGURAR QUE PAGE Y ROW EXISTAN Y SEAN NUMERICOS
          p=  params[:page].to_i != 0 ? params[:page].to_i : 1
          r=  params[:rows].to_i != 0 ? params[:rows].to_i : 99999
        # si no hay texto de busqueda, entonces debe listar todos con page=>nil
        if !s.blank? then
          s=s.gsub('%', '\%').gsub('_', '\_')

          @cargos = Cargo.simpleSearch(s).order(order).paginate(:page => p, :per_page => r)
        else
            @cargos = Cargo.all().order(order).paginate(:page => p, :per_page => r)#:page => params[:page], :per_page => params[:rows])
        end

    end
end

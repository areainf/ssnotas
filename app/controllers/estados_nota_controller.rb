class EstadosNotaController < ApplicationController
  before_filter :authenticate_user!
  before_action :authenticate_manager
  before_action :set_estado_nota, only: [:show, :edit, :update, :destroy, :delete]

  # GET /estados_nota
  def index
    find_estados
    respond_to do |format|
      format.html {render :partial=> "row_index" unless !params[:remote ]}# index.html.erb
      format.json { render json: @organismos }
      format.js
    end
  end

  # GET /estados_nota/1
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @estado_nota }
    end
  end

  # GET /estados_nota/new
  def new
    @estado_nota = EstadoNota.new
    if (params[:remote]) then
        render :partial=>"form"
    else
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @estado_nota }
      end
    end
  end

  # GET /estados_nota/1/edit
  def edit
    render :partial=> "form" unless !params[:remote]
  end

  # POST /estados_nota
  def create
    @estado_nota = EstadoNota.new(estado_nota_params)
    respond_to do |format|
      if @estado_nota.save
        format.html { redirect_to @estado_nota, notice: 'El estado de nota se creo correctamente.' }
        format.json { render json: @estado_nota, status: :created, location: @estado_nota }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @estado_nota.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /estados_nota/1
  def update
    respond_to do |format|
      if @estado_nota.update_attributes(estado_nota_params)
        format.html { redirect_to @estado_nota, notice: 'El Esdo de Nota se actualizo correctamente.' }
        format.json { head :no_content }
        format.js{}
      else
        format.html { render action: "edit" }
        format.json { render json: @estado_nota.errors, status: :unprocessable_entity }
        format.js{}
      end
    end
  end

  # DELETE /estados_nota/1
  def destroy
    begin
      @estado_nota.destroy
    rescue ActiveRecord::DeleteRestrictionError => e
      flash[:error]="No se pudo eliminar porque otros dependen de el\n(#{e})"
    end
  end
def delete
    $ok = true
    begin
        @estado_nota.destroy
    rescue ActiveRecord::DeleteRestrictionError => e
          $ok = false
    end
    respond_to do |format|
        format.html{redirect_to cargos_url, notice: "Se elimino el Estado "+@estado_nota.nombre}
        format.js{$ok}
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_estado_nota
      @estado_nota = EstadoNota.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def estado_nota_params
      params.require(:estado_nota).permit(:nombre, :descripcion)
    end
    def find_estados
      $valid_sort=['nombre']
      if params[:sort]!=nil && $valid_sort.include?(params[:sort]) then
        $dir=params[:direction]=='desc' ? "desc":"asc"
        $order=params[:sort]+" " + $dir
      else
        $order="nombre ASC"
      end
      $s=session[:term]#params[:search] || params[:term]
      if $s!=nil then
        $s=$s.gsub('%', '\%').gsub('_', '\_')
      end
      @estados_nota = EstadoNota.simpleSearch($s).reorder($order).paginate(:page => params[:page], :per_page => params[:rows])

    end
end

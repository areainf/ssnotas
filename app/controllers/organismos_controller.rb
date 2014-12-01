class OrganismosController < ApplicationController
  before_filter :authenticate_user!
  before_action :authenticate_manager
  # GET /organismos
  # GET /organismos.json
  def index
    find_organismos
    respond_to do |format|
      format.html # index.html.erb
      format.json {render json: @organismos }
    end
  end


  #Realiza la busqueda de organismos
  #El texto a buscar viene en el parametro term
  #Retorna una vista parcial de row_index
  def search
      find_organismos
      respond_to do |format|
          format.html{render :partial=> "row_index"}
          format.json { render json: @dependencias }
          format.js {  }
      end
  end


  # GET /organismos/1
  # GET /organismos/1.json
  def show
    @organismo = Organismo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @organismo }
    end
  end

  # GET /organismos/new
  # GET /organismos/new.json
  def new
    @organismo = Organismo.new
    if (params[:remote]) then
        render :partial=>"form"
    else
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @organismo }
      end
    end
  end

  # GET /organismos/1/edit
  def edit
    @organismo = Organismo.find(params[:id])
    if(params[:id].to_i == Organismo::ID_FCEFQyN)
        flash[:error]="No se pude editar la Facultad de Ciencias Exactas"
        if params[:remote]
          render "noEdit", :layout=>false
        else
            redirect_to :back
        end
    else

        if params[:remote]
             render :partial=> "form"
            return;
        end
    end
  end

  # POST /organismos
  # POST /organismos.json
  def create
    @organismo = Organismo.new(organismo_params)

    respond_to do |format|
      if @organismo.save
        format.html { redirect_to @organismo, notice: 'El Organismo se creo correctamente.' }
        format.json { render json: @organismo, status: :created, location: @organismo }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @organismo.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /organismos/1
  # PUT /organismos/1.json
  def update
    @organismo = Organismo.find(params[:id])
    respond_to do |format|
      if @organismo.update_attributes(organismo_params)
        format.html { redirect_to @organismo, notice: 'El Organismo se actualizo correctamente.' }
        format.json { head :no_content }
        format.js{}
      else
        format.html { render action: "edit" }
        format.json { render json: @organismo.errors, status: :unprocessable_entity }
        format.js{}
      end
    end
  end

  # DELETE /organismos/1
  # DELETE /organismos/1.json
  def destroy
    if(params[:id].to_i == Organismo::ID_FCEFQyN)
        flash[:error]="No se pude eliminar la Facultad de Ciencias Exactas"
    else
        @organismo = Organismo.find(params[:id])
        begin
          @organismo.destroy
        rescue ActiveRecord::DeleteRestrictionError => e
          flash[:error]="No se pudo eliminar porque otros dependen de el\n(#{e})"
        end
    end
    respond_to do |format|
      format.html { redirect_to organismos_url }
      format.json { head :no_content }
    end
  end
def delete
    $ok = true
    @organismo = Organismo.find(params[:id])
    begin
        @organismo.destroy
    rescue ActiveRecord::DeleteRestrictionError => e
          $ok = false
    end
    respond_to do |format|
        format.html{redirect_to cargos_url, notice: "Se elimino el Organismo "+@organismo.nombre}
        format.js{$ok}
    end
  end

private
  def organismo_params
    params.require(:organismo).permit(:codigo, :descripcion, :nombre, :alias)
  end
  def find_organismos

     $valid_sort=['nombre','codigo']
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

    #@organismos = Organismo.search($s).reorder($order).paginate(:page => params[:page], :per_page => params[:rows])
    @organismos = Organismo.simpleSearch($s).reorder($order).paginate(:page => params[:page], :per_page => params[:rows])


  end
end

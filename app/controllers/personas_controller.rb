class PersonasController < ApplicationController
  before_action :set_persona, only: [:show, :edit, :update, :destroy,:delete]
  before_filter :authenticate_user!
  before_action :authenticate_manager
  # GET /personas
  def index
    find_personas
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @personas.to_json(:only => [:id, :apellido, :nombre], :methods => "fullname")}
    end
  end

  #Realiza la busqueda de dependencias
  #El texto a buscar viene en el parametro term
  #Retorna una vista parcial de row_index
  def search
      find_personas
      respond_to do |format|
          format.html{render :partial=> "row_index"}
          format.json { render json: @personas }
          format.js {  }
      end
  end

  # GET /personas/1
  def show
    @persona = Persona.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @persona }
    end
  end

  # GET /personas/new
  def new
    @persona = Persona.new
     respond_to do |format|
      format.html {
                    if params[:remote]
                      # render :partial=> "form"
                      render :partial=> "/personas/bt/form"
                    end
                  }
      format.json { render json: @persona }
    end
  end

  # GET /personas/1/edit
  def edit
    if params[:remote]
        render :partial=> "form"
        return;
    end
  end

  # POST /personas
  def create
    @persona = Persona.new(persona_params)
    respond_to do |format|
      if @persona.save
        format.html {redirect_to edit_persona_path(@persona), notice: 'La Persona se creo correctamente. Ahora puede asociarle cargos'}
        format.json { render json: @persona, status: :created, location: @persona }
        format.js{}
      else
        format.html { render action: "new" }
        format.json { render json: @persona.errors, status: :unprocessable_entity }
        format.js{}
      end
    end

  end

  # PATCH/PUT /personas/1
  def update
    if @persona.update(persona_params)
      respond_to do |format|
          format.html{redirect_to @persona, notice: 'Los datos de la Persona se modificaron correctamente.'}
          format.js{}
      end
    else
      respond_to do |format|
          format.html{render action: 'edit'}
          format.js{}
      end
    end
  end

  # DELETE /personas/1
  def destroy
    begin
     @persona.destroy
     flash[:message]='Se ha eliminado a la Persona.'
    rescue ActiveRecord::DeleteRestrictionError => e
      flash[:error]="No se pudo eliminar porque otros dependen de el\n(#{e})"
    end

    redirect_to personas_url
  end

  def delete
    $ok = true
    begin
        @persona.destroy
    rescue ActiveRecord::DeleteRestrictionError => e
          $ok = false
    end
    respond_to do |format|
        format.html{redirect_to persona_url, notice: 'La Persona se elimino.'}
        format.js{$ok}
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_persona
      @persona = Persona.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def persona_params
      params.require(:persona).permit(:nombre, :apellido, :email)
    end

    def find_personas
       #@personas = Persona.all
        $valid_sort=['nombre','apellido','email']
        if params[:sort]!=nil && $valid_sort.include?(params[:sort]) then
          $dir=params[:direction]=='desc' ? "desc":"asc"
          $order=params[:sort]+" " + $dir
        else
          $order="apellido, nombre  ASC"
        end
        $s=params[:term] || session[:term]
        if $s!=nil then
           $s=$s.gsub('%', '\%').gsub('_', '\_')
        end
        @personas = Persona.search($s).reorder($order).paginate(:page => params[:page], :per_page => params[:rows])

    end
end

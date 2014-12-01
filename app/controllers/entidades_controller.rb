class EntidadesController < ApplicationController
  include EntidadesHelper
  respond_to :html, :json, :js
  helper_method :parse_text_to_cargo_persona
  before_action :set_entidad, only: [:show, :edit, :update, :destroy, :change_es_facultad, :change_es_actual, :delete]
  #before_action :can_execute
  before_filter :authenticate_user!
  before_action :authenticate_manager
  # GET /entidades
  def index
    if (params[:persona_id])
      return self.entidades_persona
    else
      find_entidades
    end
  end

  #Realiza la busqueda de entidades
  #El texto a buscar viene en el parametro term
  #Retorna una vista parcial de row_index
  def search
      find_entidades
      respond_to do |format|
          format.html{render :partial=> "row_index"}
          format.json { render json: @entidades }
          format.js {}
      end
  end

  # GET /entidades/1
  def show
  end


  # GET /entidades/new
  def new
    #Invoca al formulario para dar de alta una entidad.
    #Los posibles parametros son
    # fixed_persona_id: indica el id de la persona, no se puede seleccionar otra
    # fixed_dependencia_id: indica el id de la dependencia, no se puede seleccionar otra
    # fixed_organismo_id: indica el id del organismo, solo se listaran las dependencias de este organismo
    # fixed_cargo_id: indica el id del cargo, no se puede seleccionar otro
    # remote: si es un llamado remoto, no hay que devolver con layout
    # cargo_persona: indica que se procesa una nota temporal

    @entidad = Entidad.new
    if params.key?(:fixed_persona_id)
        @entidad.persona=Persona.find(params[:fixed_persona_id])
        @entidad.persona_id=params[:fixed_persona_id]
    elsif params.key?(:persona_id)
      @entidad.persona=Persona.find(params[:persona_id])
    end
    if params.key?(:fixed_cargo_id)
        @entidad.cargo=Cargo.find(params[:fixed_cargo_id])
        @entidad.cargo_id=params[:fixed_cargo_id]
    elsif params.key?(:cargo_id)
        @entidad.cargo=Cargo.find(params[:cargo_id])
    end

    #@personas = Persona.all
    #@cargos = Cargo.all
    #@usuarios = User.missing
    if params.key?(:fixed_dependencia_id)
        ##Este es el caso donde se debe agregar una entidad a una dependencia, y no permitir seleccionar la dependencia
         @entidad.dependencia = Dependencia.find(params[:fixed_dependencia_id])
         @entidad.dependencia_id = params[:fixed_dependencia_id]
    else
         if params.key?(:fixed_organismo_id)
              @dependencias = Dependencia.where(organismo_id: params[:fixed_organismo_id])
         else
              @dependencias = Dependencia.all
         end
         if params.key?(:dependencia_id)
               @entidad.dependencia = Dependencia.find(params[:dependencia_id])
               @entidad.dependencia_id = params[:dependencia_id]
         end
    end

    # SI VIENE EL PARAMETRO cargo_persona, significa que se esta procesando
    # una nota temporal, con lo cual habria que buscar
    # si existiese el cargo y/o la persona  setearselo a @entidad
    # si no existiese en la vista deberia quedar escrito para que lo agregue
    # el formato de cargo_persona deberia ser "cargo: apellido, nombre"
    if (params[:cargo_persona])
        @cargopersona= parse_text_to_cargo_persona(params[:cargo_persona])
        params[:persona_fullname]=@cargopersona[:persona_text]
        params[:cargo_fullname]=@cargopersona[:cargo_text]
        @entidad.persona=@cargopersona[:persona]
        @entidad.persona_id=@entidad.persona.id unless @entidad.persona.nil?
        @entidad.cargo = @cargopersona[:cargo]
        @entidad.cargo_id = @entidad.cargo.id unless @entidad.cargo.nil?
    end
    if (params[:remote]) then
      if (params[:bt])
        render "/entidades/bt/new", :layout => false
      else
        # render "new", :layout => false
        render "/entidades/bt/new", :layout => false

      end
    else
        respond_to do |format|
          format.html
        end
    end
  end

  # GET /entidades/1/edit
  def edit
    @entidad = Entidad.find(params[:id])
    @dependencias = Dependencia.all
    @personas = Persona.all
    @cargos = Cargo.all
    @usuarios = User.missing
    if (params[:remote]) then
        render "/entidades/bt/edit", :layout => false
        # render "edit", :layout => false
    else
        respond_to do |format|
          format.html
        end
    end
  end

  # POST /entidades
  def create
    @entidad = Entidad.new(entidad_params)

    ok=true
    if params[:entidad][:es_actual] && params[:replace_all_es_actual]
      #logger.info("Setear a esta entidad como actual y reemplazar a las otras")
        dep = params[:entidad][:dependencia_id]
        crg = params[:entidad][:cargo_id]
        begin
            Entidad.transaction do
                Entidad.where(:dependencia_id => dep, :cargo_id => crg).update_all("es_actual = 0")
                @entidad.save!
            end
       rescue ActiveRecord::RecordInvalid => invalid
            ok=@entidad.save
            flash[:error] = "No se pudo actualizar el estado de las demas entidades"
       end

    else
      ok=@entidad.save
      if ok
          flash[:notice] =  'La Entidad se creo correctamente.'
      end
    end
    if ok
        respond_to do |format|
            format.html { redirect_to @entidad}
            format.json {
                # @entidad.joins(:dependencia).joins(:cargo).joins(:persona)
                #render :json => @entidad.to_json({:methods => :fullname, :only => [:id, :es_facultad ]}), status: :created, location: @entidad
                @hash_entidad = @entidad.as_json({:methods => [:fullname, :alias_or_fullname], :only => [:id, :es_facultad ]})
                if (params.key?(:hidden_params) && params[:hidden_params].size > 0)
                  @hashjson = @hash_entidad.merge(params[:hidden_params])
                else
                  @hashjson = @hash_entidad
                end
                render :json => @hashjson.to_json, status: :created, location: @entidad
            }
            # format.js             
        end
    else
        respond_to do |format|
            # format.html {
            #   render action: "new"
            # }
            format.json {
              render json: @entidad.errors, status: :unprocessable_entity
            }
            # format.js 
        end
    end
        # respond_to do |format|
        #     format.html {
        #       render action: "new"
        #     }
        #     format.json {
        #       render json: @entidad.errors, status: :unprocessable_entity
        #     }
        #     # format.js 
            
        # end
  end

  # PATCH/PUT /entidades/1
  def update
    if @entidad.update(entidad_params)
      respond_to do |format|
            format.html { redirect_to @entidad}
            format.json { render json: @hash_entidad = @entidad.to_json}
      end
    else
      respond_to do |format|
        format.html { redirect_to @entidad}
        format.json {render json: @entidad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entidades/1
  def destroy
    @error_delete=false
    @msj_delete=""
    begin
      @entidad.destroy
      flash[:notice]= 'La entidad se elimino correctamente.'
      @msj_delete= 'La entidad se elimino correctamente.'
    rescue ActiveRecord::DeleteRestrictionError => e
      flash[:error]="No se pudo eliminar porque otros dependen de el\n(#{e})"
      @msj_delete = "No se pudo eliminar porque otros dependen de el\n(#{e})"
      @error_delete = true
    end
    redirect_to entidades_url
  end
  #lo mismo que destroy pero solo json
  def delete
    error_delete=false
    msj_delete=""
    begin
      @entidad.destroy
      msj_delete= 'La entidad se elimino correctamente.'
    rescue ActiveRecord::DeleteRestrictionError => e
      logger.info(e)
      msj_delete = "No se pudo eliminar porque otros dependen de el\n(#{e})"
      error_delete = true
    end
    respond_to do |format|
      format.json {
          result = {:error => error_delete,:msj => msj_delete}
          render json: result
      }
      format.js{$ok = !error_delete}
    end

  end
  # change es facultad /entidades/1
  def change_es_facultad
    params = ActionController::Parameters.new(es_facultad: !@entidad.es_facultad)
    respond_to do |format|
      if @entidad.update(params)
            format.json {
                result = {:error => false}
                render json: result
            }
            format.html{
              redirect_to entidades_url, notice: 'Se cambio el estado es miembro de la Facultad correctamente.'
            }
       else
            format.json {
                result = {:error => true}
                render json: result
            }
            format.html {redirect_to entidades_url, notice: 'Ocurrio un error al realizar el cambio.'}
       end
    end




  end
  # change es actual /entidades/1
  def change_es_actual
    params = ActionController::Parameters.new(es_actual: !@entidad.es_actual)
    respond_to do |format|
      if @entidad.update(params)
            format.json {
                result = {:error => false}
                render json: result
            }
            format.html{
              redirect_to entidades_url, notice: 'Se cambio el estado es Actual correctamente.'
            }
       else
            format.json {
                result = {:error => true}
                render json: result
            }
            format.html {redirect_to entidades_url, notice: 'Ocurrio un error al realizar el cambio.'}
       end
    end

  end
 def find_remitentes
    $s=params[:term]
    if(params[:dependencia_id])
        @entidades = Entidad.joins(:dependencia).where(:dependencia_id => params[:dependencia_id]).joins(:cargo).joins(:persona).search($s)
    else
        #@entidades = Entidad.joins(:dependencia).joins(:cargo).joins(:persona).search($s)
        @entidades = Entidad.search($s)
    end
    #format.json { render :json => @entidades.to_json(:only => [:id, :apellido, :nombre], :include =>{:autoridad =>{:only => :cargo}})}

    respond_to do |format|
        format.json { render :json => @entidades.to_json({:methods => :alias_or_fullname, :only => [:id ]})}
        #format.json { render :json => @entidades.to_json()}
    end
 end

 def find_destinatarios
    $s=params[:term]
    ##@entidades = Entidad.joins(:dependencia).joins(:cargo).joins(:persona).search($s)
    @entidades = Entidad.search($s)

    respond_to do |format|
        format.json { render :json => @entidades.to_json({:methods => :alias_or_fullname, :only => [:id ]})}
    end
 end

  #Por parametro tiene que venir dependencia_id, cargo_id
  #retorna listado de todas las persona con este cargo en la dependencia que esten activos
  def get_actual_cargo_dependencia
    @entidades = Entidad.where(:cargo_id => params[:cargo_id],:dependencia_id => params[:dependencia_id],:es_actual => true)
    render :json => @entidades.to_json({:methods => :cargoname, :only => [:id ]})
  end


  #lista todas las entidades donde esta  una persona
  def entidades_persona
    @persona = Persona.find(params[:persona_id])
    @entidad = Entidad.new
    @cargos = Cargo.all
    @dependencias = Dependencia.all
    respond_to do |format|
        format.html { render "/entidades/persona/index"}

    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entidad
      @entidad = Entidad.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def entidad_params
      params.require(:entidad).permit(:persona_id, :dependencia_id, :cargo_id, :es_facultad, :user_id, :es_actual)
    end
  def find_entidades
        $valid_sort=['persona','dependencia','cargo', 'es_facultad', 'actual']
        $order=""
        logger.info { params }
        if params[:sort]!=nil && $valid_sort.include?(params[:sort]) then
          $dir=params[:direction]=='desc' ? "desc":"asc"
          if params[:sort]=='dependencia'
              $order="dependencias.nombre " + $dir
          elsif params[:sort]=='cargo'
              $order="cargos.nombre " + $dir
          elsif params[:sort]=='es_facultad'
              $order="es_facultad " + $dir
          elsif params[:sort]=='actual'
              $order="es_actual " + $dir
          else
              $order="personas.apellido " + $dir + ", personas.nombre " + $dir
          end
        end
        $s=session[:term]#params[:search] || params[:term]
        if $s!=nil then
          $s=$s.gsub('%', '\%').gsub('_', '\_')
        end
        #@entidades = Entidad.joins(:dependencia).joins(:cargo).joins('LEFT JOIN personas on personas.id=entidades.persona_id').search($s).reorder($order).paginate(:page => params[:page], :per_page => params[:rows])
        @entidades = Entidad.simpleSearch($s).reorder($order).paginate(:page => params[:page], :per_page => params[:rows])
    end

end

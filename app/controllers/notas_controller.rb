class NotasController < ApplicationController
  include EntidadesHelper
  include ApplicationHelper
  helper_method :parse_text_to_cargo_persona
  #before_action :can_execute
  before_filter :authenticate_user!
  before_action :authenticate_manager, :clear_notice_side

  # GET /notas
  # GET /notas.json
  def index
      # @notas = Nota.paginate(:page => params[:page], :per_page => params[:rows])
      find_nota
      # respond_to do |format|
      #   format.html {render "/notas/bt/index" }
      #   format.json { render json: NotasDatatable.new(view_context) }
      # end
       @tipos_notas=TipoNota.all
       respond_to do |format|
         format.html
         format.json {render json: @notas }
         format.js
       end
  end

  #Realiza la busqueda de notas
  #El texto a buscar viene en el parametro term
  #Retorna una vista parcial de row_index
  def search
      find_nota
      respond_to do |format|
          format.html{render :partial=> "row_index"}
          format.js {  }
      end
  end

  #Realiza la busqueda de notas_pendientes
  #El texto a buscar viene en el parametro term
  #Retorna una vista parcial de row_index
  def search_pendientes
    session[:term] = params[:term]
      find_notas_pendientes
      #@notas_temporales.paginate(:page => params[:page], :per_page => params[:rows])

       respond_to do |format|
          format.html{render :partial=> "row_pendientes"}
          format.js {  }
      end
  end

  # GET /notas_temporales
  # Esto lo deberia ejecutar solo el administrador o mesa de entrada
  def pendientes
    #@notas_temporales = NotaTemporal.where(:estado => Nota::ESTADO_PENDIENTE).paginate(:page => params[:page], :per_page => params[:rows])
    find_notas_pendientes
    @notas_temporales.paginate(:page => params[:page], :per_page => params[:rows])
  end

# GET /notas/1/editpendiente
  def edit_pendiente
    @nota_temporal = NotaTemporal.find(params[:id])
    if !@nota_temporal.ingresada?
        @nota = @nota_temporal.to_nota
        #flash[:notice]="SOLO TENGO QUE ENTRAR ACA SI LA NOTA NO FUE PREVIAMENTE AGREGADA,HACER EL CHEQUEO EN EL CONTROLADOR DONDE ESTA ESTE TEXTO"
        if  @nota_temporal.remitente_id.nil?
          rem = parse_text_to_cargo_persona(@nota_temporal.texto_remitente)
          if !rem[:cargo].nil? && !rem[:persona].nil?
            r = Entidad.where(:cargo_id => rem[:cargo].id,  :persona_id => rem[:persona].id, :dependencia_id =>@nota_temporal.dependencia_id).first
            @nota_temporal.remitente_id = r.id unless r.nil?
          end
        end
        if  @nota_temporal.destinatario_id.nil?
          rem = parse_text_to_cargo_persona(@nota_temporal.texto_destinatario)
          if !rem[:cargo].nil? && !rem[:persona].nil?
            d = Entidad.where(:cargo_id => rem[:cargo].id,  :persona_id => rem[:persona].id, :dependencia_id =>Organismo::ID_FCEFQyN).first
            @nota_temporal.destinatario_id = d.id unless d.nil?
          end
        end
        @tipos_notas = TipoNota.all
    else
        flash[:error] = "El Documento ya ha sido procesado"
        redirect_to action: "pendientes"
    end

  end

  #POST Procesa la accion de edit_pendiente
  # da de alta la nota
  def process_pendiente
      @nota_temporal = NotaTemporal.find(params[:nota_temporal_id])
      @nota = Nota.new(nota_params_pendiente)
      @nota.fecha_ingreso = Time.now
      #si es de salida o entrada
      @nota.tipo = Nota::TIPO_ENTRADA
      #segun si es un administrativo o departamento
      @nota.estado = Nota::ESTADO_CIRCULACION
      @nota.cargado_mesa_entrada = false
      @u = current_user
      @nota.recibido_por_id = @u.id
      ok=true
      begin
          Nota.transaction do
              @nota.save!
              @nota_temporal.update_attributes!(:nota_id => @nota.id, :estado => Nota::ESTADO_CIRCULACION)
          end

      rescue ActiveRecord::RecordInvalid => invalid
          flash[:error] = invalid.message
          ok=false

      end

      respond_to do |format|
      if ok
        format.html { redirect_to @nota, notice: 'El Documento se creo correctamente.' }
        format.json { render json: @nota, status: :created, location: @nota }
      else
        format.html {
                     redirect_to :back
                    }
        format.json { render json: @nota.errors, status: :unprocessable_entity }
      end
    end
  end



  # GET /notas/1
  # GET /notas/1.json
  def show
    @nota = Nota.find(params[:id])
    current_uri = request.env['PATH_INFO']
    generate_barcode(@nota.codigo)
    @barcode = current_uri+'/barcode'
    # @nota_attachments = @nota.nota_attachments.all
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @nota }
    end
  end
  def barcode
     @nota = Nota.find(params[:id])
     path = store_dir_barcode(@nota.codigo)
     #send_data path, :type => 'image/png', :filename => 'barcode.png'
     render :text => open(path, "rb").read
  end
  # GET /notas/new
  # GET /notas/new.json
  def new
      #Si es administrador o mesa de entrada
      if is_current_user_admin || is_current_user_sec_adm
            @nota = Nota.new
            @nota.fecha_ingreso = Time.now
            @dependencias = Dependencia.all
            # @estados_notas = EstadoNota.all
            #@remitentes = Remitente.all
            #@destinatarios = Destinatario.all
            @tipos_notas = TipoNota.all
            if params[:parent_id].present?
              @parent = Nota.find(params[:parent_id])
            end
            @nota_attachment = @nota.nota_attachments.build

            respond_to do |format|
              format.html {render "/notas/bt/new" }
              format.json { render json: @nota }
            end
        end
  end

  # GET /notas/1/edit
  def edit
      @nota = Nota.find(params[:id])
      @tipos_notas = TipoNota.all
      render "/notas/bt/edit" 
  end

  # POST /notas
  # POST /notas.json
  # Hay que tener en cuenta si es una nota de entrada o de salida, si fue cargada por un administrativo o desde un departamento
  def create
    nota_orig = Nota.new(nota_params)
    nota_orig.persona_ref_tokens = params["persona_ref_tokens"].split(",")
    params[:destinatarios]= params["destinatarios_token"].split(",")
    if !params[:destinatarios].nil? && params[:destinatarios].length > 0
          nota_orig.fecha_carga = Time.now
          #si es un administrativo
          nota_orig.fecha_ingreso = Time.now
          #si es de salida o entrada
          #nota_orig.tipo = Nota::TIPO_ENTRADA
          nota_orig.estado = Nota::ESTADO_CIRCULACION
          nota_orig.cargado_mesa_entrada = true
          @u = current_user
          nota_orig.cargado_por_id = @u.id
          nota_orig.recibido_por_id = @u.id
          #:parent_id,

          arr_notas = Array.new
          prepare_notas_ok=true
          params[:destinatarios].each do |value|
              @nota = nota_orig.dup
              @nota.destinatario_id =  value
              @nota.created_at = Time.now
              @nota.updated_at = Time.now
              if !@nota.valid?
                prepare_notas_ok = false
                break
              end
              arr_notas.push(@nota)
          end
          if prepare_notas_ok
                ok=true
                begin
                    Nota.transaction do
                      arr_notas.each do | nota |
                      @nota.save
                      end
                      # params[:destinatarios].each do |value|
                      #   @nota = nota_orig.dup
                      #   @nota.destinatario_id =  value
                      #   @nota.created_at = Time.now
                      #   @nota.updated_at = Time.now
                      #   # @nota.save!
                      #   if @nota.save
                      #     params[:nota_attachments]['filescan'].each do |a|
                      #     @nota_attachment = @nota.nota_attachments.create!(:filescan => a, :nota_id => @nota.id)
                      #     end
                      #   end
                      # end
                    end                
                rescue ActiveRecord::RecordInvalid => invalid
                    ok=false
                    flash[:error] = "No se pudo guardar el Documento"
                    puts  invalid.message
                    puts invalid.backtrace.inspect
                end
          end
    else
      flash[:error] = "Debe seleccionar al menos un destinatario"
      ok=false
    end
     respond_to do |format|
        if ok
            format.html { redirect_to @nota, notice: 'El Documento se creo correctamente.' }
            format.json { render json: @nota, status: :created, location: @nota }
        else
            unless defined? @nota
              #seteamos los atributos a nota
              @nota = Nota.new(nota_params)
            end
            format.html {
                       @dependencias = Dependencia.all
                       #@remitentes = Remitente.all
                       #@destinatarios = Destinatario.all
                       @tipos_notas = TipoNota.all
                       # render action: "new"
                       render "/notas/bt/new"
                      }
            format.json { render json: @nota.errors, status: :unprocessable_entity }
        end
     end
  end

  # PUT /notas/1
  # PUT /notas/1.json
  def update
    @nota = Nota.find(params[:id])
    @u = current_user
    if (params[:nota][:filescan].nil?)
      params[:nota][:recibido_por_id] = @u.id
      if is_current_user_admin || is_current_user_sec_adm
         params[:nota][:estado] = Nota::ESTADO_CIRCULACION
      end

      respond_to do |format|
        if @nota.update_attributes(nota_params_update)
          format.html { redirect_to @nota, notice: 'El Documento se modifico correctamente.' }
          format.json { head :no_content }
        else

          format.html {
            @tipos_notas = TipoNota.all
            render action: "edit"
          }
          format.json { render json: @nota.errors, status: :unprocessable_entity }
        end
      end
    else
      @nota.nota_attachments.create(params[:nota])
       redirect_to @nota
    end
  end

  # DELETE /notas/1
  # DELETE /notas/1.json
  def destroy
    @nota = Nota.find(params[:id])
    begin
      @nota.logic_destroy
    #rescue ActiveRecord::DeleteRestrictionError => e
    rescue StandardError => e
      flash[:error]="Error al Eliminar el Documento\n(#{e})"
    end

    respond_to do |format|
      format.html { redirect_to notas_url }
      format.json { head :no_content }
    end
  end

  def new_dependencia
    render :partial=> "form_new_dependencia"
  end
  def create_dependencia
    @dependencia = Dependencia.new(params[:dependencia])

    respond_to do |format|
      if @dependencia.save
        format.html { redirect_to @dependencia, notice: 'La Dependencia se creo correctamente.' }
        format.json { render json: @dependencia, status: :created, location: @dependencia }
      else
        format.html {
                     render action: "new", controller: "dependencias"
                    }
        format.json {
                render json: @dependencia.errors, status: :unprocessable_entity
                }
      end
    end
  end
  
  #Llega un identificador del codigo representando al parent_id para asociar la nota
  def asociar
    @nota = Nota.find(params[:id])       
    parent_id = nil || params[:parent_codigo]
    if @nota.update_attributes({:parent_id => parent_id})
      flash[:message] = "Se actualizo la Asociación"
      @nota.reload
    else
       flash[:error] = "Ocurrio un error al Intenter actualizar la Asociación"
    end
    render :partial => "/notas/bt/association"
      #  if ! params[:parent_codigo].present?
      #      @nota.update_attributes({:parent_id=>nil})
      #      flash[:notice_side]="Se elimino la Asociación"
      #  else
      #      s = params[:parent_codigo].gsub('%', '\%').gsub('_', '\_').gsub("'","\'").gsub('"','\"')
      #      @parent = Nota.where(:codigo =>s).first

      #      if ! @parent.nil?
      #         if @parent.id != @nota.id
      #             @nota.update_column(:parent_id,@parent.id)
      #             flash[:notice_side]="Se completo la Asociación"
      #         else
      #             flash[:notice_side]="No se puede asociar con él mismo"
      #         end
      #      else
      #        flash[:notice]="No se encontro el Documento"
      #      end
      # end
      #  respond_to do |format|
      #     format.js{}
      #  end
  end

  ##Por ahora solo busca notas con cierto tema, es para el autocomplete de tema
  def find_by
    field=params[:field]
    if field=="tema"
        value = params[:term].gsub('%', '\%').gsub('_', '\_').gsub("'","\'").gsub('"','\"')
        notas= Nota.select(field).where("#{field} LIKE :prefix", prefix: "%#{value}%").distinct
    else
        notas= nil
    end
    respond_to do |format|
      format.json { render :json =>  notas.to_json }
    end
  end


  def shortcut
    @nota = Nota.find(params[:id])
    respond_to do |format|
      format.html {render :partial=> "shortcut"}
      format.json { render json: @nota }
    end
  end

  def shortcut_pendiente
    @nota_temporal = NotaTemporal.find(params[:id])
    respond_to do |format|
      format.html {render :partial=> "shortcut_pendiente"}
      format.json { render json: @nota_temporal }
    end
  end

  def att
    @nota = Nota.find(params[:id])
  end

  def att_update
    @nota = Nota.find(params[:id])
    if params[:images]
        # The magic is here ;)
        params[:images].each { |image|
          @nota.attachments.create(image: image)
        }
        format.html { redirect_to @nota, notice: 'Archivos subidos correctamente.' }
        format.json { head :no_content }
    else
      format.html { render action: "att" }
      format.json { render json: @nota.errors, status: :unprocessable_entity }
    end 
  end

 # =====================================================================================================
 # =====================================================================================================
 # =====================================================================================================
 # =====================================================================================================
 # =====================================================================================================

private
  #Elimina la variable notice_side la cual se encarga de mostrar resultados del lado izquierdo de las notas
  #como por ejemplo resultado de asociaciones
  def clear_notice_side
    if flash[:notice_side].present?
        flash[:notice_side]=nil
    end
  end

  def nota_params
    params.require(:nota).permit(:codigo, :descripcion, :destinatario_id, :fecha_eliminada, :fecha_nota, :fecha_ingreso, :remitente_id, :tema, :tipo_nota_id, :tipo, :estado, :cargado_mesa_entrada, :parent_id, :nro_referencia, :estado_nota_id, post_attachments_attributes: [:id, :post_id, :avatar])
  end
  def nota_params_update
    params.require(:nota).permit(:descripcion, :destinatario_id,  :fecha_nota,  :remitente_id, :tema, :tipo_nota_id,:recibido_por_id, :cargado_por_id, :tipo, :estado, :nro_referencia, :estado_nota_id)
  end
  def nota_params_pendiente
    params.require(:nota).permit(:codigo, :descripcion, :destinatario_id,  :fecha_nota, :fecha_ingreso, :fecha_carga, :remitente_id, :tema, :tipo_nota_id, :tipo, :cargado_por_id, :nro_referencia, :estado_nota_id)
  end

  def find_nota
            #INICIO ORDENACION
      $valid_sort=['tema','remitente','destinatario','fecha_nota','fecha_ingreso','tipo_nota_id']
      sort="comun"
      if params[:sort]!=nil && $valid_sort.include?(params[:sort]) then
          $dir=params[:direction]=='desc' ? "desc":"asc"
          if params[:sort]=='remitente' || params[:sort]=='destinatario' then
              $order="personas.apellido #{$dir}, personas.nombre  #{$dir}"
              sort= params[:sort] == 'remitente' ? "remitente" : "destinatario"
          else
              $order=params[:sort]+" " + $dir
          end
      else
          $order="fecha_nota DESC"
      end
      #FIN ORDENACION
      s=session[:term] || params[:term] #params[:search] || params[:term]
      if s!=nil then
         s = s.gsub('%', '\%').gsub('_', '\_').gsub("'","\'").gsub('"','\"')
      end
      if !s.blank?
          # q = "%#{s}%"

          ####@notas = Nota.simpleSearch(s).paginate(:page => params[:page], :per_page => params[:rows])
          @notas = Nota.simpleSearch(s)
      else
          ####@notas = Nota.all().paginate(:page => params[:page], :per_page => params[:rows])
          @notas = Nota.all()
      end
      if params[:tipo_nota_id].present? && ! params[:tipo_nota_id].blank?
          @notas =@notas.where(:tipo_nota_id => params[:tipo_nota_id])
      end
      if params[:fecha_desde].present? && ! params[:fecha_desde].blank? && params[:fecha_hasta].present? && ! params[:fecha_hasta].blank?
          date_from = params[:fecha_desde].to_date
          date_to = params[:fecha_hasta].to_date
          @notas =@notas.where("fecha_nota BETWEEN ? and ?",date_from,date_to)
      end
       @notas=@notas.paginate(:page => params[:page], :per_page => params[:rows])

      if sort == "comun"
          @notas = @notas.order($order)
      elsif sort == "remitente"
          @notas = @notas.joins(:remitente=>:persona).order($order)
      else
          @notas = @notas.joins(:destinatario=>:persona).order($order)
      end
      # @notas = @notas.paginate(:page => params[:page], :per_page => params[:rows])
  end
  def find_notas_pendientes

      $valid_sort=['remitente','destinatario','fecha_nota','fecha_carga','tipo_nota_id','estado','tema']
      sort="comun"
      if params[:sort]!=nil && $valid_sort.include?(params[:sort]) then
          $dir=params[:direction]=='desc' ? "desc":"asc"
          if params[:sort]=='remitente' || params[:sort]=='destinatario' then
              $order="personas.apellido #{$dir}, personas.nombre  #{$dir}"
              sort = params[:sort] == "remitente" ? "remitente" : "destinatario"
          else
              $order=params[:sort]+" " + $dir
          end
      else
          $order="fecha_nota ASC"
      end
      #FIN ORDENACION

      s=session[:term]#params[:search] || params[:term]
      if s!=nil then
         s = s.gsub('%', '\%').gsub('_', '\_').gsub("'","\'").gsub('"','\"')
      end
      if !s.blank?
          q = "%#{s}%"
          ent = Entidad.search(s).distinct.select("entidades.id")
          ####@notas_temporales = NotaTemporal.joins(:remitente, :tipo_nota, :destinatario).where( "tema like ? or remitente_id in (?) or destinatario_id in (?)",q,entRem,entDest).paginate(:page => params[:page], :per_page => params[:rows])
          #@notas_temporales = NotaTemporal.where(:estado => Nota::ESTADO_PENDIENTE).where( "tema like ? or codigo like ? or descripcion like ? or texto_remitente like ? or texto_destinatario like ? or remitente_id in (?) or destinatario_id in (?)  or DATE_FORMAT(fecha_nota,'%d%m%Y') like ? or DATE_FORMAT(fecha_carga,'%d%m%Y') like ? ",q,q,q,q,q,ent,ent,q,q).distinct.paginate(:page => params[:page], :per_page => params[:rows])
          @notas_temporales = NotaTemporal.where(:estado => Nota::ESTADO_PENDIENTE).simpleSearch(s).distinct.paginate(:page => params[:page], :per_page => params[:rows])
      else
          @notas_temporales = NotaTemporal.where(:estado => Nota::ESTADO_PENDIENTE).distinct.paginate(:page => params[:page], :per_page => params[:rows])
      end
      if sort == "comun"
          @notas_temporales = @notas_temporales.order($order)
      elsif sort == "remitente"
          #@notas_temporales = @notas_temporales.joins(:remitente=>:persona).order($order)
          #Lo anterior anda, el tema es cuando remitente no esta asociada a una persona sino a un texto
          @notas_temporales = @notas_temporales.joins("LEFT JOIN personas  on remitente_id=personas.id").order($order)

      else
          #@notas_temporales = @notas_temporales.joins(:destinatario=>:persona).order($order)
          #Lo anterior anda, el tema es cuando destinatario no esta asociada a una persona sino a un texto
          @notas_temporales = @notas_temporales.joins("LEFT JOIN personas  on destinatario_id=personas.id").order($order)
      end

  end
end

module ApplicationHelper

require 'barby'
require 'barby/barcode/code_39'
require 'barby/barcode/ean_13'

require 'barby/outputter/png_outputter'

    def sortable(column, title = nil)
      title ||= column.titleize
      direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
      params1=params.dup
      params1[:sort]=column
      params1[:direction]=direction
      params1[:rows]=params[:rows] unless params[:rows].nil?
      params1[:page]=params[:page] unless params[:page].nil?
      link_to title, params1
      #link_to title, :sort => column, :direction => direction
    end
    def generate_barcode(data,symbology = 'Code128B ')
        # check to see if we don't already have this barcode image

        uri = store_dir_barcode(data)
        #fname = RAILS_ROOT + '/public' + uri

        # if the barcode image doesn't already exist then generate and save it
        if ! File.exists?(uri)

          str = 'Barby::'+symbology+'.new("'+data+'")'

          begin
            barcode = eval str
          rescue Exception => exc
            barcode = Barby::Code128B.new(data) # fall back to Code128 type B
          end

          File.open(uri, 'w') do |f|
            f.write barcode.to_png(:margin => 3,:width=>100, :xdim => 2, :height => 40)
          end

        end

    end

    def store_dir_barcode(code)
      fname = CGI.escape(code) + '.png'
     "#{Rails.root.join('private', 'nota', 'barcode')}/#{fname}"
    end

    #Devuelve el codigo javascript para hacer un campo de busqueda con observer
    #Parametros:
    #   option: hash
    #       :input_id => nombre del input text donde esta la palabra a  buscar
    #       :frecuencia => con que frecuencia inspeccionar el inpud
    #       :dataType =>   usado como parametro de $.ajax
    #       :grilla => Nombre de la  tabla(html) donde va el resultado
    #   actioncontroller: hash
    #       :controller => Nombre del controlador que realizara la busqueda
    #       :action => Nombre del metodo que realiza la busqueda
    #

    def helper_search_field(option, actioncontroller)
        func = "func_"+rand(36**5).to_s(36)

        input_id = option[:input_id]
        frecuencia = option[:frecuencia] || 2
        dataType = option[:dataType] || 'html'
        container = option[:grilla]

        out_observer = %{
              $(function() {
                  $(\"##{input_id}\").observe_field(#{frecuencia}, function( ) {
                      #{func}(this.value);
                  });
              });
        }
        #actioncontroller = {:controller => controlador, :action=>'search'}
        link_parameters = actioncontroller.merge({:remote=>'true', :direction => params[:direction], :sort => params[:sort], :term =>''})
        url = url_for link_parameters
        out_funcion = %{
                    /*
                     * Invoca mediante ajax la busqueda
                     * */
                    function #{func}(texto){
                        url = '#{url}';
                        url += encodeURIComponent(texto);
                        $.ajax({
                           type: 'GET'
                           , url: url
                           , dataType:'#{dataType}'
                           , beforeSend: function(){
                                    beforeSearchRecord('#{container}');
                             }
                           , complete: function(){

                             }
                           , success: function(data){
                               afterSearchRecord('#{container}',data);
                           }
                        });
                    }
        }
        return javascript_tag(out_observer + out_funcion)
    end

    def helper_input_search_field(name)
        field = text_field_tag "#{name}", session[:term], :placeholder=>"Introduce un texto", :size => "30", :class=>"form-control input-sm"
        #label = label_tag :name, image_tag("buscar.png",{:align => "middle"}),{:class=>"labelbutton"}
        #field + label
    end

    #Crea la cabecera de las tablas conteniendo
    # - Un titulo
    # - Un campo de busqueda
    # - Un cantidad de registros por pagina
    # - Un boton de nuevo registro

    def helper_datagrid_header(title,hash_search_action,hash_action_new,cabeceras,div_result)
      #title: el titulo que va en la cabecera, "Listado de ...."
      #hash_action_search: el controlador y la accion para el metodo buscar, {:controller=>'cargos',:action=>'search'}
      #hash_action_new: el label y la accion para el metodo new, si tiene remote, entonces la accion va en onclick
      #div_result: indica en que div se debe mostrar los resultados

      link_parameters = hash_search_action.merge({:remote=>'true', :direction => params[:direction], :sort => params[:sort], :term =>''})
      url = url_for link_parameters

      if hash_action_new.blank?
          render :partial => '/helper/datagrid_header' , :locals => {:title => title,:search_action=>url,:new_action => hash_action_new[:action],:no_new_action=>true,:cabeceras=>cabeceras, :div_result=>div_result}
      else
        render :partial => '/helper/datagrid_header' , :locals => {:title => title,:search_action=>url,:new_action => hash_action_new[:action],:new_action_label => hash_action_new[:label],:new_action_remote => hash_action_new[:remote],:cabeceras=>cabeceras, :div_result=>div_result}
      end
    end

    #DEFINE UN ENLACE CON BOTON PARA SER USADO EN UN NAVBAR
    #url: es la accion
    #text: el texto del boton
    #img_name: el nombre de la imagen para poner en image_tag
    #link_option: las opciones para poner en link_to
    def navBarLink(url,text, img_name, link_option)
      ###  <%= link_to raw('<button type="button" class="btn-img btn btn-default navbar-btn">'+image_tag("list16x16.png",{:title =>"Ir al Listado", :alt=>"Listar", :border => "0"})+" Listado</button>"), cargos_path %>

      link_to raw('<button type="button" class="btn-img btn btn-default navbar-btn">'+image_tag(img_name,{:border=>"0", :alt=>""})+" "+text+"</button>"), url, link_option
    end



    def helper_script_dialog_create(fcn_name,div_name,url,title,width,height)
        out_funcion = %{
            function #{fcn_name}(){
                $('body').append("<div id='#{div_name}'></div>");
                $.ajax({
                   type: "GET"
                   , url: "#{url}"
                   , dataType:"html"
                   , success: function(data){
                        $("##{div_name}").html(data);
                   }
                });


            $("##{div_name}").dialog({
                autoOpen: false,
                height: #{height},
                width: #{width},
                modal: true,
                title: '#{title}',
                close: function(event, ui) { $('##{div_name}').remove();},
            });
            $("##{div_name}").dialog( "open" );}
        }
        raw(out_funcion)
    end
    def helper_script_dialog_edit(fcn_name,div_name,title,width,height)
        out_funcion = %{
                    function #{fcn_name}(url){
                        //Crea un div donde pondra el formulario
                        $('body').append("<div id='#{div_name}'></div>");
                        $.ajax({
                           type: "GET"
                           , url: url
                           , dataType:"html"
                           , success: function(data){
                                $("##{div_name}").html(data);
                           }
                        });
                        /*Especifica al div creado recientemente como dialog*/
                        $("##{div_name}").dialog({
                            autoOpen: false,
                            height: #{height},
                            width: #{width},
                            modal: true,
                            title: '#{title}',
                            close: function(event, ui) { $('##{div_name}').remove();},

                        });
                        $("##{div_name}").dialog( "open" );
                    }





        }
        raw(out_funcion)
    end
end

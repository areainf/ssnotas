// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//

//= require jquery
//= require jquery_ujs
//  require dataTables/jquery.dataTables
//  require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//  require dataTables/extras/dataTables.responsive
//= require jquery.ui.all
//= require_tree .
//= require jquery
//= require bootstrap-sprockets


/*Especifica atributos en español para el campo fecha,*/
jQuery(function($){
     $.datepicker.regional['es'] = {
          closeText: 'Cerrar',
          prevText: '<Ant',
          nextText: 'Sig>',
          currentText: 'Hoy',
          monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
          monthNamesShort: ['Ene','Feb','Mar','Abr', 'May','Jun','Jul','Ago','Sep', 'Oct','Nov','Dic'],
          dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
          dayNamesShort: ['Dom','Lun','Mar','Mié','Juv','Vie','Sáb'],
          dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','Sá'],
          weekHeader: 'Sm',
          dateFormat: 'dd-mm-yy',
          firstDay: 1,
          isRTL: false,
          showMonthAfterYear: false,
          yearSuffix: ''};
       $.datepicker.setDefaults($.datepicker.regional['es']);
});

function trim(cadena){
    return cadena.replace(/^\s+|\s+$/g, "");
}


function UrlHelper(url){
       this._fullurl = url;
       this._params={};
       this._action ="";
       this.initialize = function(){
                                    query_string = {};
                                    sp = this._fullurl.split('?');
                                    u = sp[0];
                                    qs = sp[1];
                                    qs = qs.replace(/&amp;/g, "&")
                                    var vars = qs.split("&");
                                    for (var i=0;i<vars.length;i++) {
                                        var pair = vars[i].split("=");
                                        // If first entry with this name
                                        if (typeof query_string[pair[0]] === "undefined") {
                                            query_string[pair[0]] = pair[1];
                                        // If second entry with this name
                                        } else if (typeof query_string[pair[0]] === "string") {
                                            var arr = [ query_string[pair[0]], pair[1] ];
                                            query_string[pair[0]] = arr;
                                        // If third or later entry with this name
                                        } else {
                                            query_string[pair[0]].push(pair[1]);
                                        }
                                    }
                                    //if(par[0] in query_string ) {
                                    this._params = query_string;
                                    this._action = u;
       }
       this.initialize();//divide el url en dominio-controlador-accion y parametros
       this.setParam = function(name, value){
         this._params[name]= value;
       }
       this.getParam = function(name){
         return this._params[name];
       }
       this.getFullUrl = function(){
          var q = "";
          for(k in this._params){
              if (q.length>0)
                q +="&";
              q += k+"="+query_string[k];
          }
          return this._action+'?'+q;
       }

  };

/***********************************************************************************
 ***********
 ****** Abre un formulario para dar de alta una ENTIDAD
 ***********
 ***********************************************************************************/
function openNuevaEntidad(new_container, title){
    //Crea un div donde pondra el formulario
    $('body').append("<div id='"+new_container+"'></div>");
    //Llama remotamente a la accion new del controlador entidades diciendole que muestre todos las entidades
    url = "/entidades/new";
    $.ajax({
       type: "GET"
       , url: url
       , data: {remote: true, bt: true}
       , dataType:"html"
       , beforeSend: function(){}
       , complete: function(){}
       , success: function(data){
            $("#"+new_container).html(data);
       }
    });
    /*Especifica al div creado recientemente como dialog*/
    
    $("#"+new_container).dialog({
        autoOpen: false,
        height: 500,
        width: 600,
        modal: true,
        title: title,
        close: function(event, ui) { $("#"+new_container).remove();},
    });
    $("#"+new_container).dialog( "open" );
}


function showError (container, value){
  error = "<ul>";
  for (key in value){
    error += "<li>"+value[key]+"</li>";
  }
  error += "</ul>"
    $(container).html(error);
    $(container).show('slow');
}

/***********************************************************************************
 ***********
 ****** Abre un formulario para dar de alta una PERSONA
 ***********
 ***********************************************************************************/
function openNuevaPersona(new_container, title){
    //Crea un div donde pondra el formulario
    $('body').append("<div id='"+new_container+"'></div>");
    //Llama remotamente a la accion new del controlador entidades diciendole que muestre todos las entidades
    url = "/personas/new";
    $.ajax({
       type: "GET"
       , url: url
       , data: {remote: true, bt: true}
       , dataType:"html"
       , beforeSend: function(){}
       , complete: function(){}
       , success: function(data){
            $("#"+new_container).html(data);
       }
    });
    /*Especifica al div creado recientemente como dialog*/
    $("#"+new_container).dialog({
        autoOpen: false,
        height: 400,
        width: 600,
        modal: true,
        title: title,
        close: function(event, ui) { $("#"+new_container).remove();},
    });
    $("#"+new_container).dialog( "open" );
}

/***********************************************************************************
 ***********
 ****** Abre un formulario para dar de alta un CARGO
 ***********
 ***********************************************************************************/
function openNuevoCargo(new_container, title){
    //Crea un div donde pondra el formulario
    $('body').append("<div id='"+new_container+"'></div>");
    //Llama remotamente a la accion new del controlador entidades diciendole que muestre todos las entidades
    url = "/cargos/new";
    $.ajax({
       type: "GET"
       , url: url
       , data: {remote: true, bt: true}
       , dataType:"html"
       , beforeSend: function(){}
       , complete: function(){}
       , success: function(data){
            $("#"+new_container).html(data);
       }
    });
    /*Especifica al div creado recientemente como dialog*/
    $("#"+new_container).dialog({
        autoOpen: false,
        height: 300,
        width: 600,
        modal: true,
        title: title,
        close: function(event, ui) { $("#"+new_container).remove();},
    });
    $("#"+new_container).dialog( "open" );
}



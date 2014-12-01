
function deleteArchivoAdjunto(id){
	$.ajax({
       type: "POST"
       , url: "/notas_attachment/"+id
       , dataType: "json"
       , method: "delete"
       , success: function(data){
            $("#nota_attachment_"+id).remove();
         }
    });
}

$(document).ready(function(){
  if($('#form-notas').length){
    $("#nota_fecha_nota" ).datepicker();
    Destinatarios = {
      ids: [],
      container_ids: "#destinatarios_ids",
      add: function(id){
        this.ids.push(id);
        this.setHiddenIds();
      },
      del: function(id){
        for(i = 0; i < this.ids.length; i++){
          if (this.ids[i] == id){
            this.ids.splice(i, 1);
          }
        }
        this.setHiddenIds();
      },
      setHiddenIds: function(){
        $(this.container_ids).val(this.ids.join());
      },
    }
    /*BUSCAR REMITENTE*/
    $("#remitente_token").tokenInput("/entidades/find_remitentes.json",{
      crossDomain: false,
      queryParam: "term",
      propertyToSearch: "alias_or_fullname",
      theme: 'facebook',
      minChars: "3",
      tokenLimit: 1,
      preventDuplicates: true,
      resultsFormatter: function(persona){
        return "<li> <p style='color: black' >" + persona.alias_or_fullname + " </p> </li>"; },
      tokenFormatter: function(persona) {
        return "<li><p>" + persona.alias_or_fullname + "</p></li>" },
        noResultsText: "No hay coincidencias",
        hintText: "Ingrese el nombre del Remitente",
        searchigText: "Buscando persona con ...",
      onAdd: function(persona){ 
        $("#nota_remitente_id").val(persona['id']);
      },
      onDelete: function(persona){ 
        $("#nota_remitente_id").val('');
      },
    });

    /*BUSCAR DESTINATARIOS*/

    $("#destinatarios_token").tokenInput("/entidades/find_destinatarios.json",{
      crossDomain: false,
      queryParam: "term",
      propertyToSearch: "alias_or_fullname",
      theme: 'facebook',
      minChars: "3",
      preventDuplicates: true,
      resultsFormatter: function(persona){
        return "<li> <p style='color: black' >" + persona.alias_or_fullname + " </p> </li>"; },
      tokenFormatter: function(persona) {
        return "<li><p>" + persona.alias_or_fullname + "</p></li>" },
        noResultsText: "No hay coincidencias",
        hintText: "Ingrese el nombre del Destinatario",
        searchigText: "Buscando persona con ...",
      onAdd: function(persona){ 
        Destinatarios.add(persona['id']);
      },
      onDelete: function(persona){ 
        Destinatarios.del(persona['id']);
      },
    });
   
    /*PERSONA DE REFERENCIA*/
    $("#persona_ref_tokens").tokenInput("/personas.json",{
      crossDomain: false,
      queryParam: "term",
      propertyToSearch: "nombre",
      theme: 'facebook',
      minChars: "3",
      preventDuplicates: true,
      resultsFormatter: function(persona){
        var compleName = persona.nombre + ", " + persona.apellido;
        return "<li> <p style='color: black' >" + compleName + " </p> </li>"; },
      tokenFormatter: function(item) {
        return "<li><p>" + (item.nombre + ", " +
        item.apellido).substring(0,22) + "</p></li>" },
        noResultsText: "No hay coincidencias",
        hintText: "Ingrese el nombre de la persona",
        searchigText: "Buscando persona con ...",
      onAdd: function(persona){ }
    });


    /***********************************************************
    *****
    ***   BINDING LINK BUTTON
    *****
    ***********************************************************/
    var remitente_dialog = "modal-remitente";
    var destinatario_dialog = "modal-destinatario";
    $('#link_open_nuevo_remitente').click(function() {

      openNuevaEntidad(remitente_dialog, "Nuevo Remitente");
      return false;
    });
    $(document).on('ajax:success',"#"+remitente_dialog, function(evt, data, status, xhr){
      $("#remitente_token").tokenInput("add", data)
      $("#modal-remitente").dialog( "close" );
    });
    $(document).on('ajax:error',"#"+remitente_dialog, function(evt, data, status, xhr){
      var errors = jQuery.parseJSON(data.responseText);
      showError("#entidad-error",errors);
      return false;
    });
    /*NUEVO DESTINATARIO*/
    $('#link_open_nuevo_destinatario').click(function() {
      openNuevaEntidad(destinatario_dialog, "Nuevo Destinatario");
      return false;
    });
    $(document).on('ajax:success',"#"+destinatario_dialog, function(evt, data, status, xhr){
      $("#destinatarios_token").tokenInput("add", data)
      $("#"+destinatario_dialog).dialog( "close" );
    });
    $(document).on('ajax:error',"#"+destinatario_dialog, function(evt, data, status, xhr){
      var errors = jQuery.parseJSON(data.responseText);
      showError("#entidad-error",errors);
      return false;
    });


  }
  if ($('#notas-DataTable').length){
    //datatables
    $('#notas-DataTable').dataTable({
      autoWidth: true,
      pagingType: 'full_numbers',
      responsive: true,
      bJQueryUI: true,
      bProcessing: true,
      bServerSide: true,
      ajax: '/notas',
    });
  }

  

});
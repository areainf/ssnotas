<script>
/*BUSCAR PERSONA*/
    var pre_persona = $("#persona_tokens").data("pre").replace(/=>/g,":");
    if (pre_persona != '[nil]')
      pre_persona = JSON.parse(pre_persona);
    else
      pre_persona = [];
    $("#persona_tokens").tokenInput("/personas.json",{
      crossDomain: false,
      queryParam: "term",
      propertyToSearch: "fullname",
      theme: 'facebook',
      minChars: "3",
      tokenLimit: 1,
      preventDuplicates: true,
      prePopulate: pre_persona,
      resultsFormatter: function(persona){
        return "<li> <p style='color: black' >" + persona.fullname + " </p> </li>"; },
      tokenFormatter: function(persona) {
        return "<li><p>" + persona.fullname + "</p></li>" },
        noResultsText: "No hay coincidencias",
        hintText: "Ingrese el nombre de la persona",
        searchigText: "Buscando persona con ...",
      onAdd: function(persona){ 
        $("#entidad_persona_id").val(persona['id']);
      },
      onDelete: function(persona){ 
        $("#entidad_persona_id").val('');
      },
    });
/* BUSCAR DEPENDENCIA */
    var pre_dependencia = $("#dependencia_tokens").data("pre").replace(/=>/g,":");
    if (pre_dependencia != '[nil]')
      pre_dependencia = JSON.parse(pre_dependencia);
    else
      pre_dependencia = [];
  $("#dependencia_tokens").tokenInput("/dependencias.json",{
      crossDomain: false,
      queryParam: "term",
      propertyToSearch: "alias_or_fullname",
      theme: 'facebook',
      minChars: "3",
      tokenLimit: 1,
      prePopulate: pre_dependencia,
      preventDuplicates: true,
      resultsFormatter: function(dependencia){
        return "<li> <p style='color: black' >" + dependencia.alias_or_fullname + " </p> </li>"; },
      tokenFormatter: function(dependencia) {
        return "<li><p>" + dependencia.alias_or_fullname + "</p></li>" },
        noResultsText: "No hay coincidencias",
        hintText: "Ingrese el nombre de la Dependencia",
        searchigText: "Buscando dependencia con ...",
      onAdd: function(dependencia){ 
        $("#entidad_dependencia_id").val(dependencia['id']);
      },
      onDelete: function(dependencia){ 
        $("#entidad_dependencia_id").val('');
      },
    });
/* BUSCAR CARGO */
  var pre_cargo = $("#cargo_tokens").data("pre").replace(/=>/g,":");
    if (pre_cargo != '[nil]')
      pre_cargo = JSON.parse(pre_cargo);
    else
      pre_cargo = [];
  $("#cargo_tokens").tokenInput("/cargos.json",{
      crossDomain: false,
      queryParam: "term",
      propertyToSearch: "nombre",
      theme: 'facebook',
      minChars: "3",
      tokenLimit: 1,
      prePopulate: pre_cargo,
      preventDuplicates: true,
      resultsFormatter: function(cargo){
        return "<li> <p style='color: black' >" + cargo.nombre + " </p> </li>"; },
      tokenFormatter: function(cargo) {
        return "<li><p>" + cargo.nombre + "</p></li>" },
        noResultsText: "No hay coincidencias",
        hintText: "Ingrese el nombre de la cargo",
        searchigText: "Buscando cargo con ...",
      onAdd: function(cargo){ 
        $("#entidad_cargo_id").val(cargo['id']);
      },
      onDelete: function(cargo){ 
        $("#entidad_cargo_id").val('');
      },
    });
/*NUEVA PERSONA*/
  var dialog_persona = "modal-persona";
  var _dialog_persona = "#"+dialog_persona;
  $('#link_open_nueva_persona').click(function() {
    openNuevaPersona(dialog_persona, "Nueva Persona");
    return false;
  });
  $(document).on('ajax:success', _dialog_persona, function(evt, data, status, xhr){
      $(_dialog_persona).dialog( "close" );
  });
  $(document).on('ajax:error', _dialog_persona, function(evt, data, status, xhr){
    var errors = jQuery.parseJSON(data.responseText);
    showError("#entidad-error",errors);
    return false;
  });
/*NUEVO CARGO*/
  var dialog_cargo = "modal-cargo";
  var _dialog_cargo = "#"+dialog_cargo;
  $('#link_open_nuevo_cargo').click(function() {
    openNuevoCargo(dialog_cargo, "Nuevo Cargo");
    return false;
  });
  $(document).on('ajax:success', _dialog_cargo, function(evt, data, status, xhr){
      $(_dialog_cargo).dialog( "close" );
  });
  $(document).on('ajax:error', _dialog_cargo, function(evt, data, status, xhr){
    var errors = jQuery.parseJSON(data.responseText);
    showError("#entidad-error",errors);
    return false;
  });
</script>
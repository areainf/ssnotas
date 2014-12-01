$(document).ready(function(){
  if($('#toolbar-entidad').length){
    var entidad_dialog = "modal-entidad";
    var _entidad_dialog = "#modal-entidad";
    $(document).on('ajax:success',_entidad_dialog, function(evt, data, status, xhr){
      $("#"+entidad_dialog).dialog( "close" );
    });
    $(document).on('ajax:error',_entidad_dialog, function(evt, data, status, xhr){
      var errors = jQuery.parseJSON(data.responseText);
      showError("#entidad-error",errors);
      return false;
    });
  }
});
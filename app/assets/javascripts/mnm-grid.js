/*Muestra un recuadro indicando que esta realizando una busqueda*/
function beforeSearchRecord(table_id){
    //var randomnumber=Math.floor(Math.random()*101)
    //divname="div-loading-"+randomnumber;
    divname="div-loading-"+table_id;
    img='<img src="/assets/loading.gif" class="img-load" alt="Cargando ...." />';
    $('<div id="'+divname+'" class="mnm-loading">'+img+'</div>').insertBefore($("#"+table_id));
    //objdiv=$("#"+divname);
}
function afterSearchRecord(table_id,data){

    divname="div-loading-"+table_id;
    objdiv=$("#"+divname);
    objdiv.remove();

    $("#"+table_id+ " tbody").html(data);
}

function beforeSearchRecordV1(table_id){
  img='<img src="/assets/loading.gif" class="img-load" alt="Cargando ...." />';
  div = '<div class="mnm-loading">'+img+'</div>';
  $("#"+table_id).html(div);
}
function afterSearchRecordV1(table_id,data){
  $("#"+table_id).html(data);
}
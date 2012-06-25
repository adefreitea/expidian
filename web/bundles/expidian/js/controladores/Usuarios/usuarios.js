var filas_reg = 10;

function listar_usuarios(url){
    var url = url;
    sinner_grid("false", "idUsuario", "", "", "idUsuario", "ASC", "1", filas_reg, url, "div_lista_usuarios");
}

function reloadGrid_usuarios(url){
    var url = url;
    var operacion = $("#searchOperf").val();
    var indice = $("#sidxf").val();
    var orden = $("#sordf").val();
    var criterio = $("#searchFieldf").val();
    var parametro = $("#searchStringf").val();
    var is_search = $("#is_search").val();
    sinner_grid(is_search, criterio, operacion, parametro, indice, orden, "1", filas_reg, url, "div_lista_usuarios");
}

function change_page_list_users(url, criterio, parametro, is_search, pagina){
    var url = url;
    var operacion = $("#searchOperf").val();
    var indice = $("#sidxf").val();
    var orden = $("#sordf").val();
    sinner_grid(is_search, criterio, operacion, parametro, indice, orden, pagina, filas_reg, url, "div_lista_usuarios");
}

function busqueda_usuarios(url){
    var criterio = $("#criteria_box").val();
    var parametro = $("#search_box").val();
    $("#searchFieldf").val(criterio);
    $("#searchStringf").val(parametro);
    $("#is_search").val("true");
    reloadGrid_usuarios(url);
}

function busqueda_rapida_usuarios(url,id,campo) {
    searchFields = campo;
    searchString = id;
    $("#is_search").val("true");
    $("#searchOperf").val("eq");
    $("#searchFieldf").val(searchFields);
    $("#searchStringf").val(id);
    $("#sidxf").val(searchFields);
    reloadGrid_usuarios(url);
}
/**
 * Indica si se está haciendo o no una búsqueda
 */
var search = new String("false");

/**
 * Indica el número de página en un grupo de registros listados y paginados
 */
var page = new String("1");

/**
 * Indica el número de registros que se mostrarán por páginas
 */
var rows = new String("10");

/**
 * Indica el nombre del campo por el que se desea buscar
 */
var searchField = new String("");

/**
 * Indica la operación de búsqueda
 */
var searchOper = new String("eq");

/**
 * Indica el parámetro de búsqueda
 */
var searchString = new String("");

/**
 * Indica el nombre del campo por el que se ordenará los registros listados
 */
var sidx = new String("");

/**
 * Indica el tipo orden que tendran el grupo de registros 
 */
var sord = new String("");

function sinner_grid(_search, _searchField, _searchOper, _searchString, _sidx, _sord, _page, _rows, url_controller, div_string){
	
	if(_search != ""){search = _search;}
	if(_page != "" && !isNaN(_page) && _page>0){page = _page;}
	if(_rows!=""){rows = _rows;}
	if(_searchField!=""){searchField = _searchField;}
	if(_searchOper!=""){searchOper = _searchOper;}
	if(_sidx!=""){sidx = _sidx;}
	if(_sord!=""){sord = _sord;}else{sord = "ASC";}
	searchString = _searchString;
	
	var datos = "&_search="+search+"&page="+page+"&sidx="+sidx+"&sord="+sord+"&rows="+rows+"&searchField="+searchField+"&searchString="+searchString+"&searchOper="+searchOper;
	
	$.ajax({
            type: "POST",
            dataType: "html",
            data: datos,
            url: url_controller,
            success: function(datos){
                    $("#"+div_string).html(datos).fadeIn("slow");
            }
	});	
	
}
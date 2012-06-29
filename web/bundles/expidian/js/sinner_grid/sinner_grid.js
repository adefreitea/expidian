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
var grid_sort = new String("");

/**
 * Indica el tipo orden que tendran el grupo de registros ASC DESC
 */
var grid_direction = new String("");

function sinner_grid(_form_paginate, url_controller, div_string){

        var _search = $("#"+_form_paginate+" input#is_search").val();
        var _searchField = $("#"+_form_paginate+" input#searchField").val();
        var _searchOper = $("#"+_form_paginate+" input#searchOper").val();
        var _searchString = $("#"+_form_paginate+" input#searchString").val();
        var _grid_sort = $("#"+_form_paginate+" input#grid_sort").val();
        var _grid_direction = $("#"+_form_paginate+" input#grid_direction").val();
        var _rows = $("#"+_form_paginate+" input#rows").val();
        
	if(_search != ""){search = _search;}
	//if(_page != "" && !isNaN(_page) && _page>0){page = _page;}
	if(_rows!=""){rows = _rows;}
	if(_searchField!=""){searchField = _searchField;}
	if(_searchOper!=""){searchOper = _searchOper;}
	if(_grid_sort!=""){grid_sort = _grid_sort;}
	if(_grid_direction!=""){grid_direction = _grid_direction;}else{grid_direction = "ASC";}
	searchString = _searchString;
	
	var datos = "&is_search="+search+"&grid_sort="+grid_sort+"&grid_direction="+grid_direction+"&rows="+rows+"&searchField="+searchField+"&searchString="+searchString+"&searchOper="+searchOper;
	
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
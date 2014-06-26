/*
 * Copyright (C) 2012-2014 52°North Initiative for Geospatial Open Source
 * Software GmbH
 *
 * This program is free software; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License version 2 as publishedby the Free
 * Software Foundation.
 *
 * If the program is linked with libraries which are licensed under one of the
 * following licenses, the combination of the program with the linked library is
 * not considered a "derivative work" of the program:
 *
 *     - Apache License, version 2.0
 *     - Apache Software License, version 1.0
 *     - GNU Lesser General Public License, version 3
 *     - Mozilla Public License, versions 1.0, 1.1 and 2.0
 *     - Common Development and Distribution License (CDDL), version 1.0
 *
 * Therefore the distribution of the program linked with libraries licensed under
 * the aforementioned licenses, is permitted by the copyright holders if the
 * distribution is compliant with both the GNU General Public License version 2
 * and the aforementioned licenses.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE. See the GNU General Public License for more details.
 */
$(document).ready(function() {

	/*
	 * Functionality for displaying the corresponding screens
	 * for add permission
	 * */
	$("form div button").click(function(event){
		var id=this.id.split("-");
		$("#"+id[0]).hide();
		$("#"+id[1]).show();
	});
	
	
});

/***********************************End of data binding*********************************************/

/******************************End of Resource Screen**************************************/

/*
 * Method for appending new rows for actions on add click
 * */
function addAction()
{
	var length=$("#action .row").length;
	length++;

	var html="<div id='actionRow-"+length+"' class='row'>";

	html+="<div class='col-xs-1'><button onclick='addAction();' type='button' class='btn btn-xs' title='Add Observed Properties'>" +
	"<span class='glyphicon glyphicon-plus'></span> </button></div>";
	html+="<div class='col-xs-9'><div class='form-group'><input id='action"+length+"' class='form-control'" +
	" type='text' placeholder='action value' /></div></div>";
	html+="<div class='col-xs-2'><button onclick='deleteAction(this.id);' id='deleteAction-"+length+"'" +
	" type='button' class='btn btn-xs' title='Delete Observed Property'>" +"<span class='glyphicon glyphicon-trash'></span></button></div>";

	$("#action").append(html);
}

/*
 * Method for deleting the action
 * */
function deleteAction(id)
{
	$("#actionRow-"+id.split("-")[1]).remove();
}

/*******************************************End of Action Screen*************************************************/
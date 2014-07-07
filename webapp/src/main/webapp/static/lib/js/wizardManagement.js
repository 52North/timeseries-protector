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
	
	$("#createPermissionForm").submit(function(event){
		event.preventDefault();
		
		if($("#permissionSet").val()!="new")
			{
				/*
				 * Prepare the json and launch the ajax attack :D
				 * */
			var actions=[];
			
			for(var i=0;i<$("#selectActions").val().length;i++)
				{
					items={};
				    items["value"]="operations/"+$("#selectActions").val()[i];
					items["domains"]=[];
					actions.push(items);
				}	
			
			var resources=[];
			for(var i=0;i<$("#selectProcedures").val().length;i++)
			{
				items={};
			    items["value"]="procedures/"+$("#selectProcedures").val()[i];
				items["domains"]=[];
				resources.push(items);
			}
			for(var i=0;i<$("#selectOfferings").val().length;i++)
			{
				items={};
			    items["value"]="offerings/"+$("#selectOfferings").val()[i];
				items["domains"]=[];
				resources.push(items);
			}
			for(var i=0;i<$("#selectFeaturesOfInterest").val().length;i++)
			{
				items={};
			    items["value"]="featuresOfInterest/"+$("#selectFeaturesOfInterest").val()[i];
				items["domains"]=[];
				resources.push(items);
			}
			for(var i=0;i<$("#selectObservedProperties").val().length;i++)
			{
				items={};
			    items["value"]="observedProperties/"+$("#selectObservedProperties").val()[i];
				items["domains"]=[];
				resources.push(items);
			}
			for(var i=0;i<$("#selectActions").val().length;i++)
			{
				items={};
			    items["value"]="allowedOperations/"+$("#selectActions").val()[i];
				items["domains"]=[];
				resources.push(items);
			}
			var subjects=[];
			for(var i=0;i<$("#selectSubjects").val().length;i++)
			{
				items={};
			    items["value"]=$("#selectSubjects").val()[i];
				items["domains"]=[];
				subjects.push(items);
			}	 
			
			var json= {
					"name":	$("#permissionName").val(),
					"resources":resources,
					"actions":actions,
					"subjects":subjects,
					"obligations":[]
				};
			
			$.ajax({
							url : $(this).attr("action"),
							data : JSON.stringify(json),
							contentType : "application/json",
							type : "POST",
							beforeSend : function(
									xhr) {
								xhr
								.setRequestHeader(
										"Accept",
								"application/json");
								xhr
								.setRequestHeader(
										"Content-Type",
								"application/json");
							},
							success: function(data,status,xhr)
							{
								window.location.href=xhr.getResponseHeader('Location');
							}
						});
			}
		else
			{
				/*
				 * Save data temporarily in the browser
				 * */
				if(Storage!="undefined")
				{
					localStorage.subPermission=content;
					window.location.href="/protector-webapp/editor/new";
				}
			}
		
	});
	
	
});

/***********************************End of data binding*********************************************/

function prepareContent()
{
	var content="";
	content +="<tr id='row-"+$("#permissionName")+"'>";
	content +="<td> <div class='checkbox'><label> <input id='"+$("#permissionName")+ "type='checkbox'> </label></div></td>";
	content +="<td>"+$("#permissionName") + "</td>";
	content += "<td>";
	for(i=0;i<$("#selectSubjects").val().length;i++)
		{
			content+=$("#selectSubjects").val()[i];
			content+="<br/>";
		}
	content+="</td>";
	content+="<td>";
	for(i=0;i<$("#selectActions").val().length;i++)
	{
		content+=$("#selectActions").val()[i];
		content+="<br/>";
	}
	content+="</td>";
	content+="<td>";
	
	for(i=0;i<$("#selectOfferings").val().length;i++)
	{
		content+="offerings/"+$("#selectOfferings").val()[i];
		content+="<br/>";
	}
	
	for(i=0;i<$("#selectProcedures").val().length;i++)
	{
		content+="procedures/"+$("#selectProcedures").val()[i];
		content+="<br/>";
	}
	
	for(i=0;i<$("#selectObservedProperties").val().length;i++)
	{
		content+="observedProperties/"+$("#selectObservedProperties").val()[i];
		content+="<br/>";
	}
	
	for(i=0;i<$("#selectFeaturesOfInterest").val().length;i++)
	{
		content+="fFeaturesOfInterest/"+$("#selectFeaturesOfInterest").val()[i];
		content+="<br/>";
	}
	for(i=0;i<$("#selectActions").val().length;i++)
	{
		content+="allowedOperations/"+$("#selectActions").val()[i];
		content+="<br/>";
	}
	content+="</td>";
	content+="<td> Not found </td>";
	content+="<td> <a href='#' id='btn#"+$("#permissionName")+"' ";
	content+="class='btn btn-default btn-xs' role='button'>MODIFY</a></td>";
				
	
	return content;

}
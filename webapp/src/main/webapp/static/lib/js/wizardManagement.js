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

	/*for setting the values for badges on load */
	$.each($("select[multiple]"),function(name,value){

		$("#"+value.id+"Count").html($("#"+this.id+" option[selected]").length);
	});

	/*for setting the total no. of values for badges on load */
	$("#totalProceduresCount").html($("#selectProcedures option").length);
	$("#totalOfferingsCount").html($("#selectOfferings option").length);
	$("#totalFeaturesOfInterestCount").html($("#selectFeaturesOfInterest option").length);
	$("#totalObservedPropertiesCount").html($("#selectObservedProperties option").length);

	/*
	 * Functionality for displaying the count of selected
	 * parameters in the badge
	 * 
	 * */
	$("select[multiple]").on("change",function() {
		$("#"+this.id+"Count").html($("#"+this.id).val().length);
		
		if($("#"+this.id+"Container").hasClass("has-error")) {
		  $("#"+this.id+"Container").removeClass("has-error");
		  $("#"+this.id+"Validation").remove();
		  console.log($("#errorList li").length);
		  if($("#errorList li").length==0)
		   {
			  $(".close").click();
		   }
		  
		}
	});

	/*
	 * Functionality for displaying the corresponding screens
	 * for add permission
	 * */

	$("#createPermissionForm").submit(function(event){
		event.preventDefault();

		if(validateOptions())
		{	 
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
				if($("#selectProcedures option").length==$("#selectProcedures").val().length)
				{	
					items={};
					items["value"]="procedures/*";
					items["domains"]=[];
					resources.push(items);
				}
				else
				{
					for(var i=0;i<$("#selectProcedures").val().length;i++)
					{
						items={};
						items["value"]="procedures/"+$("#selectProcedures").val()[i];
						items["domains"]=[];
						resources.push(items);
					}
				}

				if($("#selectOfferings option").length==$("#selectOfferings").val().length)
				{	
					items={};
					items["value"]="offerings/*";
					items["domains"]=[];
					resources.push(items);
				}
				else
				{
					for(var i=0;i<$("#selectOfferings").val().length;i++)
					{
						items={};
						items["value"]="offerings/"+$("#selectOfferings").val()[i];
						items["domains"]=[];
						resources.push(items);
					}
				}

				if($("#selectFeaturesOfInterest option").length==$("#selectFeaturesOfInterest").val().length)
				{	
					items={};
					items["value"]="featuresOfInterest/*";
					items["domains"]=[];
					resources.push(items);
				}
				else
				{
					for(var i=0;i<$("#selectFeaturesOfInterest").val().length;i++)
					{
						items={};
						items["value"]="featuresOfInterest/"+$("#selectFeaturesOfInterest").val()[i];
						items["domains"]=[];
						resources.push(items);
					}
				}	
				if($("#selectObservedProperties option").length==$("#selectObservedProperties").val().length)
				{	
					items={};
					items["value"]="observedProperties/*";
					items["domains"]=[];
					resources.push(items);
				}
				else
				{
					for(var i=0;i<$("#selectObservedProperties").val().length;i++)
					{
						items={};
						items["value"]="observedProperties/"+$("#selectObservedProperties").val()[i];
						items["domains"]=[];
						resources.push(items);
					}
				}

				if($("#selectActions option").length==$("#selectActions").val().length)
				{
					items={};
					items["value"]="allowedOperations/*";
					items["domains"]=[];
					resources.push(items);
				}
				else
				{
					for(var i=0;i<$("#selectActions").val().length;i++)
					{
						items={};
						items["value"]="allowedOperations/"+$("#selectActions").val()[i];
						items["domains"]=[];
						resources.push(items);
					}
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

			}
		}

	});

});

/***********************************End of data binding*********************************************/

/*
 * Function for validation the
 * select input fields before the
 * form is submitted
 * 
 **/
function validateOptions()
{ 
	var submit=true;
	var errorHtml="";
	$.each($("select[multiple]"),function(index,selectInput){

		if($("#"+selectInput.id).val()==null)
		{
			if(selectInput.id=="selectSubjects")
			{
				$("#"+selectInput.id+"Container").addClass("has-error");
				errorHtml+="<li id='selectSubjectsValidation'> <b> Subjects </b> cannot be empty </li>";
			}
			else if(selectInput.id=="selectActions")
			{  
				$("#"+selectInput.id+"Container").addClass("has-error");
				errorHtml+="<li id='selectActionsValidation'> <b> Actions </b> cannot be empty </li>";
			}
			else if(selectInput.id=="selectProcedures")
			{  
				$("#"+selectInput.id+"Container").addClass("has-error");
				errorHtml+="<li id='selectProceduresValidation'> <b>Procedures</b> cannot be empty </li>";
			}
			else if(selectInput.id=="selectOfferings")
			{  
				$("#"+selectInput.id+"Container").addClass("has-error");
				errorHtml+="<li id='selectOfferingsValidation'> <b>Offerings</b> cannot be empty </li>";
			}
			else if(selectInput.id=="selectFeaturesOfInterest")
			{  
				$("#"+selectInput.id+"Container").addClass("has-error");
				errorHtml+="<li id='selectFeaturesOfInterestValidation'> <b>Features of Interest</b> cannot be empty </li>";
			}
			else if(selectInput.id=="selectObservedProperties")
			{  
				$("#"+selectInput.id+"Container").addClass("has-error");
				errorHtml+="<li id='selectObservedPropertiesValidation'> <b>Observerd Properties</b> cannot be empty </li>";
			}
			submit=false;
		}
		else
		{
			$("#"+selectInput.id+"Container").removeClass("has-error");
			$("#alert").hide();
		}
	});

	if(!submit) 
	{
		$("#errorList").html(errorHtml);
		$('html,body').animate({ scrollTop: 0 }, 'slow', function () {
          });
		$("#alert").show();
		
	}
	return submit;
}

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
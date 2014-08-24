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
//checking for features supported by browser

if(!(Modernizr.json && Modernizr.localstorage && Modernizr.sessionstorage &&
	Modernizr.dataset && Modernizr.input.placeholder
	&& Modernizr.input.autofocus && Modernizr.input.multiple
	))
{
		window.location.href=$("#contextUrl").val()+"warn/browser";
}

var changeSelectedIndex=false;

var windowUnloadWarning=true;

$(document)
.ready(
		function() {

			/*
			 * Making sure that the url inputs fields have urls decoded while displaying to the user
			 * */
			$.each($("option[data-url]"), function(index,e) {
					$(e).text(decodeURIComponent($(e).text()));
				});

			$.each($("input[data-url]"), function(index,e) {
					$(e).val(decodeURIComponent($(e).val()));
				});

			$.each($("span[data-url]"), function(index,e) {
					$(e).text(decodeURIComponent($(e).text()));
				});

			/*
			 * Check if data is there in the local storage and if it is the
			 * new permission set use case which means
			 * that there is a sub permission temporarily stored in the
			 * browser local storage
			 * */

			if(Storage!="undefined" && ( $("#permissionSetIdentifier").val()=="" || localStorage.getItem("temporaryState")))
			{
				var keyCount=0;

				while(keyCount<localStorage.length)
				{
					if(localStorage.key(keyCount).split("_")[0]=='permissionName')
					{

						$("#info").show("100",function() {
							$("#infoText").html("Permissions are stored temporarily in browser storage, click on delete or cancel to clear");
						});

						var subPermissionObj=jQuery.parseJSON(localStorage.getItem(localStorage.key(keyCount)));

						var content="";
						content+="<tr id='row-"+subPermissionObj.name + "'>";

						/*checkbox*/
						content+="<td> <div class='checkbox'><label><input type='checkbox' id='"+subPermissionObj.name+"' /> ";
						content+="</label></div></td>";

						/*modify button*/
						content+="<td><button class='btn btn-default btn-xs disabled'>MODIFY</button></td>";

						/*name*/
						content+="<td >"+subPermissionObj.name+ "</td>";

						/*subjects*/
						content+="<td>";
						for(var i=0;i<subPermissionObj.subjects.length;i++)
						{
							content+=subPermissionObj.subjects[i].value;
							content+="<br/>";
						}
						content+="</td>";

						/*operations*/
						content+="<td>";
						for(var i=0;i<subPermissionObj.actions.length;i++)
						{
							content+=subPermissionObj.actions[i].value.split("/")[1];
							content+="<br/>";
						}
						content+="</td>";

						/*Resources*/
						content+="<td>";
						var proceduresFirst=true;
						var observedPropertiesFirst=true;
						var offeringsFirst=true;
						var featuresOfInterestFirst=true;

						for(var i=0;i<subPermissionObj.resources.length;i++)
						{
							if(subPermissionObj.resources[i].value.split("/")[0]=='procedures')
							{
								if(proceduresFirst)
								{
									content+="<label style='font-style: oblique;' class='control-label'>Procedures</label>";
									content+="<br/>";
									proceduresFirst=false;
								}
								content+=subPermissionObj.resources[i].value.split("/")[1];
								content+="<br/>";
							}
							else if(subPermissionObj.resources[i].value.split("/")[0]=='offerings')
							{
								if(offeringsFirst)
								{
									content+="<label style='font-style: oblique;' class='control-label'>Offerings</label>";
									content+="<br/>";
									offeringsFirst=false;
								}
								content+=subPermissionObj.resources[i].value.split("/")[1];
								content+="<br/>";
							}
							else if(subPermissionObj.resources[i].value.split("/")[0]=='featuresOfInterest')
							{
								if(featuresOfInterestFirst)
								{
									content+="<label style='font-style: oblique;' class='control-label'>"+
									"Features Of Interest</label>";
									content+="<br/>";
									featuresOfInterestFirst=false;
								}
								content+=subPermissionObj.resources[i].value.split("/")[1];
								content+="<br/>";
							}
							else if(subPermissionObj.resources[i].value.split("/")[0]=='observedProperties')
							{
								if(observedPropertiesFirst)
								{
									content+="<label style='font-style: oblique;' class='control-label'>Observed"+
												"Properties</label>";
									content+="<br/>";
									observedPropertiesFirst=false;
								}
								content+=subPermissionObj.resources[i].value.split("/")[1];
								content+="<br/>";
							}

						}
					content+="</td>";

					/*Obligations*/
					content+="<td> Not Found </td>";
					content+="</tr>";

					$("#permissionTable").append(content);
				}

				keyCount++;
			  }
			}
			if(localStorage.getItem("actionDomain")!=null)
			{
				document.getElementById("actionDomain").selectedIndex=localStorage.getItem("actionDomain");
				$("#resourceDomain").val("");
			}
			if(localStorage.getItem("permissionSetName")!=null)
			{
				$("#permissionSetName").val(localStorage.getItem("permissionSetName"));
			}

			$("#actionDomainTracker").val(document.getElementById("actionDomain").selectedIndex);

			/*
			 * Removing the error class if a user
			 * has entered the data
			 * */
			$("input[data-required='true']").on("change",function(){
				if($("#"+this.id).val()!="")
				{
				 	if($("#"+this.id+"Container").hasClass("has-error")){
						$("#"+this.id+"Container").removeClass("has-error");
						$("#"+this.id+"Validation").remove();
						if($("#errorList li").length==0)
						 {
							  $("#alert").hide();
						 }
				 	}
				}
			});

			/*
			 * hide the parent div on click of close button
			 * */
			$("button[class='close']").click(function(event){

				var parentDiv= $(this).parent("div");
				$("#"+parentDiv[0].id).hide();

			});
			/*
			 * event binding for toggling the arrow
			 * */
			$('#collapseOne').on('show.bs.collapse', function () {
				  $("#toggleArrow").removeClass();
				  $("#toggleArrow").addClass("glyphicon glyphicon-chevron-down");
				});
			$('#collapseOne').on('hidden.bs.collapse', function () {
				  $("#toggleArrow").removeClass();
				  $("#toggleArrow").addClass("glyphicon glyphicon-chevron-right");
				});

			/*
			 * functionality for select all checkbox in permission
			 * management screen
			 */
			$("#selectAllPermission").click(
					function(event) {
						$("#permissionTable input[type='checkbox']")
						.attr("checked", this.checked);
					});

			$("#permissionTable tr input[type='checkbox']")
			.click(
					function(event) {
						if ($("#permissionTable tr td input[type='checkbox']").length == $("#permissionTable tr td input:checked").length) {
							$("#selectAllPermission").attr(
									"checked", "checked");
						} else {
							$("#selectAllPermission")
							.removeAttr("checked");
						}
						if($("#permissionTable tr td input:checked").length >0 && $("#btnDeletePermission").hasClass("disabled"))
						{
							$("#btnDeletePermission").removeClass("disabled");
						}
						else if($("#permissionTable tr td input:checked").length ==0)
						{
							$("#btnDeletePermission").addClass("disabled");
						}
					});
			/*
			 * Functionality for sorting and searching on permission
			 * table
			 */
			$("#permissionTable").dataTable({
				"paging" : false,
				"processing": true,
				"oLanguage": {
					"sEmptyTable":"No permissions available"
					},
				"order" : [ 2, 'asc' ],
				"columnDefs" : [ {
					"orderable" : false,
					"targets" : [0,1]
				} ]
			});

		 //After the data tables are initialized
		  if(localStorage.getItem("permissions")!=null)
			{
				var permissionsForLocalStorage=localStorage.permissions.split(",");

				var table=$("#permissionTable").DataTable();

				//removing the html and not changing the permissions xml instead
				for (var i = 0; i < permissionsForLocalStorage.length; i++)
				{
					table.row($("[id='row-" + permissionsForLocalStorage[i]+"']")).remove().draw();
				}
			}
			/*
			 * Functionality for deleting the sub permissions
			 * temporarily or permanently
			 * */
			$("#btnDeletePermission")
			.click(
					function(event) {
						/*
						 * fetching to see how many records are
						 * to be deleted, which then will be
						 * stored in the session
						 */
						var permissionsToDelete = $("#permissionTable label input:checked");
						if (permissionsToDelete.length >0) {

							$("#alert").hide();

							if (typeof (Storage) !== "undefined") {
								/*
								 * storing the names in the
								 * session variable and will be
								 * deleted once window is closed
								 * or refreshed
								 */
								var permissionsToStore = new Array();

								for (var i = 0; i < permissionsToDelete.length; i++) {
									permissionsToStore.push(permissionsToDelete[i].id);
									/*
									 * adding the hiding support
									 * for multiple rows
									 */
									$("[id='row-" + permissionsToStore[i]+"']")
									.hide("500");
								}
								localStorage.permissions = permissionsToStore;
								// need to separate the undo
								// from label
								$("#deleteWarning")
								.html(
										permissionsToDelete.length
										+ " permission(s) deleted ");
								$("#undoWarning").show();
								permissionDeleteTimeoutId = setTimeout(function(){deletePermissions();},10000);

							}
						}
					});
			$("#undoWarning").click(function() {

				clearTimeout(permissionDeleteTimeoutId);

				var ids = localStorage.permissions.split(",");

				for (var i = 0; i < ids.length; i++) {
					$("[id='row-" + ids[i]+"']").show("500");
				}

				localStorage.removeItem("permissions");

				$("#deleteWarning").html("");

				$(this).hide();

				//checking whether the change in action domain is in place
				if(changeSelectedIndex)
				{
					document.getElementById("actionDomain").selectedIndex=$("#actionDomainTracker").val();
					changeSelectedIndex=false;
				}
			});

			/*
			 * Custom value dropdown widget
			 * */
			$("#subjectDomain").on("change",function(event){
				if($(this).val()=='other'){
				   $("#customSubjectDomain").show();
				}
			});

			var options_array = new Array();

			$.each($("#subjectDomain"),function(index,option){
				options_array.push(option.value);
			});

			$("#customSubjectDomain").on("blur",function(event){
				if($(this).val()!="" && $.inArray($(this).val(),options_array)==-1)
				{
						$("#subjectDomain").prepend("<option value='"+$(this).val()+"'>"+$(this).val()+"</option>");
						options_array.push($(this).val());
				}
				document.getElementById("subjectDomain").selectedIndex=0;
				$(this).hide();
		});

	   $(window).on('beforeunload', function(eventObject) {
			    if (windowUnloadWarning)
			    {
			        localStorage.clear();
			    }
		});
});

											/************End of Data binding **************/
function pushPermissionSet(buttonId)
{
	if(validateInput())
	{
		// form action url
		if(buttonId=="modifyAction")
		{
			url = $("#contextUrl").val()+"editor/"+$("#permissionSetIdentifier").val()+"/modify";
		}
		else if(buttonId=="modifyNewAction" || buttonId=="newAction")
		{
			url = $("#contextUrl").val()+"editor/save";
		}

		// preparing the json data, change the
		// names for the new form

		var subPermissions=[];

		var keyCount=0;
		/*this means fetch sub permissions from local storage*/
		if($("#permissionSetIdentifier").val()=="" || localStorage.getItem("temporaryState"))
		{
			while(keyCount<localStorage.length)
			{
				if(localStorage.key(keyCount).split("_")[0]=='permissionName')
				{
					var subPermission={};
					subPermission=jQuery.parseJSON(localStorage.getItem(localStorage.key(keyCount)));
					keyCount++;
					subPermissions.push(subPermission);
				}
				keyCount++;
			}
		}
		else
		{
			var rows=$("#permissionTable tr");
			/*first row is the header, so ignoring that*/
			for(var i=1;i<rows.length;i++)
			{

				var subPermission={};

				/** Have to be careful below because the td's have been indexed hard coded which means
				 * it should be consistent with the ordering of cells in the permissionTable.jsp
				 * otherwise it will cause problem
				 * **/
				subPermission["name"]=$("#"+rows[i].id+" td[data-name]").attr("data-name");

				var subjects=[];

				var values=$("#"+rows[i].id+" td[data-subjects]").attr("data-subjects").split("<br/>");

				for(var j=0;j<values.length-1;j++)
				{
					items={};
					items["value"]=$.trim(values[j]);
					items["domains"]=[];
					subjects.push(items);
				}

				var actions=[];
				values=$("#"+rows[i].id+" td[data-actions]").attr("data-actions").split("<br/>");
				for(j=0;j<values.length-1;j++)
				{
					items={};
					items["value"]=$.trim(values[j]);
					items["domains"]=[];
					actions.push(items);
				}

				var resources=[];
				values=$("#"+rows[i].id+" td[data-resources]").attr("data-resources").split("<br/>");
				for(j=0;j<values.length-1;j++)
				{
					items={};
					items["value"]=$.trim(values[j]);
					items["domains"]=[];
					resources.push(items);
				}

				subPermission["resources"]=resources;
				subPermission["actions"]=actions;
				subPermission["subjects"]=subjects;
				subPermission["obligations"]=[];

				subPermissions.push(subPermission);
			}
		}

		var actionDomains=$("#actionDomain").val();
		var resourceDomains;
		if($("#resourceDomain").val()!="")
		{
			resourceDomains=$("#resourceDomain").val(); //encodeURIComponent($("#resourceDomain").val()).replace(/'/g,"%27");
		}
		else
		{
			resourceDomains=actionDomains;
		}
		var json={
				"name":$("#permissionSetName").val(),
				"actionDomains":[actionDomains],
				"subjectDomains":[$("#subjectDomain").val()],
				"resourceDomains":[resourceDomains],
				"subPermissions":subPermissions
		};

		$
		.ajax(
				{
					url : url,
					data : JSON
					.stringify(json),
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
						localStorage.clear();
						windowUnloadWarning=false;
						window.location.href=xhr.getResponseHeader('Location');
					},
					error: function (xhr, status, thrownError) {
						var errorMessage="<li>"+jQuery.parseJSON(xhr.responseText).userMessage+"</li>";
				         $("#errorList").html(errorMessage);
				         $('html,body').animate({ scrollTop: 0 }, 'slow', function () {
				          });
				         $("#alert").show();
				      }
				});
	    	}
}

function validateInput()
{
	var submit=true;
	var errorHtml="";
	$.each($("input[data-required='true']"),function(index,selectInput){
		if($("#"+selectInput.id).val()=="")
		{
			 if(selectInput.id=="permissionSetName"){
				 errorHtml+="<li id='"+selectInput.id+"Validation'> <b>Permission set</b> name cannot be empty </li>";
				 $("#"+selectInput.id+"Container").addClass("has-error");
				 submit=false;
			 }
		}
	});
	if($("#permissionTable tr td").hasClass("dataTables_empty"))
	{
		errorHtml+="<li id='noPermissionValidation'> <b>Permission set</b> cannot be saved without any permission </li>";
		submit=false;
	}
	if(!submit)
	{
		$("#errorList").html(errorHtml);
		$('html,body').animate({ scrollTop: 0 }, 'slow', function () {
          });
		$("#alert").show();
	}

	return submit;
}

//this part here deals with the deletion of the permissions permanently
function deletePermissions()
{
	var permissionsForLocalStorage=localStorage.permissions.split(",");

	var table=$("#permissionTable").DataTable();

	if(changeSelectedIndex)
	{
		$("#actionDomainTracker").val(document.getElementById("actionDomain").selectedIndex);
		$("#resourceDomain").val("");
		changeSelectedIndex=false;
	}

	/*checking if atleast one of the sub permissions is present
	 * in the local storage or not
	 * */
	if(Storage!="undefined" && $("#permissionSetIdentifier").val()=="")
	{
		/*
		 * removing the items which are to be deleted from local storage
		 * */
		for(var i=0;i<permissionsForLocalStorage.length;i++)
		{
			var keyCount=0;
			while(keyCount<localStorage.length)
			{
				if(localStorage.key(keyCount).split("_")[0]=='permissionName')
				{
					var object=$.parseJSON(localStorage.getItem(localStorage.key(keyCount)));

					if(object.name==permissionsForLocalStorage[i])
					{
						localStorage.removeItem(localStorage.key(keyCount));
						table.row($("[id='row-" + permissionsForLocalStorage[i]+"']")).remove().draw();
					}
				}
				keyCount++;
			}
		}
	}
	else
	{
		//removing the html and not changing the permissions xml instead
		for (var i = 0; i < permissionsForLocalStorage.length; i++)
		{
			table.row($("[id='row-" + permissionsForLocalStorage[i]+"']")).remove().draw();
		}
	}

	$("#warningContainer").hide();

	$("#deleteWarning").html("");

}

function prepareSetUp()
{
	if(!$("#permissionTable tr td").hasClass("dataTables_empty"))
		{
			//confirm from the user and delete the permissions
			if(window.confirm("Changing the action domain would lead to deletion of permissions. " +
					"Do you want to proceed ?"))
			{
				changeSelectedIndex=true;

				$.each($("#permissionTable tr td input[type='checkbox']"),function(i,input){
						$(input).attr("checked","checked");
					});

				$("#btnDeletePermission").trigger("click");
			}
			else
			{
				document.getElementById("actionDomain").selectedIndex=$("#actionDomainTracker").val();
			}
		}
		else
		{
			$("#actionDomainTracker").val(document.getElementById("actionDomain").selectedIndex);
		}
}

function navigateForPermission()
{
	//storing values so that they are there on reload
	if($("#permissionSetName").val()!="")
	{
		localStorage.permissionSetName=$("#permissionSetName").val();
	}

	localStorage.actionDomain=document.getElementById("actionDomain").selectedIndex;

	var href=$("#btnAddPermission").attr("data-href");

	windowUnloadWarning=false;

	if(changeSelectedIndex)
	{
		localStorage.temporaryState=true;
	}
	window.location.href=href+"?service="+$("#actionDomain").val();
}

function cancelNavigate(url)
{
	if(Storage!="undefined" && localStorage.length >0)
	{
		localStorage.clear();
	}

	windowUnloadWarning=false;

	window.location.href=url;
}


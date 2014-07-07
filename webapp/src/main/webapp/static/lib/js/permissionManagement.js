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
$(document)
.ready(
		function() {

			/*
			 * functionality for select all checkbox in permission
			 * management screen
			 */
			$("#selectAllPermission").click(
					function(event) {
						$("#permissionTable input[type='checkbox']")
						.attr("checked", this.checked);
					});

			$("#permissionTable tr td input[type='checkbox']")
			.click(
					function(event) {
						if ($("#permissionTable tr td input[type='checkbox']").length == $("#permissionTable tr td input:checked").length) {
							$("#selectAllPermission").attr(
									"checked", "checked");
						} else {
							$("#selectAllPermission")
							.removeAttr("checked");
						}
					});
			/*
			 * Functionality for sorting and searching on permission
			 * table
			 */
			$("#permissionTable").dataTable({
				"paging" : false,
				"order" : [ 1, 'asc' ],
				"columnDefs" : [ {
					"orderable" : false,
					"targets" : 0
				} ]
			});
			
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
						if (permissionsToDelete.length > 0) {
							if (typeof (Storage) !== "undefined") {
								/*
								 * storing the names in the
								 * session variable and will be
								 * deleted once window is closed
								 * or refreshed
								 */
								var permissionsToStore = new Array();
								for (var i = 0; i < permissionsToDelete.length; i++) {
									permissionsToStore[i] = permissionsToDelete[i].id;
									/*
									 * adding the hiding support
									 * for multiple rows
									 */
									$("[id='row-" + permissionsToStore[i]+"']")
									.hide("500");
								}
								sessionStorage.permissions = permissionsToStore;
								// need to separate the undo
								// from label
								$("#deleteWarning")
								.html(
										permissionsToDelete.length
										+ " permission(s) moved to trash ");
								$("#undoWarning").show();
								permissionDeleteTimeoutId = setTimeout(function(){deletePermissions();},10000);

							}
						}
					});
			$("#undoWarning").click(function() {

				clearTimeout(permissionDeleteTimeoutId);

				var ids = sessionStorage.permissions.split(",");

				for (var i = 0; i < ids.length; i++) {
					$("[id='row-" + ids[i]+"']").show("500");
				}

				sessionStorage.clear();

				$("#deleteWarning").html("");
				$(this).hide();
			});

			/* before loading unload event is fired warn the user if
					 	there are items to be deleted
			 */
			$(window).on('beforeunload', function() {
				if (sessionStorage.length != 0) 
				{
					clearTimeout(permissionDeleteTimeoutId);
					permissionDeleteTimeoutId=setTimeout(function(){deletePermissions();},10000);
					return "You have items which will be deleted";
				}
			});
			/*
			 * If there were and the user confirmed the loading
			 * all the items will be deleted from the session storage
			 * and from the permission xml file
			 * */
			$(window).on('load', function() {
				if (sessionStorage.length != 0) 
				{
					deletePermissions();
					clearTimeout(permissionDeleteTimeoutId);
				}
			});


			/*
			 * Attach a click handler to the save button for saving the
			 * permission set
			 */
			$("#createPermissionSetForm")
			.submit(
					function(event) {

						event.preventDefault();

						// form action url
						url = $(this).attr("action");

						// preparing the json data, change the
						// names for the new form
						
						var subPermissions=[];
						
						var rows=$("#permissionTable tr");
						
						for(var i=1;i<rows.length;i++)
						{
							var td=$("#"+rows[i].id+" td");
							
							var subPermission={};
							subPermission["name"]=td[1].innerHTML;
							
							var subjects=[];
							var values=td[2].innerHTML.split("<br>");
							for(var j=0;j<values.length-1;j++)
							{
								items={};
								items["value"]=$.trim(values[j]);
								items["domains"]=[];
								subjects.push(items);
							}
							
							var actions=[];
							values=td[3].innerHTML.split("<br>");
							for(j=0;j<values.length-1;j++)
							{
								items={};
								items["value"]=$.trim(values[j]);
								items["domains"]=[];
								actions.push(items);
							}
							
							var resources=[];
							values=td[4].innerHTML.split("<br>");
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
						
						var json={
								"name":$("#permissionSetName").val(),
								"actionDomains":[$("#actionDomain").val()],
								"subjectDomains":[$("#subjectDomain").val()],
								"resourceDomains":[$("#resourceDomain").val()],
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
										window.location.href=xhr.getResponseHeader('Location');
										
									}
								});
					});

		});

											/************End of Data binding **************/

//this part here deals with the deletion of the permissions permanently
function deletePermissions() 
{
	$.ajax({
		url : $("#contextUrl").val() + "/editor/delete/" +$("#permissionSetName").val()+"/"+ sessionStorage.permissions,
		type : "POST",
		success: function()
		{
			sessionStorage.clear();
			window.location.reload(true);
		}

	});
}
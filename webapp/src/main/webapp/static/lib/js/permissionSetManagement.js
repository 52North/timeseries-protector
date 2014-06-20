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
var setDeleteTimeoutId;

//attaching event handlers on load of the document
$(document)
.ready(
		function() {

			/* Attach a click handler to the save button for saving the
			 *  permission set
			 */ 
			$("#save").click(
					function(event) {

						// get the create permission form object
						var frm = $("#create");

						// form action url
						url = frm.attr("action");
						// preparing the json data, change the names for the new form
						var name = $("#permissionset-name").val();
						var type = $("#epService").val();
						var userRole = $("#subject-domain").val();
						var json = {
								"m_subjectDomains" : userRole,
								"m_name" : name
						};
						$.ajax(
								{
									url : url,
									data : JSON.stringify(json),
									contentType : "application/json",
									type : "POST",
									beforeSend : function(xhr) {
										xhr.setRequestHeader("Accept",
										"application/json");
										xhr.setRequestHeader(
												"Content-Type",
										"application/json");
									}
								}).done(function() {
									// alert("done");
								});
					});
			/*
			 * Functionality for sorting and searching
			 * on permission set table
			 * */
			$("#permissionSetTable").dataTable({
				"paging":   false,
				"order": [ 1, 'asc' ],
				"columnDefs": [
				               { "orderable": false, "targets": 0 }
				               ]
			});

			/*
			 * functionality for select all checkbox
			 * in permission set management
			 * */
			$("#selectAllPermissionSet").click( 
					function(event) {
						$("#permissionSetTable input[type='checkbox']")
						.attr("checked", this.checked);
					});

			$("#permissionSetTable tr td input[type='checkbox']")
			.click(
					function(event) {
						if ($("#permissionSetTable tr td input[type='checkbox']").length == $("#permissionSetTable tr td input:checked").length) {
							$("#selectAllPermissionSet").attr("checked",
							"checked");
						} else {
							$("#selectAllPermissionSet").removeAttr(
							"checked");
						}
					});


			/*
			 * deleting the permission set and implementing the local
			 * storage
			 */
			$("#btnDeletePermissionSet")
			.click(
					function(event) {
						/*
						 * fetching to see how many records are
						 * to be deleted, which then will be
						 * stored in the session
						 */
						var setsToDelete = $("#permissionSetTable label input:checked");
						if (setsToDelete.length > 0) {
							if (typeof (Storage) !== "undefined") {
								/*
								 * storing the names in the
								 * session variable and will be
								 * deleted once window is closed
								 * or refreshed
								 */
								var setsToStore = new Array();
								for (var i = 0; i < setsToDelete.length; i++) {
									setsToStore[i] = setsToDelete[i].id;
									/*
									 * adding the hiding support
									 * for multiple rows
									 */
									$("[id='row-" + setsToStore[i]+"']")
									.hide("500");
								}
								sessionStorage.permissionSets = setsToStore;
								// need to separate the undo
								// from label
								$("#deleteWarning")
								.html(
										setsToDelete.length
										+ " set(s) moved to trash ");
								$("#undoWarning").show();
								setDeleteTimeoutId = setTimeout(function(){deleteSets();},10000);

							}
						}
					});

			$("#undoWarning").click(function() {

				clearTimeout(setDeleteTimeoutId);

				var ids = sessionStorage.permissionSets.split(",");

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
					clearTimeout(setDeleteTimeoutId);
					setDeleteTimeoutId=setTimeout(function(){deleteSets();},10000);
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
					clearTimeout(setDeleteTimeoutId);
					deleteSets();
				}
			});

		});
//this part here deals with the deletion of the permission set from the arrayList
function deleteSets() 
{
	$.ajax({
		url : window.location.href + "delete/" + sessionStorage.permissionSets,
		type : "POST",
		success: function()
		{
			sessionStorage.clear();
			window.location.reload(true);
		}

	});
}
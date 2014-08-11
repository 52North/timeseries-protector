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

//checking for features supported by browser
if(!(Modernizr.json && Modernizr.localstorage && Modernizr.sessionstorage && 
	Modernizr.dataset && Modernizr.input.placeholder
	&& Modernizr.input.autofocus && Modernizr.input.multiple
	))
{
		window.location.href=window.location.href+"warn/browser";
}
	

//attaching event handlers on load of the document
$(document)
.ready(
		function() {

			/*
			 * Making sure that the url are decoded
			 * */
			$.each($("td[data-url]"), function(index,e) {

				$(e).html(decodeURIComponent($(e).html()));

			});

			/*
			 * Functionality for sorting and searching
			 * on permission set table
			 * */
			$("#permissionSetTable").dataTable({
				"paging":   false,
				"order": [ 2, 'asc' ],
				"oLanguage": {
					"sEmptyTable":"No permission sets available",
					},
				"columnDefs": [
				               { "orderable": false, "targets": [0,1] }
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

			$("#permissionSetTable tr input[type='checkbox']")
			.click(
					function(event) {
						if ($("#permissionSetTable tr td input[type='checkbox']").length == $("#permissionSetTable tr td input:checked").length) {
							$("#selectAllPermissionSet").attr("checked",
							"checked");
						} else {
							$("#selectAllPermissionSet").removeAttr(
							"checked");
						}
						if($("#permissionSetTable tr td input:checked").length >0 && $("#btnDeletePermissionSet").hasClass("disabled"))
						{
							$("#btnDeletePermissionSet").removeClass("disabled");
						}
						else if($("#permissionSetTable tr td input:checked").length ==0)
						{
							$("#btnDeletePermissionSet").addClass("disabled");
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
										+ "permission set(s) deleted ");
								$("#undoWarning").show();
								setDeleteTimeoutId = setTimeout(function(){deleteSets();},10000);

							}
						}

					});
			
			$("#viewXml").click(function(event){
				
				var url=$("#contextUrl").val()+"download/view";
				
				$.ajax({
					url: url,
					method: "GET",
					success: function(response){
						
						$("#xmlContent").text(response);
						$("#xmlContent").each(function(i, block) {
						    hljs.highlightBlock(block);
						  });
						$("#viewPermissionsXmlModal").modal("show");
					}
				});
			});

			/*
			 * hide the parent div on click of close button
			 * */
			$("button[class='close']").click(function(event){

				var parentDiv= $(this).parent("div");
				$("#"+parentDiv[0].id).hide();

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

//this part here deals with the deletion of the permission set permanently
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
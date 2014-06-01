var setDeleteTimeoutId;

function fetchData() {
	$.ajax({
		url : window.location.href + "new",
		type : "GET",
		success : function(response) {
			$("#modalContent").html(response);
		}
	}).done(function() {
		// alert("done");
	}).fail(function() {
		alert("Some error occured");
	}).always(function() {
		// alert( "complete" );
	});
}
// attaching event handlers on load of the document
$(document)
		.ready(
				function() {
					// Attach a click handler to the save button for saving the
					// permission set
					$("#save").click(
							function(event) {

								// get the create permission form object
								var frm = $("#create");

								// form action url
								url = frm.attr("action");
								// preparing the json data
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

					// functionality for select all checkbox
					$("#selectAll").click(
							function(event) {
								$("#permissionSetTable input[type='checkbox']")
										.attr("checked", this.checked);
							});

					$("#permissionSetTable input[type='checkbox']")
							.click(
									function(event) {
										if ($("#permissionSetTable input[type='checkbox']").length == $("#permissionSetTable input:checked").length) {
											$("#selectAll").attr("checked",
													"checked");
										} else {
											$("#selectAll").removeAttr(
													"checked");
										}
									});

					/*
					 * deleting the permission set and implementing the local
					 * storage
					 */
					$("#deletePermission")
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
													$("#row-" + setsToStore[i])
															.hide("500");
												}
												sessionStorage.data = setsToStore;
												// need to separate the undo
												// from label
												$("#deleteWarning")
														.html(
																setsToDelete.length
																		+ " set(s) moved to trash ");
												$("#undoWarning").show();
												setDeleteTimeoutId = setTimeout(function(){deleteSets();},7000);
														
											}
										}
									});

					$("#undoWarning").click(function() {

						clearTimeout(setDeleteTimeoutId);

						var ids = sessionStorage.data.split(",");

						for (var i = 0; i < ids.length; i++) {
							$("#row-" + ids[i]).show("500");
						}

						sessionStorage.clear();

						$("#deleteWarning").html("");
						$(this).hide();
					});

					// before loading unload event is fired warn the user if
					// there items to be deleted
					$(window).on('beforeunload', function() {
						if (sessionStorage.length != 0) 
						{
							clearTimeout(setDeleteTimeoutId);
							setDeleteTimeoutId=setTimeout(function(){deleteSets();},10000);
							return "You have items which will be deleted";
						}
					});
					$(window).on('load', function() {
						if (sessionStorage.length != 0) 
						{
							clearTimeout(setDeleteTimeoutId);
							deleteSets();
						}
					});

				});
//this part here deals with the deletion of the permission set from the arrayList
function deleteSets() {
	$.ajax({
		url : window.location.href + "delete/" + sessionStorage.data,
		type : "POST",
		success: function()
		{
			sessionStorage.clear();
			window.location.reload(true);
		}
	
	});
}
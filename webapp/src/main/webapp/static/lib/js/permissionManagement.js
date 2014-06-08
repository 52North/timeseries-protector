$(document).ready(function(){
	
	/*
	 * functionality for select all checkbox
	 * in permission management screen
	 * */
	$("#selectAllPermission").click( 
			function(event) {
				console.log("clicked");
				$("#permissionTable input[type='checkbox']")
				.attr("checked", this.checked);
			});

	$("#permissionTable input[type='checkbox']")
	.click(
			function(event) {
				if ($("#permissionTable tr td input[type='checkbox']").length == $("#permissionTable tr td input:checked").length) {
					$("#selectAllPermission").attr("checked",
					"checked");
				} else {
					$("#selectAllPermission").removeAttr(
					"checked");
				}
			});

	/*
	 * Method for displaying input box only if the
	 * resource is selected
	 */
	$("#modalContentPermission .checkbox input[type='checkbox']").click(
				function() 
				{
					if (this.checked) 
					{
						$("#" + this.id + "Input").show();
					} else 
					{
						$("#" + this.id + "Input").hide();
					}

				});
	/*
	 * Method for displaying the selected permission
	 * for modifying
	 * */
	$("#permissionTable button").click(
	function(event)
	{
		$.ajax({
			type:"GET",
			url:window.location.href+"edit/"+$("#permissionSetName").val()+"/"+this.id.split("#")[1],
			success: function(response)
			{
				$("#PermissionModalLabel").html("Modify Permission");
				$("#modalContentPermission").html(response);	
				$("#addNewPermission").modal({
					backdrop:true,
					keyboard:true,
					show:true
				});
			}
		});
	}
	);
});


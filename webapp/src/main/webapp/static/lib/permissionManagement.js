function fetchData ()
{
	$.ajax({
  	  url: window.location.href+"new",
  	  type: "GET",
	  success:function(response)
	  {
		$("#modalContent").html(response);
	  }
  	}).done(function() {
  	  //alert("done");
  	}).fail(function() {
  	    alert( "Some error occured" );
    })
    .always(function() {
      //alert( "complete" );
    });
}

$(document).ready(function() {
// Attach a click handler to the save button for saving the permission set
 $( "#save" ).click(function( event ) {

	//get the form object
	var frm = $("#create");	
   
	//form action url
    url = frm.attr("action");
 	//preparing the json data
	var name=$("#permissionset-name").val();
	var type=$("#epService").val();
	var userRole=$("#subject-domain").val();
	var json={"m_subjectDomains":userRole,"m_name":name};
    $.ajax({
    	  url: url,
    	  data: JSON.stringify(json),
    	  contentType : "application/json",
    	  type: "POST",
    	   beforeSend: function(xhr) {
            xhr.setRequestHeader("Accept", "application/json");
            xhr.setRequestHeader("Content-Type", "application/json");
        }
    	}).done(function() {
    	 // alert("done");
    	});
});

//functionality for select all checkbox
$("#selectAll").click(function(event){	
	$("#permissionSetTable input[type='checkbox']").attr("checked",this.checked);	
});
$("#permissionSetTable input[type='checkbox']").click(function(event){
	if($("#permissionSetTable input[type='checkbox']").length==$("#permissionSetTable input:checked").length)
	{
		$("#selectAll").attr("checked","checked");
	}
	else
	{
		$("#selectAll").removeAttr("checked");
	}
});

$("#deletePermission").click(function(event){
 //fetching to see how many records are to be deleted, which then will be stored in the session
 var setsToDelete=$("#permissionSetTable label input:checked");
 
 if(setsToDelete.length >0)
 {
	if(typeof(Storage)!=="undefined")
	{		
		//storing in the session variable and will be deleted once window is closed or refreshed
		sessionStorage.count=setsToDelete.length;
		$("#deleteWarning").html(sessionStorage.count+" set(s) moved to trash "+"<u>Undo</u>");
	}
 }
});

$("#deleteWarning").click(function(event){
	//here count will be replaced by the key-value pairs representing the objects to be re-stored
	if(Number(sessionStorage.count)>0)
	{
		sessionStorage.count=0;
	}
	$("#deleteWarning").html("");
});

});
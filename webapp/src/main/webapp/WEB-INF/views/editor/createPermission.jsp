<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2>Create PermissionSet</h2>

<form enctype="application/x-www-form-urlencoded" id="create" action="<c:url value='/editor/save' />" method="POST" class="form-horizontal">

    <div class="control-group">
        <label class="control-label" form="permissionset-name">Name</label>
        <div class="controls">
            <input type="text" name="permissionset-name" />
            <span class="help-block">Type the permission set's name.</span>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label" form="epService">Enforcement Point</label>
        <div class="controls">
            <select name="epService" id="epService">
                <c:forEach items="${enforcementPoints}" var="epfs">
                    <option selected="false" value="" style="display: none;"><c:out value="${epfs.type}"/></option>
                </c:forEach>
            </select>
            <span class="help-block">Select the endpoint to protect</span>
        </div>
    </div>
	
    <div class="control-group">
        <label class="control-label" form="subject-domain">Subject Domain</label>
        <div class="controls">
            <select name="subject-domain" id="subject-domain">
                <option selected="true" style="display: none;">urn:n52:security:subject:role</option>
            </select>
            <span class="help-block">Select the subject's domain.</span>
        </div>
    </div>

    <div><button class="btn btn-info pull-left" type="submit">Save</button></div>
</form>
<script type="text/javascript">
// Attach a submit handler to the form
/* $( "#create" ).submit(function( event ) {

	var frm = $("#create");	
	// Stop form from submitting normally
  event.preventDefault();
 
  // Get some values from elements on the page:
    term=JSON.stringify(frm.serializeArray());
    url = '/editor/save';
 
  //Send the data using post
  var posting = $.post( url, {term} );
 
  // Put the results in a div
  posting.done(function( data ) {
    alert("success");
  });
}); */
</script>


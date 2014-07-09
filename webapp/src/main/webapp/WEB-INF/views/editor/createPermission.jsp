<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<div class="container-fluid">
	<form role="form" action="<c:url value="/editor/${permissionSet}/save"/>" enctype="application/json" method="POST"
		id="createPermissionForm">
	<input id="permissionSet" type="hidden" value="${permissionSet}" />
	
	<div id="basicScreen">	
		<tiles:insertDefinition name="basicScreen"></tiles:insertDefinition>
	</div>
	
	<div id="actionScreen" >
		<tiles:insertDefinition name="actionScreen"></tiles:insertDefinition>
		 <br/>
	</div>
	
	<div id="resourceScreen" >
		<tiles:insertDefinition name="resourceScreen"></tiles:insertDefinition>
	</div>
	
	<button id="savePermission" type="submit" class="btn btn-primary">SAVE</button>
	
</form>
</div>
<script type="text/javascript"
	src="<c:url value="/static/lib/js/wizardManagement.js" />">
</script>
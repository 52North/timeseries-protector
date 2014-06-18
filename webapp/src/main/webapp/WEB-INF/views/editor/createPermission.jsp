<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<div class="container-fluid">
	<form role="form" action="#" enctype="application/json" method="POST"
		id="createPermissionForm">
	
	<div id="basicScreen">	
		<tiles:insertDefinition name="basicScreen"></tiles:insertDefinition>
		
		<button id="basicScreen-resourceScreen" type="button"
			class="btn btn-primary">Next ></button>
	</div>
	
	<div id="resourceScreen" style="display:none;">
		<tiles:insertDefinition name="resourceScreen"></tiles:insertDefinition>
		<button id="resourceScreen-basicScreen" type="button"
			class="btn btn-info">&lt; Back</button>
		<button id="resourceScreen-actionScreen" type="button"
			class="btn btn-primary">Next &gt;</button>
	</div>
	
	<div id="actionScreen" style="display:none;">
		<tiles:insertDefinition name="actionScreen"></tiles:insertDefinition>
		<button id="actionScreen-resourceScreen" type="button"
			class="btn btn-info">&lt; Back</button>
		<button id="actionScreen-obligationScreen" type="button"
			class="btn btn-primary">Next &gt;</button>
	</div>
	
	<div id="obligationScreen" style="display:none;">
		<tiles:insertDefinition name="obligationScreen"></tiles:insertDefinition>
		<button id="obligationScreen-actionScreen" type="button"
			class="btn btn-info">&lt; Back</button>
		<button id="savePermission" type="button" class="btn btn-success">Add
		</button>
	</div>	
	</form>
</div>
<script type="text/javascript"
	src="<c:url value="/static/lib/js/wizardManagement.js" />">
</script>
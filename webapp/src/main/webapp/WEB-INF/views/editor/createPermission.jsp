<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<div class="modal container fade" id="basicScreen" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
	style="display: none;">
	<div class="modal-header bg-primary">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="PermissionModalLabel">Add Permission</h4>
	</div>
	<div id="basicModalContentPermission" class="modal-body">
		<tiles:insertDefinition name="basicScreen"></tiles:insertDefinition>
	</div>
	<div class="modal-footer">
		<button id="basicScreen-resourceScreen" type="button"
			class="btn btn-primary">Next ></button>
		<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
	</div>
</div>

<div class="modal container" id="resourceScreen" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
	style="display: none;">
	<div class="modal-header bg-primary">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="PermissionModalLabel">Add Resources</h4>
	</div>
	<div id="resourceModalContentPermission" class="modal-body">
		<tiles:insertDefinition name="resourceScreen"></tiles:insertDefinition>
	</div>
	<div class="modal-footer">
		<button id="resourceScreen-basicScreen" type="button"
			class="btn btn-info">&lt; Back</button>
		<button id="resourceScreen-actionScreen" type="button"
			class="btn btn-primary">Next &gt;</button>
		<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
	</div>
</div>

<div class="modal container" id="actionScreen" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
	style="display: none;">
	<div class="modal-header bg-primary">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="PermissionModalLabel">Add Actions</h4>
	</div>
	<div id="actionModalContentPermission" class="modal-body">
		<tiles:insertDefinition name="actionScreen"></tiles:insertDefinition>
	</div>
	<div class="modal-footer">
		<button id="actionScreen-resourceScreen" type="button"
			class="btn btn-info">&lt; Back</button>
		<button id="actionScreen-obligationScreen" type="button"
			class="btn btn-primary">Next &gt;</button>
		<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
	</div>
</div>

<div class="modal container" id="obligationScreen" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
	style="display: none;">
	<div class="modal-header bg-primary">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="PermissionModalLabel">Add Obligations</h4>
	</div>
	<div id="obligationModalContentPermission" class="modal-body">
		<tiles:insertDefinition name="obligationScreen"></tiles:insertDefinition>
	</div>
	<div class="modal-footer">
		<button id="obligationScreen-actionScreen" type="button"
			class="btn btn-info">&lt; Back</button>
		<button id="savePermission" type="button" class="btn btn-success">Add
		</button>
		<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
	</div>
</div>
<script type="text/javascript"
	src="<c:url value="/static/lib/js/wizardManagement.js" />">
	
</script>
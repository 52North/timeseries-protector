<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<form enctype="application/json" role="form" id="createPermissionSet"
	action="<c:url value='/editor/save' />" method="POST">

	<div class="form-group">
		<label class="control-label">* Name :</label>
		<div class="row">
			<div class="col-xs-8">
				<input style="margin-top: 5px" id="permissionSetName"
					class="form-control" value="${permissionSet.getName()}" type="text"
					name="permissionSetName" placeholder="Permission Set Name" />
			</div>
		</div>
		<p class="help-block">Permission set name</p>
	</div>

	<div class="form-group">
		<label class="control-label">* Action Domain :</label> <input
			style="margin-top: 5px" id="actionDomain" class="form-control"
			type="url" value="${permissionSet.getActionDomains().get(0)}"
			name="actionDomain" placeholder="Action Domain URL" />
		<p class="help-block">URL for the Operations</p>
	</div>

	<div class="form-group">
		<label class="control-label">* Resource Domain :</label> <input
			style="margin-top: 5px" id="resourceDomain" class="form-control"
			type="url" value="${permissionSet.getResourceDomains().get(0)}"
			name="resourceDomain" placeholder="Resource Domain URL" />
		<p class="help-block">URL for the Resources</p>
	</div>

	<div class="form-group">
		<label class="control-label">* Subject Domain :</label> <input
			style="margin-top: 5px" id="subjectDomain" class="form-control"
			value="${permissionSet.getSubjectDomains().get(0)}" type="url"
			name="subjectDomain" placeholder="Subject Domain URL" />
		<p class="help-block">Domain for User Roles</p>
	</div>

	<br /> <br />

	<button id="btnAddPermission" type="button" class="btn btn-default"
		title="Add Permission">
		<span class="glyphicon glyphicon-plus"></span>
	</button>
	&nbsp;
	<button type="button" id="btnDeletePermission" class="btn btn-default"
		title="Delete Permission">
		<span class="glyphicon glyphicon-trash"></span>
	</button>

	<div class="table-responsive">
		<tiles:insertDefinition name="permissionTable"></tiles:insertDefinition>
	</div>

	<div id="createPermisisonContainer">
	<!-- Content loaded by Ajax -->
	</div>

</form>
<script type="text/javascript"
	src="<c:url value="/static/lib/js/permissionManagement.js" />">
</script>
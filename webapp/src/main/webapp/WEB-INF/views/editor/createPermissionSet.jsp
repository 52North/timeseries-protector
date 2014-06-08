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

	<button type="button" data-toggle="modal" href="#addNewPermission"
		class="btn btn-default" title="Add Permission">
		<span class="glyphicon glyphicon-plus"></span>
	</button>
	&nbsp;
	<button type="button" id="deletePermission" class="btn btn-default"
		title="Delete Permission">
		<span class="glyphicon glyphicon-trash"></span>
	</button>

	<div class="table-responsive">
		<table id="permissionTable" style="margin-top: 15px;"
			class="table table-striped table-hover">
			<thead>
				<tr>
					<th><input id="selectAllPermission" type="checkbox" /> Select All</th>
					<th>Name</th>
					<th>Subject (s)</th>
					<th>Resource(s)</th>
					<th>Action (s)</th>
					<th>Obligation (s)</th>
					<th>Modify</th>
				</tr>
			</thead>
			<c:forEach items="${permissionSet.getSubPermissions()}"
				var="permissions">
				<tr id="row-${permissions.getName()}">
					<td>
						<div class="checkbox">
							<label> <input id="${permissions.getName()}"
								type="checkbox">
							</label>
						</div>
					</td>
					<td><c:out value="${permissions.getName()}"></c:out></td>
					<td><c:choose>
							<c:when test="${permissions.getSubjects().size()>0}">
								<c:forEach items="${permissions.getSubjects()}" var="subjects">
									<c:out value="${subjects.getValue()}"></c:out>,
							</c:forEach>
							</c:when>
							<c:otherwise>
								<c:out value="Not Found"></c:out>
							</c:otherwise>
						</c:choose></td>
					<td><c:choose>
							<c:when test="${permissions.getResources().size()>0}">
								<c:forEach items="${permissions.getResources()}" var="resources">
									<c:out value="${resources.getValue()}"></c:out>,
						</c:forEach>
							</c:when>
							<c:otherwise>
								<c:out value="Not Found"></c:out>
							</c:otherwise>
						</c:choose></td>
					<td><c:choose>
							<c:when test="${permissions.getActions().size()>0}">
								<c:forEach items="${permissions.getActions()}" var="actions">
									<c:out value="${actions.getValue()}"></c:out>,
						</c:forEach>
							</c:when>
							<c:otherwise>
								<c:out value="Not Found"></c:out>
							</c:otherwise>
						</c:choose></td>
					<td><c:choose>
							<c:when test="${permissions.getObligations().size()>0}">
								<c:forEach items="${permissions.getObligations()}"
									var="obligations">
									<c:out value="${obligations.getValue()}"></c:out>,
						</c:forEach>
							</c:when>
							<c:otherwise>
								<c:out value="Not Found"></c:out>
							</c:otherwise>
						</c:choose></td>
					<td>
						<button id="btn#${permissions.getName()}" class="btn btn-default btn-xs"
							type="button">MODIFY</button>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div class="modal fade" id="addNewPermission" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="PermissionModalLabel">Add New
				Permission</h4>
		</div>
		<div id="modalContentPermission" class="modal-body">
			<tiles:insertDefinition name="createPermission"></tiles:insertDefinition>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
			<button id="save" type="button" class="btn btn-primary">Save</button>
		</div>
	</div>
</form>
<script type="text/javascript"
	src="<c:url value="/static/lib/js/permissionManagement.js" />">
</script>
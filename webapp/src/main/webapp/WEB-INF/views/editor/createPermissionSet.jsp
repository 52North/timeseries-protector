<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<div class="container-fluid">

	<div id="warningContainer" class="container-fluid">
		<center>
			<h4>
				<span id="deleteWarning" class="label label-warning"></span>
			</h4>
			<button style="display: none;" id="undoWarning" type="button"
				class="btn btn-warning">Undo</button>
		</center>
	</div>
	<form enctype="application/json" autocomplete="on" role="form"
		id="createPermissionSetForm" action="<c:url value='/editor/save' />"
		method="POST">
		<input id="contextUrl" type="hidden" value="${contextUrl}" />
		<div class="form-group">
			<label class="control-label">* Name :</label>
			<div class="row">
				<div class="col-xs-8">
				  <c:if test="${permissionSet==null}">
					<input autofocus style="margin-top: 5px" id="permissionSetName"
						class="form-control" required value="${permissionSet.getName()}"
						type="text" name="permissionSetName"
						placeholder="Permission Set Name" />
				  </c:if>
				  <c:if test="${permissionSet!=null}">
					<input disabled style="margin-top: 5px" id="permissionSetName"
						class="form-control" required value="${permissionSet.getName()}"
						type="text" name="permissionSetName"
						placeholder="Permission Set Name" />
				  </c:if>		
				</div>
			</div>
			<p class="help-block">Permission set name</p>
		</div>

		<div class="form-group">
			<label class="control-label">* Action Domain :</label> <input
				style="margin-top: 5px" required id="actionDomain"
				class="form-control" type="url"
				value="${permissionSet.getActionDomains().get(0)}"
				name="actionDomain" placeholder="Action Domain URL" />
			<p class="help-block">URL for the Operations</p>
		</div>

		<div class="form-group">
			<label class="control-label">* Resource Domain :</label> <input
				style="margin-top: 5px" required id="resourceDomain"
				class="form-control" type="url"
				value="${permissionSet.getResourceDomains().get(0)}"
				name="resourceDomain" placeholder="Resource Domain URL" />
			<p class="help-block">URL of the end point to protect</p>
		</div>

		<div class="form-group">
			<label class="control-label">* Subject Domain :</label> <input
				style="margin-top: 5px" required id="subjectDomain"
				class="form-control"
				value="${permissionSet.getSubjectDomains().get(0)}" type="url"
				name="subjectDomain" placeholder="Subject Domain URL" />
			<p class="help-block">URL for restricting the user role</p>
		</div>

		<br /> <br />
		<c:choose>
			<c:when test="${permissionSet!=null}">
				<a id="btnAddPermission"
					href="<c:url value="/editor/edit/${permissionSet.getName()}/newPermission" />"
					class="btn btn-default" title="Add Permission"> <span
					class="glyphicon glyphicon-plus"></span>
				</a> &nbsp;
		</c:when>
			<c:otherwise>
				<a id="btnAddPermission"
					href="<c:url value="/editor/edit/new/newPermission" />"
					class="btn btn-default" title="Add Permission"> <span
					class="glyphicon glyphicon-plus"></span>
				</a> &nbsp;
		</c:otherwise>
		</c:choose>
		<button type="button" id="btnDeletePermission" class="btn btn-default"
			title="Delete Permission">
			<span class="glyphicon glyphicon-trash"></span>
		</button>
		<div class="table-responsive">
			<tiles:insertDefinition name="permissionTable"></tiles:insertDefinition>
		</div>
		<br /> <br />
		<button type="submit" class="btn btn-primary">Save</button>
	</form>
</div>
<script type="text/javascript"
	src="<c:url value="/static/lib/js/permissionManagement.js" />">
</script>
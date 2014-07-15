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
	<div id="alert" style="display: none;"
		class="alert alert-danger alert-dismissible" role="alert">
		<button type="button" class="close">
			<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
		</button>
		<ul id="errorList">

		</ul>
	</div>
	<form enctype="application/json" autocomplete="on" role="form"
		id="createPermissionSetForm"
		<c:if test="${context!='modify'}">
		   	action="<c:url value='/editor/save' />"
		</c:if>
		<c:if test="${context=='modify'}">
		   	action="<c:url value='/editor/${permissionSet.getName()}/modify' />"
		</c:if>
		method="POST">
		<input id="contextUrl" type="hidden" value="${contextUrl}" />
		<div class="form-group">
			<label class="control-label">* Name :</label>
			<div class="row">
				<div id="permissionSetNameContainer" class="col-xs-8">
					<input data-required="true" autofocus style="margin-top: 5px" id="permissionSetName"
						class="form-control" value="${permissionSet.getName()}"
						type="text" name="permissionSetName"
						placeholder="Permission Set Name" />
				</div>
			</div>
			<p class="help-block">Permission set name</p>
		</div>

		<div class="form-group">
			<label class="control-label">* Action Domain :</label>
			<div id="actionDomainContainer">
				<input data-required="true" style="margin-top: 5px" id="actionDomain"
					class="form-control" type="url"
					value="${permissionSet.getActionDomains().get(0)}"
					name="actionDomain" placeholder="Action Domain URL" />
			</div>
			<p class="help-block">URL for the Operations</p>
		</div>

		<br />
		<!-- Tiles definition for the advance content -->
		<tiles:insertDefinition name="advanceSection"></tiles:insertDefinition>

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
		<button title="Save Permission Set" type="submit"
			class="btn btn-primary">Save</button>
		<c:forEach varStatus="loop" items="${breadCrumb}" var="entry">
			<c:choose>
				<c:when test="${loop.index==breadCrumb.size()-2}">
					<button title="Cancel Permission Set"
						onclick="window.location.href='${entry.value}'" type="button"
						class="btn btn-default">Cancel</button>
				</c:when>
			</c:choose>
		</c:forEach>
	</form>
</div>
<script type="text/javascript"
	src="<c:url value="/static/lib/js/permissionManagement.js" />">
	
</script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<div class="container-fluid">

	<tiles:insertDefinition name="errorSection"></tiles:insertDefinition>

	<form role="form" enctype="application/json" method="POST"
		id="createPermissionForm">

		<!-- Hidden fields for house keeping tasks -->
		<input id="permissionSet" type="hidden" value="${permissionSet}" /> <input
			id="permissionIdentifier" value="${permission.getName()}"
			name="existingName" type="hidden">
		<input id="url" type="hidden" value="<c:url value="/editor/${permissionSet}/" />" />
		<input id="contextUrl" type="hidden" value="<c:url value="/" />" />

		<div id="basicScreen">
			<tiles:insertDefinition name="basicScreen"></tiles:insertDefinition>
		</div>

		<div id="actionScreen">
			<tiles:insertDefinition name="actionScreen"></tiles:insertDefinition>
			<br />
		</div>

		<div id="resourceScreen">
			<tiles:insertDefinition name="resourceScreen"></tiles:insertDefinition>
		</div>

		<br />

		<c:if test="${context!='modify' && permissionSet=='new'}">
			<button onclick="pushPermission(this.id)"
				title="Save Permission Temporarily" type="button"
				name="saveButton"
				class="btn btn-info">Save Temporarily</button>
		</c:if>

		<c:if test="${context!='modify' && permissionSet!='new'}">
			<button onclick="pushPermission(this.id)" id="modifyNewAction"
				title="Save Permission" type="button"
				name="saveButton"
				class="btn btn-info">Save</button>
		</c:if>

		<c:if test="${context=='modify'}">
			<button onclick="pushPermission(this.id)" id="modifyAction"
				name="saveButton" title="Save Permission" type="button" class="btn btn-primary">Save
			</button>

			<button onclick="pushPermission(this.id)" id="modifyNewAction"
				title="Save As New Permission" type="button" class="btn btn-info">Save
				As New</button>
		</c:if>

		<input id="url" type="hidden" value="<c:url value="/editor/${permissionSet}/" />" />

		<!-- Setting the url for cancel button appropriately -->
		<c:forEach varStatus="loop" items="${breadCrumb}" var="entry">
			<c:choose>
				<c:when test="${loop.index==breadCrumb.size()-2}">
					<button title="Cancel Permission"
						onclick="window.location.href='${entry.value}'" type="button"
						class="btn btn-default">Cancel</button>
				</c:when>
			</c:choose>
		</c:forEach>
	</form>
</div>
<script type="text/javascript" src="<c:url value="/static/js/wizardManagement.js" />" >
</script>
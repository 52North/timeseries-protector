<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<div class="container-fluid">
	<div id="alert" style="display: none;"
		class="alert alert-danger alert-dismissible" role="alert">
		<button type="button" class="close">
			<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
		</button>
		<ul id="errorList">
		</ul>
	</div>
	<form role="form"
		<c:if test="${context=='modify'}">	
		action="<c:url value="/editor/${permissionSet}/${permission.getName()}/modify"/>"
	   </c:if>
		<c:if test="${context!='modify'}">	
		action="<c:url value="/editor/${permissionSet}/save"/>"
	   </c:if>
		enctype="application/json" method="POST" id="createPermissionForm">
		
		<!-- Hidden fields for house keeping tasks -->
		  <input id="permissionSet" type="hidden" value="${permissionSet}" />
		  <input id="permissionIdentifier" value="${permission.getName()}" name="existingName" type="hidden">
		
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

		<button title="Save Permission" id="savePermission" type="submit"
			class="btn btn-primary">Save</button>

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
<script type="text/javascript"
	src="<c:url value="/static/lib/js/wizardManagement.js" />">
	
</script>
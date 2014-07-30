
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<link rel="stylesheet"
	href="<c:url value="/static/lib/css/googlecode.css" />" type="text/css" />
<script type="text/javascript"
	src="<c:url value="/static/lib/js/highlight.pack.js" />">
</script>
	
<div class="container-fluid">
	
	<tiles:insertDefinition name="viewPermissionsXml"></tiles:insertDefinition>
	
	<tiles:insertDefinition name="warningSection"></tiles:insertDefinition>
	
	<br /> <a title="Add Permission Set"
		href="<c:url value="/editor/new" />" id="btnAddPermissionSet"
		class="btn btn-default" role="button"> <span
		class="glyphicon glyphicon-plus"></span>
	</a>&nbsp;
	
	<button class="btn btn-default disabled" id="btnDeletePermissionSet"
		title="Delete Permission Set">
		<span class="glyphicon glyphicon-trash"></span>
	</button>&nbsp;
	
	<button id="viewXml" title="View Permissions Xml"
		class="btn btn-default" role="button"> 
		<span class="glyphicon glyphicon-new-window"></span>
	</button>
	
	<br />
	<input type="hidden" id="contextUrl" value="<c:url value="/"/>">
	<!-- This table will be created programmatically by jsps, just creating now for the sake of templating -->
	<div class="table-responsive">
		<table style="table-layout: fixed;word-wrap:break-word;" id="permissionSetTable"
			class="table-bordered table-hover order-column">
			<thead>
				<tr>
					<th><input id="selectAllPermissionSet" type="checkbox" />
						Select All</th>
					<th>Action</th>
					<th>Name</th>
					<th>Subject Domain</th>
					<th>Resource Domain</th>
					<th>Action Domain</th>
				</tr>
			</thead>
			<c:forEach items="${permissionSets}" var="permissionSet">
				<tr id="row-${permissionSet.getName()}">
					<td>
						<div class="checkbox">
							<label> <input id="${permissionSet.getName()}"
								type="checkbox">
							</label>
						</div>
					</td>
					<td>
						 <a 
							href="<c:url value="/editor/edit/${permissionSet.getName()}" />"
							class="btn btn-default btn-xs" role="button">MODIFY
						</a>
					</td>
					
					<td><c:out value="${permissionSet.getName()}"></c:out></td>
					<c:forEach items="${permissionSet.getSubjectDomains()}"
						var="subjectDomains">
						<td><c:out value="${subjectDomains}" /></td>
					</c:forEach>
					<c:forEach items="${permissionSet.getResourceDomains()}"
						var="resourceDomains">
						<td data-url><c:out value="${resourceDomains}" /></td>
					</c:forEach>
					<c:forEach items="${permissionSet.getActionDomains()}"
						var="actionDomains">
						<td data-url><c:out value="${actionDomains}" /></td>
					</c:forEach>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>

<script type="text/javascript"
	src="<c:url value="/static/lib/js/permissionSetManagement.js" />">
</script>
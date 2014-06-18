<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<table id="permissionTable" style="margin-top: 15px;"
	class="table-bordered table-hover order-column">
	<thead>
		<tr>
			<th><input id="selectAllPermission" type="checkbox" /> Select
				All</th>
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
			<td><a id="btn#${permissions.getName()}"
				href="/protector-webapp/editor/edit/${permissionSet.getName()}/${permissions.getName()}"
				class="btn btn-default btn-xs" role="button">MODIFY</a></td>
		</tr>
	</c:forEach>
</table>

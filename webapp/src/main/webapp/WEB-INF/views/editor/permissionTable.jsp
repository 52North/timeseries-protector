<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style type="text/css">
td {
	vertical-align: top;
}
</style>
<table id="permissionTable" style="table-layout: fixed;word-wrap:break-word;margin-top: 15px;"
	class="table-bordered table-hover order-column">
	<thead>
		<tr>
			<th><input id="selectAllPermission" type="checkbox" /> Select
				All</th>
			<th>Action</th>
			<th>Name</th>
			<th>Subject(s)</th>
			<th>Operation(s)</th>
			<th>Resource(s)</th>
			<th>Obligation(s)</th>
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
			<td><a
				href="<c:url value="/editor/edit/${permissionSet.getName()}/${permissions.getName()}" />"
				class="btn btn-default btn-xs" role="button">MODIFY</a></td>
			<td data-name="${permissions.getName()}"><c:out
					value="${permissions.getName()}"></c:out></td>

			<td
				data-subjects="
				<c:choose>
					<c:when test="${permissions.getSubjects().size()>0}">
						<c:forEach items="${permissions.getSubjects()}" var="subjects">
							<c:out value="${subjects.getValue()}"></c:out>
							<br/>
						</c:forEach>
					</c:when>
					<c:otherwise>
					</c:otherwise>
				</c:choose>
			">
				<c:choose>
					<c:when test="${permissions.getSubjects().size()>0}">
						<c:forEach items="${permissions.getSubjects()}" var="subjects">
							<c:out value="${subjects.getValue()}"></c:out>
							<br />
						</c:forEach>
					</c:when>
					<c:otherwise>
						<c:out value="Not Found"></c:out>
					</c:otherwise>
				</c:choose>
			</td>
			<td
				data-actions="
				<c:choose>
					<c:when test="${permissions.getActions().size()>0}">
						<c:forEach items="${permissions.getActions()}" var="actions">
							<c:out value="${actions.getValue()}"></c:out>
							<br/>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<c:out value=""></c:out>
					</c:otherwise>
				</c:choose>
			">
				<c:choose>
					<c:when test="${permissions.getActions().size()>0}">
						<c:forEach items="${permissions.getActions()}" var="actions">
							<c:out
								value="${fn:substringAfter(actions.getValue(),'operations/')}"></c:out>
							<br />
						</c:forEach>
					</c:when>
					<c:otherwise>
						<c:out value="Not Found"></c:out>
					</c:otherwise>
				</c:choose>
			</td>
			<td
				data-resources="
				<c:choose>
					<c:when test="${permissions.getResources().size()>0}">
						<c:forEach items="${permissions.getResources()}" var="resources">
							<c:out value="${resources.getValue()}"></c:out>
							<br/>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<c:out value=""></c:out>
					</c:otherwise>
				</c:choose>
			">
				<c:choose>
					<c:when test="${permissions.getResources().size()>0}">
						<c:set var="start_proc" value="" />
						<c:set var="start_off" value="" />
						<c:set var="start_foi" value="" />
						<c:set var="start_obp" value="" />
						<c:forEach items="${permissions.getResources()}" var="resources">
							<c:choose>
								<c:when
									test="${fn:substringBefore(resources.getValue(),'/')=='procedures'}">
									<c:if test="${start_proc==''}">
										<label style="font-style: oblique;" class="control-label">Procedures</label>
										<br />
										<c:set var="start_proc" value="found" />
									</c:if>
						   			&nbsp;<span data-url>${fn:substringAfter(resources.getValue(),'procedures/')}</span>
						   			 <br />
								</c:when>
								<c:when
									test="${fn:substringBefore(resources.getValue(),'/')=='offerings'}">
									<c:if test="${start_off==''}">
										<label style="font-style: oblique;" class="control-label">Offerings</label>
										<br />
										<c:set var="start_off" value="found" />
									</c:if>
						   			&nbsp;<span data-url>${fn:substringAfter(resources.getValue(),'offerings/')}</span>
						   			 <br />
								</c:when>
								<c:when
									test="${fn:substringBefore(resources.getValue(),'/')=='featuresOfInterest'}">
									<c:if test="${start_foi==''}">
										<label style="font-style: oblique;" class="control-label">Features
											of Interest</label>
										<br />
										<c:set var="start_foi" value="found" />
									</c:if>
						   			&nbsp;<span data-url>${fn:substringAfter(resources.getValue(),'featuresOfInterest/')}</span>
						   			 <br />
								</c:when>
								<c:when
									test="${fn:substringBefore(resources.getValue(),'/')=='observedProperties'}">
									<c:if test="${start_obp==''}">
										<label style="font-style: oblique;" class="control-label">Observed
											Properties</label>
										<br />
										<c:set var="start_obp" value="found" />
									</c:if>
						   	   		&nbsp;<span data-url>${fn:substringAfter(resources.getValue(),'observedProperties/')}</span>
						   	   		 <br />
								</c:when>
							</c:choose>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<c:out value="Not Found"></c:out>
					</c:otherwise>
				</c:choose>
			</td>
			<td><c:choose>
					<c:when test="${permissions.getObligations().size()>0}">
						<c:forEach items="${permissions.getObligations()}"
							var="obligations">
							${obligations.getValue()}
						</c:forEach>
					</c:when>
					<c:otherwise>
						<c:out value="Not Found"></c:out>
					</c:otherwise>
				</c:choose></td>
		</tr>
	</c:forEach>
</table>

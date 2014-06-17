<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<div class="container-fluid">
	<c:if test="${permissionSets.size()>0}">
		<div id="warningContainer" class="container-fluid">
			<center>
				<h4>
					<span id="deleteWarning" class="label label-warning"></span>
				</h4>
				<button style="display: none;" id="undoWarning" type="button"
					class="btn btn-warning">Undo</button>
			</center>
		</div>

		<br />
		<button data-toggle="modal" href="#addNewPermissionSet"
			class="btn btn-default" id="btnAddPermissionSet"
			title="Add Permission Set">
			<span class="glyphicon glyphicon-plus"></span>
		</button>
		&nbsp;
		<button id="btnDeletePermissionSet" class="btn btn-default"
			title="Delete Permission Set">
			<span class="glyphicon glyphicon-trash"></span>
		</button>

		<br />

		<!-- This table will be created programmatically by jsps, just creating now for the sake of templating -->
		<div class="table-responsive">
			<table id="permissionSetTable"
				class="table-bordered table-hover order-column">
				<thead>
					<tr>
						<th><input id="selectAllPermissionSet" type="checkbox" />
							Select All</th>
						<th>Name</th>
						<th>Subject Domain</th>
						<th>Resource Domain</th>
						<th>Action Domain</th>
						<th>Modify</th>
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
						<td><c:out value="${permissionSet.getName()}"></c:out></td>
						<c:forEach items="${permissionSet.getSubjectDomains()}"
							var="subjectDomains">
							<td><c:out value="${subjectDomains}" /></td>
						</c:forEach>
						<c:forEach items="${permissionSet.getResourceDomains()}"
							var="resourceDomains">
							<td><c:out value="${resourceDomains}" /></td>
						</c:forEach>
						<c:forEach items="${permissionSet.getActionDomains()}"
							var="actionDomains">
							<td><c:out value="${actionDomains}" /></td>
						</c:forEach>
						<td>
							<button id="btn#${permissionSet.getName()}"
								class="btn btn-default btn-xs" type="button">MODIFY</button>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</c:if>
	<!-- Modal -->
	<div class="modal fade container" id="addNewPermissionSet"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true" style="display: none;">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="permissionSetModalLabel"></h4>
		</div>
		<div id="modalContentPermissionSet" class="modal-body">
			<!-- Content Loaded By Ajax -->
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
			<button id="save" type="button" class="btn btn-primary">Save</button>
		</div>
	</div>
</div>
<c:if test="${permissionSets.size()==0}">
	<div style="margin-top: 7%;" class="center-block">
		<center>
			<h3>
				<span class="label label-info"> No permission set found,
					please add new permission set </span> &nbsp;
				<button onclick="fetchData();" data-toggle="modal"
					data-target="#addNewPermissionSet" class="btn btn-default"
					title="Add Permission">
					<span class="glyphicon glyphicon-plus"></span>
				</button>
			</h3>
		</center>
	</div>
</c:if>

<script type="text/javascript"
	src="<c:url value="/static/lib/js/permissionSetManagement.js" />">
</script>
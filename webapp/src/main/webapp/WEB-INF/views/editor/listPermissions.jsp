<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<div class="container-fluid">
	<c:if test="${permissionSets.size()>0}">
		<div class="container-fluid">
			<center>
				<h4>
					<span style="cursor: pointer;" id="deleteWarning"
						class="label label-warning"></span>
				</h4>
			</center>
		</div>

		<br />
		<button onclick="fetchData();" data-toggle="modal"
			data-target="#addNew" class="btn btn-default" title="Add Permission">
			<span class="glyphicon glyphicon-plus"></span>
		</button>
		&nbsp;
		<button id="deletePermission" class="btn btn-default"
			title="Delete Permission">
			<span class="glyphicon glyphicon-trash"></span>
		</button>

		<!-- This table will be created programmatically by jsps, just creating now for the sake of templating -->

		<table id="permissionSetTable" style="margin-top: 15px;"
			class="table table-striped table-hover table-responsive">
			<thead>
				<tr>
					<th><input id="selectAll" type="checkbox" /> Select All</th>
					<th>Name</th>
					<th>Subject Domain</th>
					<th>Resource Domain</th>
					<th>Action Domain</th>
					<th>Modify</th>
				</tr>
			</thead>
			<c:forEach items="${permissionSets}" var="permission">
				<tr>
					<td>
						<div class="checkbox">
							<label> <input type="checkbox">
							</label>
						</div>
					</td>
					<td><c:out value="${permission.getName()}"></c:out></td>
					<td><c:out value="${permission.getSubjectDomains().get(0)}" /></td>
					<td><c:out value="${permission.getResourceDomains().get(0)}" /></td>
					<td><c:out value="${permission.getActionDomains().get(0)}" /></td>
					<td><a class="btn btn-default btn-xs" href="#">MODIFY</a></td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	<!-- Modal -->
	<div class="modal fade" id="addNew" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">Add New Permission
						Set</h4>
				</div>
				<div id="modalContent" class="modal-body"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
					<button id="save" type="button" class="btn btn-primary">Save</button>
				</div>
			</div>
		</div>
	</div>

	<c:if test="${permissionSets.size()==0}">

		<center>
			<h3>
				<span class="label label-info"> No permission set found,
					please add new permission set </span> &nbsp;
				<button onclick="fetchData();" data-toggle="modal"
					data-target="#addNew" class="btn btn-default"
					title="Add Permission">
					<span class="glyphicon glyphicon-plus"></span>
				</button>
			</h3>
		</center>
	</c:if>
</div>
<script type="text/javascript"
	src="<c:url value="/static/lib/permissionManagement.min.js" />">
	
</script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<div class="container-fluid">
	<center>
		<h4>
			<span style="cursor: pointer;" id="deleteWarning"
				class="label label-warning"></span>
		</h4>
	</center>
</div>

<div class="container-fluid">
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
				<th>Actions</th>
				<th>Name</th>
				<th>Date Created</th>
				<th>Enforcement Point</th>
				<th>User Role</th>
			</tr>
		</thead>

		<tr>
			<td>
				<div class="checkbox">
					<label> <input type="checkbox">
					</label>
				</div>
			</td>
			<td><a class="btn btn-default btn-xs" href="#">MODIFY</a></td>
			<td>Manager set</td>
			<td>5/28/2014</td>
			<td>SOS</td>
			<td>Manager</td>
		</tr>
		<tr>
			<td>
				<div class="checkbox">
					<label> <input type="checkbox">
					</label>
				</div>
			</td>
			<td><a class="btn btn-default btn-xs" href="#">MODIFY</a></td>
			<td>Guest set</td>
			<td>5/21/2014</td>
			<td>WMS</td>
			<td>Guest</td>
		</tr>
		<tr>
			<td>
				<div class="checkbox">
					<label> <input type="checkbox">
					</label>
				</div>
			</td>
			<td><a class="btn btn-default btn-xs" href="#">MODIFY</a></td>
			<td>Admin set</td>
			<td>5/28/2014</td>
			<td>SOS</td>
			<td>Admin</td>
		</tr>
	</table>
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
</div>
<script type="text/javascript" src="<c:url value="/static/lib/permissionManagement.min.js" />">

</script>
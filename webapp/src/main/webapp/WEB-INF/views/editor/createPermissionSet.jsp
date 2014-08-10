<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<div class="container-fluid">

	<tiles:insertDefinition name="warningSection"></tiles:insertDefinition>

	<tiles:insertDefinition name="errorSection"></tiles:insertDefinition>

	<tiles:insertDefinition name="infoSection"></tiles:insertDefinition>

	<form enctype="application/json" autocomplete="on" role="form"
		id="createPermissionSetForm" method="POST">
		<div class="form-group">
			<div class="row">
				<div class="col-xs-8">
					<label class="control-label">* Name :</label>
				</div>
				<div class="col-xs-4 text-right">
					<span style="cursor: pointer;" data-container="body"
						data-toggle="popover" data-placement="left"
						data-content="Permission set name has to be unique"
						class="glyphicon glyphicon-question-sign"> </span>
				</div>
			</div>
			<div class="row">
				<div id="permissionSetNameContainer" class="col-xs-8">
					<input data-required="true" autofocus style="margin-top: 5px"
						id="permissionSetName" class="form-control"
						value="${permissionSet.getName()}" type="text"
						name="permissionSetName" placeholder="Permission Set Name" />
				</div>
			</div>
			<p class="help-block">Permission set name</p>
		</div>

		<!-- Hidden fields for house keeping tasks -->
		<input id="contextUrl" type="hidden" value="<c:url value="/"/>" /> 
		<input
			type="hidden" id="permissionSetIdentifier"
			value="${permissionSet.getName()}" />
		<input type="hidden" id="actionDomainTracker" />	

		<div class="form-group">
			<div class="row">
				<div class="col-xs-8">
					<label class="control-label">* Action Domain :</label>
				</div>
				<div class="col-xs-4 text-right">
					<span style="cursor: pointer;" data-container="body"
						data-toggle="popover" data-placement="left"
						data-content="Action Domain is the URI which specifies the end point for the 
						operations to be restricted by the permissions which are part of this permission
						set. Action Domain and Resource Domain can have the same values. Changing the value
						will lead to deletion of permissions due to inconsistency"
						class="glyphicon glyphicon-question-sign"> </span>
				</div>
			</div>
			<div id="actionDomainContainer">
				<select 
					onchange="prepareSetUp();" data-required="true" style="margin-top: 5px"
					id="actionDomain" class="form-control" name="actionDomain">
					<c:forEach items="${preConfiguredEnforcementPoints}" var="pcep">
						<c:if test="${pcep.key==permissionSet.getActionDomains().get(0)}">	
							<option data-url selected value="${pcep.key}">${pcep.key}</option>
						</c:if>
						<c:if test="${pcep.key!=permissionSet.getActionDomains().get(0)}">	
							<option data-url value="${pcep.key}">${pcep.key}</option>
						</c:if>
					</c:forEach>
				</select>
			</div>
			<p class="help-block">URL for the Operations</p>
		</div>

		<br />
		<!-- Tiles definition for the advance content -->
		<tiles:insertDefinition name="advanceSection"></tiles:insertDefinition>

		<br /> <br />

		<c:choose>
			<c:when test="${permissionSet!=null}">
				<button id="btnAddPermission"
					data-href="<c:url value="/editor/edit/${permissionSet.getName()}/newPermission" />"
					type="button"
					onclick="navigateForPermission();"
					class="btn btn-default" title="Add Permission"> <span
					class="glyphicon glyphicon-plus"></span>
				</button> &nbsp;
			</c:when>
			<c:otherwise>
				<button id="btnAddPermission"
					data-href="<c:url value="/editor/edit/new/newPermission" />"
					type="button"
					onclick="navigateForPermission();"
					class="btn btn-default" title="Add Permission"> <span
					class="glyphicon glyphicon-plus"></span>
				</button> &nbsp;
			</c:otherwise>
		</c:choose>

		<button class="btn btn-default disabled" type="button"
			id="btnDeletePermission" title="Delete Permission">
			<span class="glyphicon glyphicon-trash"></span>
		</button>

		<div class="table-responsive">
			<tiles:insertDefinition name="permissionTable"></tiles:insertDefinition>
		</div>

		<br /> <br />

		<c:if test="${context!='modify'}">
			<button onclick="pushPermissionSet(this.id)" id="newAction"
				title="Save Permission Set" type="button" class="btn btn-primary">Save</button>
		</c:if>

		<c:if test="${context=='modify'}">
			<button onclick="pushPermissionSet(this.id)" id="modifyAction"
				title="Save Permission Set" type="button" class="btn btn-primary">Save</button>

			<button onclick="pushPermissionSet(this.id)" id="modifyNewAction"
				title="Save As New Permission Set" type="button"
				class="btn btn-info">Save As New</button>
		</c:if>

		<c:forEach varStatus="loop" items="${breadCrumb}" var="entry">
			<c:choose>
				<c:when test="${loop.index==breadCrumb.size()-2}">
					<button title="Cancel Permission Set"
						onclick="cancelNavigate('${entry.value}');" type="button"
						class="btn btn-default">Cancel</button>
				</c:when>
			</c:choose>
		</c:forEach>
	</form>
</div>
<script type="text/javascript"
	src="<c:url value="/static/lib/js/permissionManagement.js" />">
</script>
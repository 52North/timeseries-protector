<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<form enctype="application/json" role="form" id="create"
	action="<c:url value='/editor/save' />" method="POST"
	class="form-horizontal">

	<div class="control-group">
		<label class="control-label" form="permissionset-name">Name</label>
		<div class="controls">
			<input id="permissionset-name" type="text" name="permissionset-name"
				placeholder="Permission Set Name" /> <span class="help-block">Type
				the permission set's name.</span>
		</div>
	</div>

	<div class="control-group">
		<label class="control-label" form="epService">Enforcement
			Point</label>
		<div class="controls">
			<select name="epService" id="epService">
				<c:forEach items="${enforcementPoints}" var="epfs">
					<option selected="true" value="<c:out value="${epfs.type}"/>"><c:out
							value="${epfs.type}" /></option>
				</c:forEach>
			</select> <span class="help-block">Select the endpoint to protect</span>
		</div>
	</div>

	<div class="control-group">
		<label class="control-label" form="subject-domain">Subject
			Domain</label>
		<div class="controls">
			<select name="subject-domain" id="subject-domain">
				<c:forEach items="${users}" var="configUsers">
					<c:forEach items="${configUsers}" var="user">
						<option selected="true" value="<c:out value="${user}"></c:out>"><c:out
								value="${user}"></c:out></option>
					</c:forEach>
				</c:forEach>
			</select> <span class="help-block">Select the subject's domain.</span>
		</div>
	</div>

</form>
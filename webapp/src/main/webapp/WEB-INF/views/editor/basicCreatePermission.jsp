<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="panel panel-default">
	<div class="panel-heading">Basic Info</div>
	<div class="panel-body">
		<div id="nameContainer" class="form-group">
			<label class="control-label">* Permission Name :</label>
			
			<input type="hidden" value="" id="originalName" />
			<c:if test="${permission.getName()==''}">
				<input required style="margin-top: 5px" autofocus
					id="permissionName" class="form-control" type="text"
					value="${permission.getName()}" name="permissionName"
					placeholder="Permission Name" />
			</c:if>
			<c:if test="${permission.getName()!=''}">
				<input readOnly required style="margin-top: 5px;cursor:auto;" autofocus
					id="permissionName" class="form-control" type="text"
					value="${permission.getName()}" name="permissionName"
					placeholder="Permission Name" />
			</c:if>
		</div>

		<div class="form-group">
			<label class="control-label">* Subject :</label> <select
				id="selectSubjects" multiple class="form-control">
				<c:forEach items="${users}" var="user">
					<c:forEach items="${permission.getSubjects()}" var="subjects">
						<c:if test="${user == subjects.getValue()}">
							<option selected="selected" value="${user}">${user}</option>
							<c:set var="user_value" value="${user}" scope="page"></c:set>
						</c:if>
					</c:forEach>
					<c:if test="${user_value != user}">
						<option value="${user}">${user}</option>
					</c:if>
				</c:forEach>
			</select>
		</div>
	</div>
</div>
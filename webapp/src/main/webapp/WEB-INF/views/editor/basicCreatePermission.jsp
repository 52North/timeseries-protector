<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="form-group">
	<label class="control-label">* Permission Name :</label> <input
		style="margin-top: 5px" autofocus id="permissionName" class="form-control"
		type="text" value="${permission.getName()}" name="permissionName"
		placeholder="Permission Name" />
</div>

<div class="form-group">
	<label class="control-label">* Subject :</label> <select multiple
		class="form-control">
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
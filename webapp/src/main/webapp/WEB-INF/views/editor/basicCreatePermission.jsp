<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<br />
<div class="form-group">
	<div class="row">
		<div class="col-xs-8">
			<label class="control-label">* Permission Name :</label>
		</div>
		<div class="col-xs-4 text-right">
			<span style="cursor: pointer;" data-container="body"
				data-toggle="popover" data-placement="left"
				data-content="Permission name has to be unique i.e. no two permissions which are part 
				of the same permission set can have the same names"
				class="glyphicon glyphicon-question-sign">
			</span>
		</div>
	</div>
	<div id="permissionNameContainer">
		<input data-required="true" style="margin-top: 5px; cursor: auto;"
			autofocus id="permissionName" class="form-control" type="text"
			value="${permission.getName()}" name="permissionName"
			placeholder="Permission Name" />
	</div>
</div>
<div class="row">
	<div class="col-xs-8">
		<label class="control-label">* Subject :</label>
	</div>
	<div class="col-xs-4 text-right">
		<span style="cursor: pointer;" data-container="body"
			data-toggle="popover" data-placement="left"
			data-content="Role names of the users on which this permission will be applied, you can select multiple
			values as well"
			class="glyphicon glyphicon-question-sign"> </span>
	</div>
</div>
<div id="selectSubjectsContainer">
	<select id="selectSubjects" multiple class="form-control">
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
<br />
<hr />
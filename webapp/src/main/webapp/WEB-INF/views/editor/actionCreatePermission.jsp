<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="panel panel-default">
	<div class="panel-heading">Actions</div>
	<div class="panel-body">
		<div id="action">
			<select multiple id="selectActions"
				class="form-control">
			<c:forEach items="${actionValues}" var="values">
				<c:forEach items="${permission.getActions()}" var="targetValue">
					<c:if test="${fn:substringAfter(targetValue.getValue(),\"/\")==values.getActionValue()}">
						<option selected value="${values.getActionValue()}">${values.getActionValue()}</option>
						<c:set var="found_value" scope="page"
									value="${values.getActionValue()}" />
					</c:if>						
				</c:forEach>
				<c:if test="${found_value != values.getActionValue()}">
							<option value="${values.getActionValue()}">${values.getActionValue()}
							</option>
						</c:if>
			</c:forEach>	
			</select>
		</div>
	</div>
</div>
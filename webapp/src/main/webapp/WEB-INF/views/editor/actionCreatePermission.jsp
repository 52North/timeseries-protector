<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="panel panel-default">
	<div class="panel-heading">Actions</div>
	<div class="panel-body">
		<div id="action">
			<select multiple id="selectActions" class="form-control">
				<c:forEach items="${permission.getActions()}" var="targetValue">
					<c:set var="parsedValue"
						value="${fn:substringAfter(targetValue.getValue(),\"/\")}"
						scope="page" />
					<c:choose>
						<c:when test="${parsedValue!=\"*\"}">
							<c:forEach items="${actionValues}" var="values">
								<c:if test="${parsedValue==values.getActionValue()}">
									<option selected value="${values.getActionValue()}">${values.getActionValue()}</option>
									<c:set var="found_value" scope="page"
										value="${values.getActionValue()}" />
								</c:if>
							</c:forEach>
							<c:if test="${found_value != parsedValue}">
								<option value="${parsedValue}">${parsedValue}</option>
							</c:if>
						</c:when>
						<c:otherwise>
							<c:forEach items="${actionValues}" var="values">
							<option selected value="${values.getActionValue()}">${values.getActionValue()}</option>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</select>
		</div>
	</div>
</div>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<label class="control-label">* Actions</label>
<br />
<div style="resize: vertical; overflow: auto;"
	id="selectActionsContainer">
	<select style="height: inherit;" multiple id="selectActions"
		class="form-control">
		<c:choose>
			<c:when test="${permission.getActions().get(0).getValue()=='operations/*'}">
				<c:forEach items="${actionValues}" var="values">
					<option selected value="${values.getActionValue()}">${values.getActionValue()}</option>
				</c:forEach>
			</c:when>
			<c:when test="${permission.getActions().size() > 0}">
				<!-- This means it is the modify option -->
				<c:set var="found" value="" scope="page" />
				<c:forEach items="${actionValues}" var="values">
					<c:forEach items="${permission.getActions()}" var="targetValue">
						<c:if
							test='${fn:substringAfter(targetValue.getValue(),"/")==values.getActionValue()}'>
							<option selected value="${values.getActionValue()}">${values.getActionValue()}</option>
							<c:set var="found" value="found" scope="page" />
						</c:if>
					</c:forEach>
					<c:if test="${found==''}">
						<option value="${values.getActionValue()}">${values.getActionValue()}</option>
					</c:if>
					<c:set var="found" value="" scope="page" />
				</c:forEach>
			</c:when>
			<c:otherwise>
				<c:forEach items="${actionValues}" var="values">
					<option value="${values.getActionValue()}">${values.getActionValue()}</option>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</select>
</div>
<br />

<button id="toggleActions" type="button" class="btn btn-danger btn-xs">Toggle</button>

<button id="clearActions" type="button" class="btn btn-default btn-xs">Clear</button>

<hr />

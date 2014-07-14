<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<label class="control-label">* Actions</label>
<br />
<div style="resize: vertical; overflow: auto;" id="selectActionsContainer">
	<select style="height: inherit;" multiple id="selectActions"
		class="form-control">
		<c:choose>
			<c:when test="${permission.getActions().size() > 1}">
				<!-- This means it is the modify option -->
				<option value="*">All</option>
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
				<c:if
					test="${permission.getActions().get(0).getValue()==\"operations/*\"}">
					<option selected value="*">All</option>
				</c:if>
				<c:if
					test="${permission.getActions().get(0).getValue()!=\"operations/*\"}">
					<option value="*">All</option>
				</c:if>
				<c:forEach items="${actionValues}" var="values">
					<option value="${values.getActionValue()}">${values.getActionValue()}</option>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</select>
</div>
<br />
<hr />

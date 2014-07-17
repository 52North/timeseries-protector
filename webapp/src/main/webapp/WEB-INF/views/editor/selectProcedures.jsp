<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div id="selectProceduresContainer"
	style="resize: vertical; overflow: auto;">
	<select style="height: inherit;" multiple id="selectProcedures"
		class="form-control">
		<c:forEach items="${procedures}" var="procedure">
			<c:forEach items="${permission.getResources()}" var="targetValue">
				<c:set var="parsed"
					value="${fn:substringAfter(targetValue.getValue(),\"procedures/\")}" />
				<c:if
					test="${parsed!='procedures/*' && parsed==procedure.getDomainId()}">
					<option selected value="${procedure.getDomainId()}">${procedure.getDomainId()}
					</option>
					<c:set var="found_procedure" scope="page"
						value="${procedure.getDomainId()}" />
				</c:if>
			</c:forEach>
			<c:if test="${found_procedure != procedure.getDomainId()}">
				<option value="${procedure.getDomainId()}">${procedure.getDomainId()}
				</option>
			</c:if>
		</c:forEach>
	</select>
</div>
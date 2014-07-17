<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div id="selectObservedPropertiesContainer"
	style="resize: vertical; overflow: auto;">
	<select style="height: inherit;" multiple id="selectObservedProperties"
		class="form-control">
		<c:forEach items="${phenomenon}" var="phenomenon">
			<c:forEach items="${permission.getResources()}" var="targetValue">
				<c:if
					test="${fn:substringAfter(targetValue.getValue(),\"observedProperties/\")==phenomenon.getDomainId()}">
					<option selected value="${phenomenon.getDomainId()}">${phenomenon.getDomainId()}
					</option>
					<c:set var="found_phenomenon" scope="page"
						value="${phenomenon.getDomainId()}" />
				</c:if>
			</c:forEach>
			<c:if test="${found_phenomenon != phenomenon.getDomainId()}">
				<option value="${phenomenon.getDomainId()}">${phenomenon.getDomainId()}
				</option>
			</c:if>
		</c:forEach>
	</select>
</div>
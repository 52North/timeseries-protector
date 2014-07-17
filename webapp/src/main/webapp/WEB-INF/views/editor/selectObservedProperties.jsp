<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div id="selectObservedPropertiesContainer"
	style="resize: vertical; overflow: auto;">
	<select style="height: inherit;" multiple id="selectObservedProperties"
		class="form-control">
		<c:choose>
			<c:when
				test="${selectedObservedProperties.get(0)=='observedProperties/*'}">
				<c:forEach items="${phenomenon}" var="phenomenon">
					<option selected value="${phenomenon.getDomainId()}">${phenomenon.getDomainId()}
					</option>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<c:forEach items="${phenomenon}" var="phenomenon">
					<c:forEach items="${selectedObservedProperties}" var="targetValue">
						<c:if
							test="${fn:substringAfter(targetValue,'observedProperties/')==phenomenon.getDomainId()}">
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
			</c:otherwise>
		</c:choose>
	</select>
</div>
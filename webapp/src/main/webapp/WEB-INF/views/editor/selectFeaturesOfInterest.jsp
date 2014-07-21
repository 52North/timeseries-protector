<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div id="selectFeaturesOfInterestContainer"
	style="resize: vertical; overflow: auto;">
	<select style="height: inherit;" multiple id="selectFeaturesOfInterest"
		class="form-control">
		<c:choose>
			<c:when test="${selectedFeaturesOfInterest.get(0)=='featuresOfInterest/*'}">
				<c:forEach items="${featuresOfInterest}" var="foi">
					<option selected value="${foi.getDomainId()}">${foi.getDomainId()}
							</option>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<c:forEach items="${featuresOfInterest}" var="foi">
					<c:forEach items="${selectedFeaturesOfInterest}" var="targetValue">
						<c:if
							test="${fn:substringAfter(targetValue,'featuresOfInterest/')==foi.getDomainId()}">
							<option selected value="${foi.getDomainId()}">${foi.getDomainId()}
							</option>
							<c:set var="found_foi" scope="page" value="${foi.getDomainId()}" />
						</c:if>
					</c:forEach>
					<c:if test="${found_foi != foi.getDomainId()}">
						<option value="${foi.getDomainId()}">${foi.getDomainId()}</option>
					</c:if>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</select>
</div>
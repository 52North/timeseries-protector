<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div id="selectFeaturesOfInterestContainer"
	style="resize: vertical; overflow: auto;">
	<select style="height: inherit;" multiple id="selectFeaturesOfInterest"
		class="form-control">
		<c:forEach items="${featuresOfInterest}" var="foi">
			<c:forEach items="${permission.getResources()}" var="targetValue">
				<c:if
					test="${fn:substringAfter(targetValue.getValue(),\"featuresOfInterest/\")==foi.getDomainId()}">
					<option selected value="${foi.getDomainId()}">${foi.getDomainId()}
					</option>
					<c:set var="found_foi" scope="page" value="${foi.getDomainId()}" />
				</c:if>
			</c:forEach>
			<c:if test="${found_foi != foi.getDomainId()}">
				<option value="${foi.getDomainId()}">${foi.getDomainId()}</option>
			</c:if>
		</c:forEach>
	</select>
</div>
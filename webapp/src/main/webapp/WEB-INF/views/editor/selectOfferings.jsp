<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div id="selectOfferingsContainer"
	style="resize: vertical; overflow: auto;">
	<select style="height: inherit;" multiple id="selectOfferings"
		class="form-control">
		<c:forEach items="${offerings}" var="off">
			<c:forEach items="${permission.getResources()}" var="targetValue">
				<c:if
					test="${fn:substringAfter(targetValue.getValue(),\"offerings/\")==off.getDomainId()}">
					<option selected value="${off.getDomainId()}">${off.getDomainId()}
					</option>
					<c:set var="found_off" scope="page" value="${off.getDomainId()}" />
				</c:if>
			</c:forEach>
			<c:if test="${found_off != off.getDomainId()}">
				<option value="${off.getDomainId()}">${off.getDomainId()}</option>
			</c:if>
		</c:forEach>
	</select>
</div>
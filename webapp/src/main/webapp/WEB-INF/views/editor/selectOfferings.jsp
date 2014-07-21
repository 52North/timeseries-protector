<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div id="selectOfferingsContainer"
	style="resize: vertical; overflow: auto;">
	<select style="height: inherit;" multiple id="selectOfferings"
		class="form-control">
		<c:choose>
			<c:when test="${selectedOfferings.get(0)=='offerings/*'}">
				<c:forEach items="${offerings}" var="off">
					<option selected value="${off.getDomainId()}">${off.getDomainId()}
					</option>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<c:forEach items="${offerings}" var="off">
					<c:forEach items="${selectedOfferings}" var="targetValue">
						<c:if
							test="${fn:substringAfter(targetValue,'offerings/')==off.getDomainId()}">
							<option selected value="${off.getDomainId()}">${off.getDomainId()}
							</option>
							<c:set var="found_off" scope="page" value="${off.getDomainId()}" />
						</c:if>
					</c:forEach>
					<c:if test="${found_off != off.getDomainId()}">
						<option value="${off.getDomainId()}">${off.getDomainId()}</option>
					</c:if>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</select>
</div>
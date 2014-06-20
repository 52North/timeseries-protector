<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<br />
<br />
<div id="action">
	<c:choose>
		<c:when test="${permission.getActions().size()>0}">
			<c:forEach begin="1" varStatus="loop"
				items="${permission.getActions()}" var="action">
				<div id="actionRow-${loop.index}" class="row">
					<div class="col-xs-8">
						<div class="input-group">
							<span class="input-group-addon"> <input type="checkbox">
							</span> <input value="${resource.getValue()}" type="text"
								class="form-control" />
						</div>
					</div>
				</div>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<div id="actionRow-1" class="row">
				<div class="col-xs-8">
					<div class="input-group">
						<span class="input-group-addon"> <input type="checkbox">
						</span> <input placeholder="action value" type="text"
							class="form-control" />
					</div>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
</div>
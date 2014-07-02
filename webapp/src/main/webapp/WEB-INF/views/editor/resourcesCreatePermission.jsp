<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="panel panel-default">
	<div class="panel-heading">Resources</div>
	<div class="panel-body">

		<ul class="nav nav-tabs">
			<li class="active"><a href="#procedures" data-toggle="tab">Procedures</a></li>
			<li><a href="#offerings" data-toggle="tab">Offerings</a></li>
			<li><a href="#featuresOfInterest" data-toggle="tab">Features
					Of Interest</a></li>
			<li><a href="#observedProperties" data-toggle="tab">Observed
					Properties</a></li>
		</ul>

		<!-- Tab panes -->
		<div class="tab-content">
			<div class="tab-pane active" id="procedures">
				<br /> <select multiple 
					id="selectProcedures" class="form-control">
					<c:forEach items="${procedures}" var="procedure">
						<c:forEach items="${permission.getResources()}" var="targetValue">
							<c:if test="${fn:substringAfter(targetValue.getValue(),\"/\")==procedure.getDomainId()}">
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
				<p class="help-block">Press Ctrl for selecting more than one
					value</p>
			</div>

			<!--------------------------------- Offerings ----------------------------------->

			<div class="tab-pane" id="offerings">
				<br /> <select multiple 
					id="selectOfferings" class="form-control">
					<c:forEach items="${offerings}" var="off">
						<c:forEach items="${permission.getResources()}" var="targetValue">
							<c:if test="${fn:substringAfter(targetValue.getValue(),\"/\")==off.getDomainId()}">
								<option selected value="${off.getDomainId()}">${off.getDomainId()}
								</option>
								<c:set var="found_off" scope="page"
									value="${off.getDomainId()}" />
							</c:if>
						</c:forEach>
						<c:if test="${found_off != off.getDomainId()}">
							<option value="${off.getDomainId()}">${off.getDomainId()}
							</option>
						</c:if>
					</c:forEach>
				</select>
				<p class="help-block">Press Ctrl for selecting more than one
					value</p>
			</div>

			<!--------------------------------- Features of Interest ----------------------------------->

			<div class="tab-pane" id="featuresOfInterest">
				<br /> <select multiple 
					id="selectFeaturesOfInterest" class="form-control">
					<c:forEach items="${featuresOfInterest}" var="foi">
						<c:forEach items="${permission.getResources()}" var="targetValue">
							<c:if test="${fn:substringAfter(targetValue.getValue(),\"/\")==foi.getDomainId()}">
								<option selected value="${foi.getDomainId()}">${foi.getDomainId()}
								</option>
								<c:set var="found_foi" scope="page"
									value="${foi.getDomainId()}" />
							</c:if>
						</c:forEach>
						<c:if test="${found_foi != foi.getDomainId()}">
							<option value="${foi.getDomainId()}">${foi.getDomainId()}
							</option>
						</c:if>
					</c:forEach>
				</select>
				<p class="help-block">Press Ctrl for selecting more than one
					value</p>
			</div>

			<!--------------------------------- Observed Properties ----------------------------------->

			<div class="tab-pane" id="observedProperties">
				<br /> <select multiple 
					id="selectObservedProperties" class="form-control">
					<c:forEach items="${phenomenon}" var="phenomenon">
						<c:forEach items="${permission.getResources()}" var="targetValue">
							<c:if test="${fn:substringAfter(targetValue.getValue(),\"/\")==phenomenon.getDomainId()}">
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
				<p class="help-block">Press Ctrl for selecting more than one
					value</p>
			</div>
		</div>
	</div>
</div>
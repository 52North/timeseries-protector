<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
		<br />
		<div class="row">
			<div class="col-xs-1">
				<div style="margin-top: 2px; margin-bottom: 0px;" class="checkbox">
					<label> <input id="selectProcedures" type="checkbox">
					</label>
				</div>
			</div>
			<div class="col-xs-1">
				<button onclick="addProcedure();" class="btn btn-default btn-xs">
					<span class="glyphicon glyphicon-plus"></span>
				</button>
			</div>
			<div class="col-xs-1">
				<button onclick="deleteProcedure();" class="btn btn-default btn-xs">
					<span class="glyphicon glyphicon-trash"></span>
				</button>
			</div>
		</div>
		<c:set var="loop" value="1" scope="page"></c:set>
		<c:forEach items="${permission.getResources()}" var="resource">
			<c:if test="${fn:startsWith(resource.getValue(),'procedures/')}">
				<div id="proceduresRow-${loop}" style="margin-top: 10px;"
					class="row">
					<div class="col-xs-8">
						<div class="input-group">
							<span class="input-group-addon"> <input
								id="procedureCheckbox-${loop}" type="checkbox">
							</span> <input value="${resource.getValue()}" type="text"
								class="form-control" />
						</div>
					</div>
				</div>
				<c:set var="loop" value="${loop+1}" scope="page"></c:set>
			</c:if>
		</c:forEach>
		<c:if test="${loop==1}">
			<div id="proceduresRow-1" style="margin-top: 10px;" class="row">
				<div class="col-xs-8">
					<div class="input-group">
						<span class="input-group-addon"> <input
							id="procedureCheckbox-1" type="checkbox">
						</span> <input placeholder="procedure value" type="text"
							class="form-control" />
					</div>
				</div>
			</div>
		</c:if>
	</div>

	<c:set var="loop" value="1" scope="page"></c:set>

	<!--------------------------------- Offerings ----------------------------------->

	<div class="tab-pane" id="offerings">
		<br />
		<div class="row">
			<div class="col-xs-1">
				<div style="margin-top: 2px; margin-bottom: 0px;" class="checkbox">
					<label> <input id="selectOfferings" type="checkbox">
					</label>
				</div>
			</div>
			<div class="col-xs-1">
				<button onclick="addOffering();" class="btn btn-default btn-xs">
					<span class="glyphicon glyphicon-plus"></span>
				</button>
			</div>
			<div class="col-xs-1">
				<button onclick="deleteOffering();" class="btn btn-default btn-xs">
					<span class="glyphicon glyphicon-trash"></span>
				</button>
			</div>
		</div>
		<c:forEach items="${permission.getResources()}" var="resource">
			<c:if test="${fn:startsWith(resource.getValue(),'offerings/')}">
				<div id="offeringsRow-${loop}" style="margin-top: 10px;" class="row">
					<div class="col-xs-8">
						<div class="input-group">
							<span class="input-group-addon"> <input
								id="offeringCheckbox-${loop}" type="checkbox">
							</span> <input value="${resource.getValue()}" type="text"
								class="form-control" />
						</div>
					</div>
				</div>
				<c:set var="loop" value="${loop+1}" scope="page"></c:set>
			</c:if>
		</c:forEach>
		<c:if test="${loop==1}">
			<div id="offeringsRow-1" style="margin-top: 10px;" class="row">
				<div class="col-xs-8">
					<div class="input-group">
						<span class="input-group-addon"> <input
							id="offeringCheckbox-1" type="checkbox">
						</span> <input placeholder="offering value" type="text"
							class="form-control" />
					</div>
				</div>
			</div>
		</c:if>
	</div>

	<c:set var="loop" value="1" scope="page"></c:set>

	<!--------------------------------- Features of Interest ----------------------------------->

	<div class="tab-pane" id="featuresOfInterest">
		<br />
		<div class="row">
			<div class="col-xs-1">
				<div style="margin-top: 2px; margin-bottom: 0px;" class="checkbox">
					<label> <input id="selectFeaturesOfInterest"
						type="checkbox">
					</label>
				</div>
			</div>
			<div class="col-xs-1">
				<button onclick="addFeaturesOfInterest();"
					class="btn btn-default btn-xs">
					<span class="glyphicon glyphicon-plus"></span>
				</button>
			</div>
			<div class="col-xs-1">
				<button onclick="deleteFeaturesOfInterest();"
					class="btn btn-default btn-xs">
					<span class="glyphicon glyphicon-trash"></span>
				</button>
			</div>
		</div>
		<br />
		<c:forEach items="${permission.getResources()}" var="resource">
			<c:if
				test="${fn:startsWith(resource.getValue(),'featuresOfInterest/')}">
				<div id="featuresOfInterestRow-${loop}" class="row">
					<div class="col-xs-8">
						<div class="input-group">
							<span class="input-group-addon"> <input
								id="featuresOfInterestCheckbox-${loop}" type="checkbox">
							</span> <input value="${resource.getValue()}" type="text"
								class="form-control" />
						</div>
					</div>
				</div>
				<c:set var="loop" value="${loop+1}" scope="page"></c:set>
			</c:if>
		</c:forEach>
		<c:if test="${loop==1}">
			<div id="featuresOfInterestRow-1" class="row">
				<div class="col-xs-8">
					<div class="input-group">
						<span class="input-group-addon"> <input
							id="featuresOfInterestCheckbox-1" type="checkbox">
						</span> <input placeholder="features of Interest value" type="text"
							class="form-control" />
					</div>
				</div>
			</div>
		</c:if>
	</div>

	<c:set var="loop" value="1" scope="page"></c:set>

	<div class="tab-pane" id="observedProperties">
		<br />
		<div class="row">
			<div class="col-xs-1">
				<div style="margin-top: 2px; margin-bottom: 0px;" class="checkbox">
					<label> <input type="checkbox">
					</label>
				</div>
			</div>
			<div class="col-xs-1">
				<button style="line-height: 0;" class="btn btn-default btn-xs">
					<span class="glyphicon glyphicon-plus"></span>
				</button>
			</div>
			<div class="col-xs-1">
				<button style="line-height: 0;" class="btn btn-default btn-xs">
					<span class="glyphicon glyphicon-trash"></span>
				</button>
			</div>
		</div>
		<br />
		<c:forEach items="${permission.getResources()}" var="resource">
			<c:if
				test="${fn:startsWith(resource.getValue(),'observedProperties/')}">
				<div id="observedPropertiesRow-${loop}" class="row">
					<div class="col-xs-8">
						<div class="input-group">
							<span class="input-group-addon"> <input type="checkbox">
							</span> <input value="${resource.getValue()}" type="text"
								class="form-control" />
						</div>
					</div>
				</div>
				<br />
				<c:set var="loop" value="${loop+1}" scope="page"></c:set>
			</c:if>
		</c:forEach>
		<c:if test="${loop==1}">
			<div id="observedPropertiesRow-1" class="row">
				<div class="col-xs-8">
					<div class="input-group">
						<span class="input-group-addon"> <input type="checkbox">
						</span> <input placeholder="observed properties value" type="text"
							class="form-control" />
					</div>
				</div>
			</div>
			<br />
		</c:if>
	</div>
</div>

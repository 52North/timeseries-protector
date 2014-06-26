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
		<br />
		<select multiple name="selectedProcedures" id="selectedProcedures" class="form-control">
			<c:forEach items="${procedures}" var="procedure"> 
				<option value="${procedure.getDomainId()}">${procedure.getDomainId()} </option>
			</c:forEach>
		</select>
		<p class="help-block">Press Ctrl for selecting more than one value</p>
	</div>

	<!--------------------------------- Offerings ----------------------------------->

	<div class="tab-pane" id="offerings">
		<br />
		<select multiple name="selectedOfferings" id="selectedOfferings" class="form-control">
			<c:forEach items="${offerings}" var="off"> 
				<option value="${off.getDomainId()}">${off.getDomainId()} </option>
			</c:forEach>
		</select>
		<p class="help-block">Press Ctrl for selecting more than one value</p>
	</div>

	<!--------------------------------- Features of Interest ----------------------------------->

	<div class="tab-pane" id="featuresOfInterest">
		<br />
		<select multiple name="selectedFeaturesOfInterest" id="selectedFeaturesOfInterest" class="form-control">
			<c:forEach items="${featuresOfInterest}" var="foi"> 
				<option value="${foi.getDomainId()}">${foi.getDomainId()} </option>
			</c:forEach>
		</select>
		<p class="help-block">Press Ctrl for selecting more than one value</p>
	</div>

	<!--------------------------------- Observed Properties ----------------------------------->

	<div class="tab-pane" id="observedProperties">
		<br />
		<select multiple name="selectedObservedProperties" id="selectedObservedProperties" class="form-control">
			<c:forEach items="${phenomenon}" var="phenomenon"> 
				<option value="${phenomenon.getDomainId()}">${phenomenon.getDomainId()} </option>
			</c:forEach>
		</select>
		<p class="help-block">Press Ctrl for selecting more than one value</p>
	</div>
</div>
</div>
</div>
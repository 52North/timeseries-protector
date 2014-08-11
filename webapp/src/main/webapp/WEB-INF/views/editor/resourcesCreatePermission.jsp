<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<div class="row">
	<div class="col-xs-8">
		<label class="control-label">* Resources :</label>
	</div>
	<div class="col-xs-4 text-right">
		<span style="cursor: pointer" data-container="body" data-toggle="popover"
			data-placement="left"
			data-content="The use of these resources is restricted for the selected subject(s) by
			only allowing them the selected action(s),you can select multiple values as well"
			class="glyphicon glyphicon-question-sign">
		</span>
	</div>
</div>

<ul class="nav nav-tabs">
	<!-- IMPORTANT!!  Do not change the id of the badges as the javascript will break -->
	<li class="active"><a href="#procedures" data-toggle="tab">Procedures
			<span class="badge"> <span id="selectProceduresCount"></span>/
				<span id="totalProceduresCount"></span>
		</span>
	</a></li>
	<li><a href="#offerings" data-toggle="tab">Offerings <span
			class="badge"> <span id="selectOfferingsCount"></span>/ <span
				id="totalOfferingsCount"></span>
		</span>
	</a></li>
	<li><a href="#featuresOfInterest" data-toggle="tab">Features
			Of Interest <span class="badge"> <span
				id="selectFeaturesOfInterestCount"></span>/ <span
				id="totalFeaturesOfInterestCount"></span>
		</span>
	</a></li>
	<li><a href="#observedProperties" data-toggle="tab">Observed
			Properties <span class="badge"> <span
				id="selectObservedPropertiesCount"></span>/ <span
				id="totalObservedPropertiesCount"></span>
		</span>
	</a></li>
</ul>

<!-- Tab panes -->
<div class="tab-content">
	<div class="tab-pane active" id="procedures">
		<br />
		
		<tiles:insertDefinition name="selectProcedures"></tiles:insertDefinition>
		
		<p class="help-block">Press Ctrl for selecting more than one value</p>
	</div>

	<!--------------------------------- Offerings ----------------------------------->

	<div class="tab-pane" id="offerings">
		<br />
		
		<tiles:insertDefinition name="selectOfferings"></tiles:insertDefinition>
		
		<p class="help-block">Press Ctrl for selecting more than one value</p>
	</div>

	<!--------------------------------- Features of Interest ----------------------------------->

	<div class="tab-pane" id="featuresOfInterest">
		<br />
		
		<tiles:insertDefinition name="selectFeaturesOfInterest"></tiles:insertDefinition>
		
		<p class="help-block">Press Ctrl for selecting more than one value</p>
	</div>

	<!--------------------------------- Observed Properties ----------------------------------->

	<div class="tab-pane" id="observedProperties">
		<br />
		
		<tiles:insertDefinition name="selectObservedProperties"></tiles:insertDefinition>
		
		<p class="help-block">Press Ctrl for selecting more than one value</p>
	</div>

	<button title="Toggle Selected Resources" id="toggleResources" type="button"
		class="btn btn-danger btn-xs">Toggle</button>

	<button title="Clear Selected Resources" id="clearResources" type="button"
		class="btn btn-default btn-xs">Clear</button>
</div>
<br />
<hr />
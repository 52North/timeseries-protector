<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<label class="control-label">* Resources</label>
<br />
<ul class="nav nav-tabs">
 <!-- IMPORTANT!!  Do not change the id of the badges as the javascript will break -->
	<li class="active">
	   <a href="#procedures" data-toggle="tab">Procedures
	    <span class="badge">
	    	<span id="selectProceduresCount"></span>/ <span id="totalProceduresCount"></span>
	   	</span>
	   </a>
	</li>
	<li>
	   <a href="#offerings" data-toggle="tab">Offerings
	     <span class="badge">
	     	<span id="selectOfferingsCount"></span>/ <span id="totalOfferingsCount"></span>
	     </span>
	   </a>
	</li>
	<li>
		<a href="#featuresOfInterest" data-toggle="tab">Features Of Interest 
		  <span class="badge">
		  	<span id="selectFeaturesOfInterestCount"></span>/ <span id="totalFeaturesOfInterestCount"></span>
		  </span> 
		</a>
	</li>
	<li>
	   <a href="#observedProperties" data-toggle="tab">Observed Properties
	   		<span class="badge">
	   			<span id="selectObservedPropertiesCount"></span>/ <span id="totalObservedPropertiesCount"></span>
	   		</span>
	   </a>
	 </li>
</ul>

<!-- Tab panes -->
<div class="tab-content">
	<div class="tab-pane active" id="procedures">
		<br />
		<div id="selectProceduresContainer" style="resize: vertical; overflow: auto;">
			<select style="height: inherit;" multiple id="selectProcedures"
				class="form-control">
				<c:forEach items="${procedures}" var="procedure">
					<c:forEach items="${permission.getResources()}" var="targetValue">
						<c:set var="parsed"
							value="${fn:substringAfter(targetValue.getValue(),\"procedures/\")}" />
						<c:if
							test="${parsed!='procedures/*' && parsed==procedure.getDomainId()}">
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
		</div>
		<p class="help-block">Press Ctrl for selecting more than one value</p>
	</div>

	<!--------------------------------- Offerings ----------------------------------->

	<div class="tab-pane" id="offerings">
		<br />
		<div id="selectOfferingsContainer" style="resize: vertical; overflow: auto;">
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
						<option value="${off.getDomainId()}">${off.getDomainId()}
						</option>
					</c:if>
				</c:forEach>
			</select>
		</div>
		<p class="help-block">Press Ctrl for selecting more than one value</p>
	</div>

	<!--------------------------------- Features of Interest ----------------------------------->

	<div class="tab-pane" id="featuresOfInterest">
		<br />
		<div id="selectFeaturesOfInterestContainer" style="resize: vertical; overflow: auto;">
			<select style="height: inherit;" multiple
				id="selectFeaturesOfInterest" class="form-control">
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
						<option value="${foi.getDomainId()}">${foi.getDomainId()}
						</option>
					</c:if>
				</c:forEach>
			</select>
		</div>
		<p class="help-block">Press Ctrl for selecting more than one value</p>
	</div>

	<!--------------------------------- Observed Properties ----------------------------------->

	<div class="tab-pane" id="observedProperties">
		<br />
		<div id="selectObservedPropertiesContainer" style="resize: vertical; overflow: auto;">
			<select style="height: inherit;" multiple
				id="selectObservedProperties" class="form-control">
				<c:forEach items="${phenomenon}" var="phenomenon">
					<c:forEach items="${permission.getResources()}" var="targetValue">
						<c:if
							test="${fn:substringAfter(targetValue.getValue(),\"observedProperties/\")==phenomenon.getDomainId()}">
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
		</div>
		<p class="help-block">Press Ctrl for selecting more than one value</p>
	</div>
</div>
<br />
<hr />
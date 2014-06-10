<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="form-group">
	<label class="control-label">* Permission Name :</label> <input
		style="margin-top: 5px" id="permissionName" class="form-control"
		type="text" value="${permission.getName()}" name="permissionName"
		placeholder="Permission Name" />
</div>

<div class="form-group">
	<label class="control-label">* Action :</label> <input
		style="margin-top: 5px" id="actionDomain" class="form-control"
		type="text" name="actionDomain" />
	<p class="help-block">Comma separated values are allowed</p>
</div>

<div class="form-group">
	<label class="control-label">* Subject :</label> <input
		style="margin-top: 5px" id="resourceDomain" class="form-control"
		type="text" name="resourceDomain" />
	<p class="help-block">Comma separated values are allowed</p>
</div>

<div class="form-group">
	<label class="control-label"> Obligation(s) :</label> <input
		style="margin-top: 5px" id="obligation" class="form-control"
		type="text" name="obligation" />
	<p class="help-block">Key value pairs with comma separated values
		are allowed</p>
</div>

<div class="row">
	<div class="col-sm-6">
		<div class="checkbox">
			<label> <input id="offerings" type="checkbox" value="">
				Offerings
			</label>
		</div>
	</div>
	<div class="col-sm-6">
		<input id="offeringsInput" style="display: none" class="form-control"
			type="text" />
	</div>
</div>

<div class="row">
	<div class="col-sm-6">
		<div class="checkbox">
			<label> <input id="procedures" type="checkbox" value="">
				Procedures
			</label>
		</div>
	</div>
	<div class="col-sm-6">
		<input id="proceduresInput" style="display: none" class="form-control"
			type="text" />
	</div>
</div>

<div class="row">
	<div class="col-sm-6">
		<div class="checkbox">
			<label> <input id="observedProperties" type="checkbox"
				value=""> Observed Properties
			</label>
		</div>
	</div>
	<div class="col-sm-6">
		<input id="observedPropertiesInput" style="display: none"
			class="form-control" type="text" />
	</div>
</div>

<div class="row">
	<div class="col-sm-6">
		<div class="checkbox">
			<label> <input id="featuresOfInterest" type="checkbox"
				value=""> Features Of Interest
			</label>
		</div>
	</div>
	<div class="col-sm-6">
		<input id="featuresOfInterestInput" style="display: none"
			class="form-control" type="text" />
	</div>
</div>
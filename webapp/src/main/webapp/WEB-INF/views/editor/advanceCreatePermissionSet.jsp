<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="panel-group" id="accordion">
	<div class="panel panel-default">
		<div class="panel-heading">
			<label class="control-label"> <a data-toggle="collapse"
				data-parent="#accordion" href="#collapseOne"> Advance Section
					<span id="toggleArrow" class="glyphicon glyphicon-chevron-right"></span>
			</a>
			</label>
		</div>
		<div id="collapseOne" class="panel-collapse collapse">
			<div class="panel-body">
				<div class="form-group">
					<label class="control-label"> Resource Domain :</label> <input
						style="margin-top: 5px" id="resourceDomain"
						class="form-control" type="url"
						value="${permissionSet.getResourceDomains().get(0)}"
						name="resourceDomain" placeholder="Resource Domain URL" />
					<p class="help-block">URL of the end point to protect</p>
				</div>

				<div class="form-group">
					<label class="control-label">* Subject Domain :</label> <input
						style="margin-top: 5px" required id="subjectDomain"
						class="form-control"
						value="${permissionSet.getSubjectDomains().get(0)}" type="url"
						name="subjectDomain" placeholder="Subject Domain URL" />
					<p class="help-block">Domain specifying the user roles which
						will be restricted</p>
				</div>
			</div>
		</div>
	</div>
</div>

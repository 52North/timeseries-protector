<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="panel-group" id="accordion">
	<div class="panel panel-default">
		<div class="panel-heading">
			<label class="control-label"> <a data-toggle="collapse"
				data-parent="#accordion" href="#collapseOne"> Advance Settings <span
					id="toggleArrow" class="glyphicon glyphicon-chevron-right"></span>
			</a>
			</label>
		</div>
		<div id="collapseOne" class="panel-collapse collapse">
			<div class="panel-body">
				<div class="form-group">
					<div class="row">
						<div class="col-xs-8">
							<label class="control-label"> Resource Domain :</label>
						</div>
						<div class="col-xs-4 text-right">
							<span style="cursor: pointer;" data-container="body"
								data-toggle="popover" data-placement="left"
								data-content="Resource Domain specifies the end point for resources, action domain and
								resource domain have same values unless specified by the user explicitly"
								class="glyphicon glyphicon-question-sign"> 
							</span>
						</div>
					</div>
					<input
						style="margin-top: 5px" id="resourceDomain" data-url
						class="form-control" type="url"
						value="${permissionSet.getResourceDomains().get(0)}"
						name="resourceDomain" placeholder="Resource Domain URL" />
					<p class="help-block">URL of the end point to protect</p>
				</div>
				<div class="form-group">
					<div class="row">
						<div class="col-xs-8">
							<label class="control-label">* Subject Domain :</label>
						</div>
						<div class="col-xs-4 text-right">
							<span style="cursor: pointer;" data-container="body"
								data-toggle="popover" data-placement="left"
								data-content="The Domain which consists of various user subjects(roles) pre defined which are
								used while creating permissions"
								class="glyphicon glyphicon-question-sign"> 
							</span>
						</div>
					</div>
					<div id="subjectDomainContainer">
						<select id="subjectDomain" class="form-control">
							<c:set var="found_subject" value="" />
							<c:if test="${permissionSet!=null}">
								<option
									<c:if test="${permissionSet.getSubjectDomains().get(0)=='urn:conterra:names:sdi-suite:policy:attribute:role'}">
								 		selected
								 		<c:set var="found_subject" value="found" />
								 	</c:if>
									value="urn:conterra:names:sdi-suite:policy:attribute:role">urn:conterra:names:sdi-suite:policy:attribute:role
								</option>
								<option
									<c:if test="${permissionSet.getSubjectDomains().get(0)=='urn:n52:security:subject:role'}">
								 		selected
								 		<c:set var="found_subject" value="found" />
								 	</c:if>
									value="urn:n52:security:subject:role">urn:n52:security:subject:role
								</option>
								<c:if test="${found_subject==''}">
									<option selected
										value="${permissionSet.getSubjectDomains().get(0)}">
										${permissionSet.getSubjectDomains().get(0)}</option>
								</c:if>
								<option id="customValue" value="other">Other</option>
							</c:if>
							<c:if test="${permissionSet==null}">
								<option
									value="urn:conterra:names:sdi-suite:policy:attribute:role">urn:conterra:names:sdi-suite:policy:attribute:role
								</option>
								<option value="urn:n52:security:subject:role">urn:n52:security:subject:role
								</option>
								<option id="customValue" value="other">Other</option>
							</c:if>
						</select> <input autocomplete="on" placeholder="Custom Value"
							id="customSubjectDomain" type="text" class="form-control"
							style="display: none; margin-top: 10px;" />
					</div>
					<p style="margin-top: 10px" class="help-block">Domain for the
						users which will be restricted</p>
				</div>
			</div>
		</div>
	</div>
</div>

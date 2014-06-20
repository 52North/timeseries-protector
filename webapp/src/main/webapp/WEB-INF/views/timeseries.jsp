<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<h2>Getting to know the timeseries API</h2>

<form id="viewData" class="form-horizontal">

	<div class="control-group">
		<label class="control-label" form="timeseries">Offering
			Parameters</label>

		<div class="controls">
			<select multiple class="form-control" name="t1Service" id="t1Service">
				<c:forEach items="${offerings}" var="pp">
					<option ><c:out
							value="${pp.getLabel()}" /></option>
				</c:forEach>
			</select>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" form="timeseries">Procedures
			Parameters</label>
		<div class="controls">
			<select multiple class="form-control" name="t2Service" id="t2Service">
				<c:forEach items="${procedures}" var="pp">
					<option ><c:out
							value="${pp.getLabel()}" /></option>
				</c:forEach>
			</select>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" form="timeseries">Features of Interest
			Parameters</label>
		<div class="controls">
			<select multiple class="form-control" name="t3Service" id="t3Service">
				<c:forEach items="${featuresOfInterest}" var="pp">
					<option ><c:out
							value="${pp.getLabel()}" /></option>
				</c:forEach>
			</select>
		</div>
	</div>
	<%-- <div class="control-group">
		<label class="control-label" form="timeseries">Observed Properties
			Parameters</label>
		<div class="controls">
			<select multiple class="form-control" name="t4Service" id="t4Service">
				<c:forEach items="${observedProperties}" var="pp">
					<option selected="selected"><c:out
							value="${pp.getLabel()}" /></option>
				</c:forEach>
			</select>
		</div>
	</div> --%>
</form>
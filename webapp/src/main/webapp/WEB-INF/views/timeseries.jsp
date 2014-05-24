<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <h2> Getting to know the timeseries API</h2>
    
    <form enctype="application/x-www-form-urlencoded" id="viewData" class="form-horizontal">
    	
     <div class="control-group">
        <label class="control-label" form="timeseries">Service Parameters</label>
        <div class="controls">
            <select name="tService" id="tService">
                <c:forEach items="${parameterProvider}" var="pp">
                    <option selected="true" value="" style="display:block;"><c:out value="${pp.uom}"/></option>
                </c:forEach>
            </select>
            <span class="help-block">Select the parameter</span>
        </div>
    </div>
    	
    </form>
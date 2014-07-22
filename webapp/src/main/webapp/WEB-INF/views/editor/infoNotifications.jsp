<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<div id="info" style="display: none;"
	class="alert alert-info alert-dismissible" role="alert">
	<button id="infoButton" type="button" class="close">
		<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
	</button>
	<p id="infoText"> </p>
</div>
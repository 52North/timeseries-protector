<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<c:url value="/static/img/favicon.ico" />"
	rel="shortcut icon" type="image/x-icon" />

<!-- Bootstrap core files  -->
<link rel="stylesheet"
	href="<c:url value="/static/lib/css/docs.min.css" />" type="text/css" />
<link rel="stylesheet"
	href="<c:url value="/static/lib/css/bootstrap.min.css" />"
	type="text/css" />
<body>

	<div class="container-fluid">
		<div class="alert alert-danger">
			<h2>Please update your browser to use the application</h2>
			<a onclick="javascript:document.getElementById('learnMore').style.display=''" href="#">Learn More..</a>
		</div>
		<div id="learnMore" style="display: none;" class="alert alert-info">
			<p>The current version of your browser does not supports the
				features which are required for normal operation of the application
				Some of these include
			</p>
			<ul>
			 <li> Local Storage</li>
			 <li> Session Storage</li>
			 <li> JSON</li>
			 <li> Multi Select Dropdowns</li>
			</ul>
		</div>
	</div>
</body>

</html>

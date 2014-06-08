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

<!--  Jquery -->
<script type="text/javascript"
	src="<c:url value="/static/lib/js/jquery-1.8.2.min.js" />"></script>

<!-- Bootstrap core files  -->
<link rel="stylesheet"
	href="<c:url value="/static/lib/css/bootstrap.min.css" />" type="text/css" />
<link rel="stylesheet" href="<c:url value="/static/lib/css/docs.min.css" />"
	type="text/css" />
<script type="text/javascript"
	src="<c:url value="/static/lib/js/bootstrap.min.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/static/lib/js/docs.min.js" />"></script>

<!-- Workaround for multiple modals for Bootstrap  -->
<link rel="stylesheet"
	href="<c:url value="/static/lib/css/bootstrap-modal-bs3patch.css" />"
	type="text/css" />
<script type="text/javascript"
	src="<c:url value="/static/lib/js/bootstrap-modalmanager.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/static/lib/js/bootstrap-modal.js" />"></script>
<link rel="stylesheet"
	href="<c:url value="/static/lib/css/bootstrap-modal.css" />"
	type="text/css" />

<title><tiles:getAsString name="title" /></title>
</head>
<body>
	<h1>
		<center>Timeseries Permission Manager</center>
	</h1>

	<tiles:insertAttribute name="body" />

	<br />
	<br />

	<center>
		<tiles:insertAttribute name="footer" />
	</center>
</body>
</html>




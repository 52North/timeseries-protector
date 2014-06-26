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
	href="<c:url value="/static/lib/css/docs.min.css" />" type="text/css" />
<link rel="stylesheet"
	href="<c:url value="/static/lib/css/bootstrap.min.css" />"
	type="text/css" />
<script type="text/javascript"
	src="<c:url value="/static/lib/js/bootstrap.min.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/static/lib/js/docs.min.js" />"></script>

<!-- Workaround for multiple modals for Bootstrap  -->
<%-- <link rel="stylesheet"
	href="<c:url value="/static/lib/css/bootstrap-modal-bs3patch.css" />"
	type="text/css" />
<script type="text/javascript"
	src="<c:url value="/static/lib/js/bootstrap-modalmanager.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/static/lib/js/bootstrap-modal.js" />"></script>
<link rel="stylesheet"
	href="<c:url value="/static/lib/css/bootstrap-modal.css" />"
	type="text/css" /> --%>

<!-- Files for Data Tables used for sorting and searching -->
<script type="text/javascript"
	src="//cdn.datatables.net/1.10.0/js/jquery.dataTables.js"></script>
<script type="text/javascript"
	src="//cdn.datatables.net/plug-ins/be7019ee387/integration/bootstrap/3/dataTables.bootstrap.js"></script>
<link rel="stylesheet"
	href="<c:url value="/static/lib/css/jquery.dataTable.css" />"
	type="text/css" />
<link rel="stylesheet"
	href="<c:url value="/static/lib/css/dataTables.bootstrap.css" />"
	type="text/css" />


<title>${pageTitle}</title>
</head>
<body>
	<h1>
		<center>${heading}</center>
	</h1>
	<br/>
	<ol class="breadcrumb">
		<c:forEach varStatus="loop" items="${breadCrumb}" var="entry">
			<c:choose>
					<c:when test="${loop.index==breadCrumb.size()-1}">
						<li class="active">${entry.key}</li>
					</c:when>
					<c:otherwise>
					    <li><a href="${entry.value}"> ${entry.key} </a></li>
					</c:otherwise>
				</c:choose>
		</c:forEach>
	</ol>
	<tiles:insertAttribute name="body" />

	<br />


	<center>
		<tiles:insertAttribute name="footer" />
	</center>
</body>
</html>




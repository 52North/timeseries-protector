<%--

    Copyright (C) 2012-2014 52°North Initiative for Geospatial Open Source
    Software GmbH

    This program is free software; you can redistribute it and/or modify it under
    the terms of the GNU General Public License version 2 as publishedby the Free
    Software Foundation.

    If the program is linked with libraries which are licensed under one of the
    following licenses, the combination of the program with the linked library is
    not considered a "derivative work" of the program:

        - Apache License, version 2.0
        - Apache Software License, version 1.0
        - GNU Lesser General Public License, version 3
        - Mozilla Public License, versions 1.0, 1.1 and 2.0
        - Common Development and Distribution License (CDDL), version 1.0

    Therefore the distribution of the program linked with libraries licensed under
    the aforementioned licenses, is permitted by the copyright holders if the
    distribution is compliant with both the GNU General Public License version 2
    and the aforementioned licenses.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY
    WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
    PARTICULAR PURPOSE. See the GNU General Public License for more details.

--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link href="<c:url value="/static/img/favicon.ico" />" rel="shortcut icon" type="image/x-icon" />
		<link rel="stylesheet" href="<c:url value="/static/lib/bootstrap-2.3.1.min.css" />" type="text/css" />

		<script type="text/javascript" src="<c:url value="/static/lib/bootstrap-2.3.1.min.js" />"></script>
		<title>52&deg;North SOS installer</title>
        <title>Policy Editor</title>
    </head>
    <body>
        <h1>Create New Policy</h1>

        <form action="<c:url value="/new" />" method="POST" class="form-horizontal">
            <div class="control-group">
                <label class="control-label" for="datasource">Datasource</label>
                <div class="controls">
                    <select name="datasource" id="datasource">
                        <c:forEach items="${content.services}" var="service">
                            <option selected="false" value="" style="display: none;"></option>
                        </c:forEach>
                    </select>
                    <span class="help-block">Select the timeseries endpoint to protect.</span>
                </div>
            </div>
        </form>

    </body>
</html>

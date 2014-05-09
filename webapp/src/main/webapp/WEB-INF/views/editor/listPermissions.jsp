<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2>Policies</h2>

<div><a class="btn btn-info pull-left" href="<c:url value='/editor/new' />" >New PermissionSet</a></div>

<table class="table table-striped">
    <thead>
        <tr>
            <th>Name</th>
            <th>Service</th>
            <th>Edit</th>
        </tr>
    </thead>

    <tbody>

        <c:if test="${not empty permissionSets}">
            <c:forEach var="permissionSet" items="${permissionSets}">
                <tr>
                    <td>${permissionSet.name}</td>
                    <td>${permissionSet.name}</td>
                    <td>${permissionSet.name}</td>
                </tr>
            </c:forEach>
        </c:if>

    </tbody>
</table>


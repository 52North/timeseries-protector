<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2>Create PermissionSet</h2>

<form id="create" action="<c:url value='/editor/save' />" method="POST" class="form-horizontal">

    <div class="control-group">
        <label class="control-label" form="permissionset-name">Name</label>
        <div class="controls">
            <input type="text" name="permissionset-name" />
            <span class="help-block">Type the permission set's name.</span>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label" form="epService">Enforcement Point</label>
        <div class="controls">
            <select name="epService" id="epService">
                <c:forEach items="${enforcementPoints}" var="epService">
                    <option selected="false" value="" style="display: none;"></option>
                </c:forEach>
            </select>
            <span class="help-block">Select the endpoint to protect.</span>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label" form="subject-domain">Subject Domain</label>
        <div class="controls">
            <select name="subject-domain" id="subject-domain">
                <option selected="true" style="display: none;">urn:n52:security:subject:role</option>
            </select>
            <span class="help-block">Select the subject's domain.</span>
        </div>
    </div>

    <div><button class="btn btn-info pull-left" type="submit">Save</button></div>
</form>


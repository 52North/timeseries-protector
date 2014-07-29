<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modal fade" id="viewPermissionsXmlModal" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div style="resize: both;" class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<h4 class="modal-title">View Permissions Xml</h4>
			</div>
			<div class="modal-body">
				<pre id="xmlContent">
				</pre>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<a title="Download Permissions Xml"
					href="<c:url value="/download" />" class="btn btn-primary"
					role="button"> Download
				</a>
			</div>
		</div>
	</div>
</div>

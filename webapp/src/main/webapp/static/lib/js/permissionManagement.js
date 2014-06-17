/*
 * Copyright (C) 2012-2014 52°North Initiative for Geospatial Open Source
 * Software GmbH
 *
 * This program is free software; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License version 2 as published by the Free
 * Software Foundation.
 *
 * If the program is linked with libraries which are licensed under one of the
 * following licenses, the combination of the program with the linked library is
 * not considered a "derivative work" of the program:
 *
 *     - Apache License, version 2.0
 *     - Apache Software License, version 1.0
 *     - GNU Lesser General Public License, version 3
 *     - Mozilla Public License, versions 1.0, 1.1 and 2.0
 *     - Common Development and Distribution License (CDDL), version 1.0
 *
 * Therefore the distribution of the program linked with libraries licensed under
 * the aforementioned licenses, is permitted by the copyright holders if the
 * distribution is compliant with both the GNU General Public License version 2
 * and the aforementioned licenses.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE. See the GNU General Public License for more details.
 */
$(document).ready(function(){

	/*
	 * functionality for select all checkbox
	 * in permission management screen
	 * */
	$("#selectAllPermission").click( 
			function(event) {
				$("#permissionTable input[type='checkbox']")
				.attr("checked", this.checked);
			});

	$("#permissionTable tr td input[type='checkbox']")
	.click(
			function(event) {
				if ($("#permissionTable tr td input[type='checkbox']").length == $("#permissionTable tr td input:checked").length) {
					$("#selectAllPermission").attr("checked",
					"checked");
				} else {
					$("#selectAllPermission").removeAttr(
					"checked");
				}
			});

	/*
	 * Method for displaying input box only if the
	 * resource is selected
	 */
	$("#modalContentPermission .checkbox input[type='checkbox']").click(
			function() 
			{
				if (this.checked) 
				{
					$("#" + this.id + "Input").show();
				} else 
				{
					$("#" + this.id + "Input").hide();
				}

			});

	$("#btnAddPermission").click(function(event)
			{
		$.ajax({
			url:window.location.href+"newPermission",
			type:"POST",
			success: function(response)
			{
				$("#createPermisisonContainer").html(response);
				$("#basicScreen").modal({
					backdrop:true,
					keyboard:true,
					show:true
				});
			}
		});
			}		
	);

	/*
	 * Method for displaying the selected permission
	 * for modifying
	 * */
	$("#permissionTable button").click(
			function(event)
			{
				var permissionName=this.id.split("#")[1];
				$.ajax({
					type:"GET",
					url:window.location.href+"edit/"+$("#permissionSetName").val()+"/"+permissionName,
					success: function(response)
					{
						$("#createPermisisonContainer").html(response);	
						$(".modal-title").html("Modify "+permissionName);
						$("#basicScreen").modal({
							backdrop:true,
							keyboard:true,
							show:true
						});
					}
				});
			}
	);
	
});


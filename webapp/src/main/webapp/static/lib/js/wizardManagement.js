$(document).ready(function() {

	/*
	 * Functionality for displaying the corresponding screens
	 * for add permission
	 * */
	$("div[class='modal-footer'] button").click(function(event){
		var id=this.id.split("-");
		$("#"+id[0]).modal('toggle');
		$("#"+id[1]).modal('toggle');
	});
	
	/*
	 * Functionality for selecting all procedures on
	 * checkbox click
	 * */
	$("#selectProcedures").click(function(){
		$("#procedures .input-group input[type='checkbox']").attr("checked", this.checked);
	});
	
	$("#selectOfferings").click(function(){
		$("#offerings .input-group input[type='checkbox']").attr("checked", this.checked);
	});
});

/***********************************End of data binding*********************************************/
/*
 * Method for appending new rows for procedure on add click
 * */
function addProcedure()
{
	var length=$("#procedures .input-group").length;
	length++;

	var html="<div style='margin-top:10px;' id='proceduresRow-"+length+"' class='row'><div class='col-xs-8'> <div class='input-group'>";
	html+="<span class='input-group-addon'> <input id='procedureCheckbox-"+length+"' type='checkbox'></span> ";
	html+="<input placeholder='procedure value' type='text' class='form-control' /></div></div></div>";
	$("#procedures").append(html);
}

/*
 * Method for deleting the existing procedure row 
 * */
function deleteProcedure()
{
	var checkboxes=$("#procedures .input-group input[type='checkbox']");
	for(var i=0;i<checkboxes.length;i++)
	{
	  if(checkboxes[i].checked)
	   {		
		 $("#proceduresRow-"+checkboxes[i].id.split("-")[1]).remove();
	   }
	}
}

/*
 * Method for appending new rows for offering on add click
 * */
function addOffering()
{
	var length=$("#offerings .input-group").length;
	length++;

	var html="<div style='margin-top:10px;' id='offeringsRow-"+length+"' class='row'><div class='col-xs-8'> <div class='input-group'>";
	html+="<span class='input-group-addon'> <input id='offeringCheckbox-"+length+"' type='checkbox'></span> ";
	html+="<input placeholder='offering value' type='text' class='form-control' /></div></div></div>";

	$("#offerings").append(html);
}

/*
 * Method for deleting the existing offering row 
 * */
function deleteOffering()
{
	var checkboxes=$("#offerings .input-group input[type='checkbox']");
	for(var i=0;i<checkboxes.length;i++)
	{
	  if(checkboxes[i].checked)
	   {		
		 $("#offeringsRow-"+checkboxes[i].id.split("-")[1]).remove();
	   }
	}
}

/*
 * Method for appending new rows for features of interest on add click
 * */
function addFeaturesOfInterest()
{
	var length=$("#featuresOfInterest .row").length;
	length++;

	var html="<div id='featuresOfInterestRow-"+length+"' class='row'>";

	html+="<div class='col-xs-1'><button onclick='addFeaturesOfInterest();' type='button' class='btn btn-xs' title='Add features Of Interest'>" +
	"<span class='glyphicon glyphicon-plus'></span> </button></div>";
	html+="<div class='col-xs-9'><div class='form-group'><input id='featuresOfInterest"+length+"' class='form-control'" +
	" type='text' placeholder='features Of Interest value' /></div></div>";
	html+="<div class='col-xs-2'><button onclick='deleteFeatureOfInterest(this.id);' id='deleteFeatureOfInterest-"+length+"'" +
	" type='button' class='btn btn-xs' title='Delete Feature Of Interest'>" +"<span class='glyphicon glyphicon-trash'></span></button></div>";

	$("#featuresOfInterest").append(html);
}

/*
 * Method for deleting the existing feature of interest
 * */
function deleteFeatureOfInterest(id)
{
	$("#featuresOfInterestRow-"+id.split("-")[1]).remove();
}

/*
 * Method for appending new rows for observed properties on add click
 * */
function addObservedProperties()
{
	var length=$("#observedProperties .row").length;
	length++;

	var html="<div id='observedPropertiesRow-"+length+"' class='row'>";

	html+="<div class='col-xs-1'><button onclick='addObservedProperties();' type='button' class='btn btn-xs' title='Add Observed Properties'>" +
	"<span class='glyphicon glyphicon-plus'></span> </button></div>";
	html+="<div class='col-xs-9'><div class='form-group'><input id='observedProperties"+length+"' class='form-control'" +
	" type='text' placeholder='Observed Properties value' /></div></div>";
	html+="<div class='col-xs-2'><button onclick='deleteObservedProperty(this.id);' id='deleteObservedProperty-"+length+"'" +
	" type='button' class='btn btn-xs' title='Delete Observed Property'>" +"<span class='glyphicon glyphicon-trash'></span></button></div>";

	$("#observedProperties").append(html);
}

/*
 * Method for deleting the observed property
 * */
function deleteObservedProperty(id)
{
	$("#observedPropertiesRow-"+id.split("-")[1]).remove();
}

/******************************End of Resource Screen**************************************/

/*
 * Method for appending new rows for actions on add click
 * */
function addAction()
{
	var length=$("#action .row").length;
	length++;

	var html="<div id='actionRow-"+length+"' class='row'>";

	html+="<div class='col-xs-1'><button onclick='addAction();' type='button' class='btn btn-xs' title='Add Observed Properties'>" +
	"<span class='glyphicon glyphicon-plus'></span> </button></div>";
	html+="<div class='col-xs-9'><div class='form-group'><input id='action"+length+"' class='form-control'" +
	" type='text' placeholder='action value' /></div></div>";
	html+="<div class='col-xs-2'><button onclick='deleteAction(this.id);' id='deleteAction-"+length+"'" +
	" type='button' class='btn btn-xs' title='Delete Observed Property'>" +"<span class='glyphicon glyphicon-trash'></span></button></div>";

	$("#action").append(html);
}

/*
 * Method for deleting the action
 * */
function deleteAction(id)
{
	$("#actionRow-"+id.split("-")[1]).remove();
}

/*******************************************End of Action Screen*************************************************/
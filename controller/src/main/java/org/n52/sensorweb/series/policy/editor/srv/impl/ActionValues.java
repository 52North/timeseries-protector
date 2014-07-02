/**
 * 
 */
package org.n52.sensorweb.series.policy.editor.srv.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @author Dushyant Sabharwal
 * Enum class containing the predefined
 * action values for SOS enforcement point
 *
 */
public enum ActionValues {

	GET_CAPABILITIES("GetCapabilities"),
	GET_FEATURES_OF_INTEREST("GetFeaturesOfInterest"),
	GET_FEATURES_OF_INTEREST_TIME("GetFeaturesOfInterestTime"),
	GET_RESULT("GetResult"),
	GET_OBSERVATION("GetObservation"),
	DESCRIBE_SENSOR("DescribeSensor"),
	DESCRIBE_FEATURE_TYPE("DescribeFeatureType"),
	INSERT_SENSOR("InsertSensor"),
	DELETE_SENSOR("DeleteSensor"),
	UPDATE_SENSOR_DESCRIPTION("UpdateSensorDescription");
	
	private String actionValue;
	
	ActionValues(String actionValue)
	{
		this.setActionValue(actionValue);
	}

	public String getActionValue() {
		return actionValue;
	}
	
	public static List<ActionValues> getActionValues()
	{
		return new ArrayList<ActionValues>(Arrays.asList(ActionValues.values()));
	}

	public void setActionValue(String actionValue) {
		this.actionValue = actionValue;
	}
	
}

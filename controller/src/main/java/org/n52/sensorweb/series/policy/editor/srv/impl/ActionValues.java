/**
 * Copyright (C) 2012-2014 52°North Initiative for Geospatial Open Source
 * Software GmbH
 *
 * This program is free software; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License version 2 as publishedby the Free
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

	GET_CAPABILITIES("GetCapabilities","Read"),
	GET_FEATURES_OF_INTEREST("GetFeaturesOfInterest","Read"),
	GET_FEATURES_OF_INTEREST_TIME("GetFeaturesOfInterestTime","Read"),
	GET_RESULT("GetResult","Read"),
	GET_OBSERVATION("GetObservation","Read"),
	DESCRIBE_SENSOR("DescribeSensor","Read"),
	DESCRIBE_FEATURE_TYPE("DescribeFeatureType","Read"),
	INSERT_SENSOR("InsertSensor","Update"),
	DELETE_SENSOR("DeleteSensor","Update"),
	UPDATE_SENSOR_DESCRIPTION("UpdateSensorDescription","Update");
	
	private String actionValue;
	private String type;
	
	ActionValues(String actionValue,String type)
	{
		this.setActionValue(actionValue);
		this.setType(type);
	}

	public String getActionValue() 
	{
		return actionValue;
	}
	
	public static List<ActionValues> getActionValues()
	{
		return new ArrayList<ActionValues>(Arrays.asList(ActionValues.values()));
	}

	public void setActionValue(String actionValue) 
	{
		this.actionValue = actionValue;
	}

    public String getType() 
    {
        return type;
    }

    public void setType(String type) 
    {
        this.type = type;
    }
	
}

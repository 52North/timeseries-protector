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

package org.n52.sensorweb.series.policy.api.beans;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.n52.security.service.pdp.simplepermission.Attribute;

/**
 *
 * @author Henning Bredel <h.bredel@52north.org>
 */
@JsonIgnoreProperties(ignoreUnknown = true)
final class AttributeOutput {

    private String name;

    private Object value;

    private String type;

    public AttributeOutput() {
        // keep empty constructor
    }

    public AttributeOutput(Attribute attribute) {
        setName(attribute.getName());
        setValue(attribute.getValue());
        setType(attribute.getType());
    }

    Attribute getAttribute() {
        return new Attribute(getName(), getValue(), getName());
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Object getValue() {
        return value;
    }

    public void setValue(Object value) {
        this.value = value;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

}

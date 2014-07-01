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
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.n52.sensorweb.series.policy.api.beans;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.util.ArrayList;
import java.util.List;
import org.n52.security.service.pdp.simplepermission.Attribute;
import org.n52.security.service.pdp.simplepermission.Obligation;

/**
 *
 * @author Henning Bredel <h.bredel@52north.org>
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public final class ObligationOutput {

    private String name;

    private final List<AttributeOutput> attributeOutputs = new ArrayList<AttributeOutput>();

    public Obligation getObligation() {
        return new Obligation(name, getAttributes());
    }

    public ObligationOutput() {
        // keep default constructor
    }

    public ObligationOutput(Obligation obligation) {
        setName(obligation.getName());
        setAttributes(obligation.getAttributes());
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<Attribute> getAttributes() {
        ArrayList<Attribute> attributes = new ArrayList<>();
        for (AttributeOutput attributeOutput : attributeOutputs) {
            attributes.add(attributeOutput.getAttribute());
        }
        return attributes;
    }

    public void setAttributes(List<Attribute> attributes) {
        for (Attribute attribute : attributes) {
            this.attributeOutputs.add(new AttributeOutput(attribute));
        }
    }


}

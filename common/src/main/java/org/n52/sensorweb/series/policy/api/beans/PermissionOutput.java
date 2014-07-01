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
import org.n52.security.service.pdp.simplepermission.Obligation;
import org.n52.security.service.pdp.simplepermission.Permission;
import org.n52.security.service.pdp.simplepermission.TargetValue;

/**
 *
 * @author Henning Bredel <h.bredel@52north.org>
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public final class PermissionOutput {

    private String name;

    private final List<TargetValueOutput> resources = new ArrayList<>();
    private final List<TargetValueOutput> actions = new ArrayList<>();
    private final List<TargetValueOutput> subjects = new ArrayList<>();
    private final List<ObligationOutput> obligationOutputs  = new ArrayList<>();

    public Permission getPermission() {
        return new Permission(name, getResources(), getActions(), getSubjects());
    }

    public PermissionOutput() {
        // keep default constructor
    }

    public PermissionOutput(Permission permission) {
        setResources(createTargetValueOutputList(permission.getResources()));
        setActions(createTargetValueOutputList(permission.getActions()));
        setSubjects(createTargetValueOutputList(permission.getSubjects()));
        setObligations(createObligationOutputs(permission.getObligations()));
        setName(permission.getName());
    }

    public List<TargetValue> getResources() {
        return createTargetValueList(resources);
    }

    public void setResources(List<TargetValueOutput> resources) {
        this.resources.clear();
        this.resources.addAll(resources);
    }

    public List<TargetValue> getActions() {
        return createTargetValueList(actions);
    }

    public void setActions(List<TargetValueOutput> actions) {
        this.actions.clear();
        this.actions.addAll(actions);
    }

    public List<TargetValue> getSubjects() {
        return createTargetValueList(subjects);
    }

    public void setSubjects(List<TargetValueOutput> subjects) {
        this.subjects.clear();
        this.subjects.addAll(subjects);
    }

    public List<Obligation> getObligations() {
        ArrayList<Obligation> obligations = new ArrayList<>();
        for (ObligationOutput obligationOutput : this.obligationOutputs) {
            obligations.add(obligationOutput.getObligation());
        }
        return obligations;
    }

    private List<ObligationOutput> createObligationOutputs(List<Obligation> obligations) {
        List<ObligationOutput> obligationOutputs = new ArrayList<>();
        for (Obligation obligation : obligations) {
            obligationOutputs.add(new ObligationOutput(obligation));
        }
        return obligationOutputs;
    }

    public void setObligations(List<ObligationOutput> obligations) {
        this.obligationOutputs.clear();
        this.obligationOutputs.addAll(obligations);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    private List<TargetValue> createTargetValueList(List<TargetValueOutput> entries) {
        ArrayList<TargetValue> targetValues = new ArrayList<>();
        for (TargetValueOutput targetValue : entries) {
            targetValues.add(new TargetValue(targetValue.getValue(), targetValue.getDomains()));
        }
        return targetValues;
    }

    private List<TargetValueOutput> createTargetValueOutputList(List<TargetValue> entries) {
        ArrayList<TargetValueOutput> targetValues = new ArrayList<>();
        for (TargetValue targetValue : entries) {
            targetValues.add(new TargetValueOutput(targetValue));
        }
        return targetValues;
    }



}

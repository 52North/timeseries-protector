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
import java.util.ArrayList;
import java.util.List;
import org.n52.security.service.pdp.simplepermission.Permission;
import org.n52.security.service.pdp.simplepermission.PermissionSet;

/**
 *
 * @author Henning Bredel <h.bredel@52north.org>
 */

public final class PermissionSetOutput {

    private List<String> resourceDomains = new ArrayList<String>();
    private List<String> actionDomains = new ArrayList<String>();
    private List<String> subjectDomains = new ArrayList<String>();
    private List<PermissionOutput> subPermissions = new ArrayList<PermissionOutput>();
    private String name;

    public PermissionSet getPermissionSet() {
        return new PermissionSet(name, resourceDomains, actionDomains, subjectDomains, getSubPermissions());
    }

    public PermissionSetOutput() {
        // keep default constructor
    }

    public PermissionSetOutput(PermissionSet permissionSet) {
        subPermissions = createSubPermissionOutputs(permissionSet.getSubPermissions());
        setResourceDomains(permissionSet.getResourceDomains());
        setActionDomains(permissionSet.getActionDomains());
        setSubjectDomains(permissionSet.getSubjectDomains());
        setName(permissionSet.getName());
    }

    public List<String> getResourceDomains() {
        return resourceDomains;
    }

    public void setResourceDomains(List<String> resourceDomains) {
        this.resourceDomains = resourceDomains;
    }

    public List<String> getActionDomains() {
        return actionDomains;
    }

    public void setActionDomains(List<String> actionDomains) {
        this.actionDomains = actionDomains;
    }

    public List<String> getSubjectDomains() {
        return subjectDomains;
    }

    public void setSubjectDomains(List<String> subjectDomains) {
        this.subjectDomains = subjectDomains;
    }

    public List<Permission> getSubPermissions() {
        ArrayList<Permission> permissions = new ArrayList<>();
        for(PermissionOutput permissionOutput : subPermissions) {
            permissions.add(permissionOutput.getPermission());
        }
        return permissions;
    }

    private List<PermissionOutput> createSubPermissionOutputs(List<Permission> subPermissions) {
        ArrayList<PermissionOutput> permissions = new ArrayList<>();
        for (Permission permission : subPermissions) {
            this.subPermissions.add(new PermissionOutput(permission));
        }
        return permissions;
    }

    public void setSubPermissions(List<PermissionOutput> subPermissions) {
        this.subPermissions = subPermissions;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


}

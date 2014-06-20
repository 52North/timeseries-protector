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
package org.n52.sensorweb.series.policy.editor.srv;

import java.util.List;
import org.n52.security.service.pdp.simplepermission.Permission;
import org.n52.security.service.pdp.simplepermission.PermissionSet;
import org.n52.sensorweb.series.policy.api.PermissionManagementException;

/**
 *
 * @author Henning Bredel <h.bredel@52north.org>
 */
public interface SimplePermissionService {

    public List<PermissionSet> getPermissionSets();

    /**
     * Gets the permission set by name.
     *
     * @param name the set's name.
     * @return the permission set or <code>null</code> if not found.
     */
    public PermissionSet getPermissionSet(String name);

    /**
     *
     * @param permissionSet the permission set to create.
     * @return the created permission set.
     * @throws PermissionManagementException if creation failed for internal reasons.
     */
    public PermissionSet savePermissionSet(PermissionSet permissionSet) throws PermissionManagementException;

    public void deletePermissionSet(String name) throws PermissionManagementException;
    /**
     * Adds a permission to a given permission set.
     *
     * @param permissionSetName the persmissionSet's name to add the permission to.
     * @param permission the permission to add.
     * @throws PermissionManagementException if permission management task failed.
     * @throws NullPointerException if permission is <code>null</code>.
     */
    public void addPermission(String permissionSetName, Permission permission) throws PermissionManagementException;

    /**
     * @param permissionSetName whose permission is to be fetched
     * @param permissionName the permission to be fetched
     * @return permission
     * @throws PermissionManagementException
     */
    public Permission getPermission(String permissionSetName,String permissionName);
    
    public void editPermission(String permissionSetName, Permission permission) throws PermissionManagementException;

    public void deletePermission(String permissionSetName, Permission permission) throws PermissionManagementException;

    public SimplePermissionValidationService getSimplePermissionValidationService();

    public void setSimplePermissionValidationService(SimplePermissionValidationService simplePermissionValidationService);
}

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
package org.n52.sensorweb.series.policy.editor.srv.impl;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URL;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;

import org.n52.web.BadRequestException;
import org.n52.web.ResourceNotFoundException;
import org.n52.security.service.pdp.simplepermission.Permission;
import org.n52.security.service.pdp.simplepermission.PermissionSet;
import org.n52.security.service.pdp.simplepermission.SimplePermissionFileProvider;
import org.n52.sensorweb.series.policy.api.ConfigurationError;
import org.n52.sensorweb.series.policy.api.PermissionManagementException;
import org.n52.sensorweb.series.policy.editor.srv.SimplePermissionService;
import org.n52.sensorweb.series.policy.editor.srv.SimplePermissionValidationService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.ServletContextAware;

/**
 *
 * @author Henning Bredel <h.bredel@52north.org>
 */
public class XmlFileSimplePermissionService implements SimplePermissionService, ServletContextAware {

    private static final Logger LOGGER = LoggerFactory.getLogger(XmlFileSimplePermissionService.class);

    private SimplePermissionValidationService simplePermissionValidationService;

    private String permissionFile = "/WEB-INF/classes/permissions.xml";

    private final XmlFileSimplePermissionWriter writer;

	private final SimplePermissionFileProvider provider;

    public XmlFileSimplePermissionService() {
        simplePermissionValidationService = SimplePermissionValidationService.Factory.createNoValidation();
        writer = new XmlFileSimplePermissionWriter();
        provider = new SimplePermissionFileProvider();
    }

    public void init() throws ConfigurationError {
        try {
            provider.setPath(getCheckedConfiguredFile());
            reloadPermissionFile();
        } catch (IOException e) {
            throw new ConfigurationError(e);
        }
    }

    private String getCheckedConfiguredFile() throws IOException {
        URL url = getClass().getResource(getPermissionFile());
        if (url == null) {
            LOGGER.info("Permissions File: '" + permissionFile + "'");
            File file = new File(getPermissionFile());
            writer.createEmptyPermissionFileIfNotExist(file);
            permissionFile = file.toPath().toString();
            return permissionFile;
        }
        return url.getFile();
    }

    private void reloadPermissionFile() {
        provider.init();
    }

    @Override
    public List<PermissionSet> getPermissionSets() {
        return provider.getPermissionSets();
    }

    @Override
    public PermissionSet getPermissionSet(String name) {
        for (PermissionSet permissionSet : getPermissionSets()) {
            if (permissionSet.getName().equals(name))
                return permissionSet;
        }
        return null;
    }

    @Override
    public PermissionSet savePermissionSet(PermissionSet permissionSet) throws PermissionManagementException {
        simplePermissionValidationService.checkData(permissionSet);
        if (containsPermissionSet(permissionSet.getName()))
            deletePermissionSet(permissionSet.getName());

        getPermissionSets().add(permissionSet);
        savePermissionFile();
        return getPermissionSet(permissionSet.getName());
    }

    @Override
    public void deletePermissionSet(String name) throws PermissionManagementException {
        Iterator<PermissionSet> it = getPermissionSets().iterator();
        for (boolean found = false; !found && it.hasNext();) {
            PermissionSet permissionSet = it.next();
            if (permissionSet.getName().equals(name)) {
                found = true;
                it.remove();
            }
        }
        savePermissionFile();
    }

    @Override
    public void addPermission(String permissionSetName, Permission permission) throws PermissionManagementException {
        PermissionSet permissionSet = getPermissionSet(permissionSetName);
        if (permissionSet == null)
            throw new ResourceNotFoundException("PermissionSet with name '" + permissionSetName + "' not found.");

        simplePermissionValidationService.checkData(permission);
        if(containsPermission(permissionSet, permission))
        {
        	Iterator<Permission> it=permissionSet.getSubPermissions().iterator();
        	while(it.hasNext())
        	{
        		Permission subPermission = it.next();
        		if(subPermission.getName().equals(permission.getName()))
        		{
        			it.remove();
        		}
        	}
        }
         permissionSet.getSubPermissions().add(permission);
        savePermissionFile();
    }

    private boolean containsPermissionSet(String name) {
        List<PermissionSet> permissionSets = getPermissionSets();
        for (PermissionSet permissionSet : permissionSets) {
            if (permissionSet.getName().equals(name))
                return true;
        }
        return false;
    }

    private boolean containsPermission(PermissionSet permissionSet, Permission permission) {
        if (permission == null)
            throw new NullPointerException("Permission is null.");

        List<Permission> subPermissions = permissionSet.getSubPermissions();
        for (Permission subPermission : subPermissions) {
            if (subPermission.getName().equals(permission.getName()))
                return true;
        }
        return false;
    }

    @Override
    public void editPermission(String permissionSetName, Permission permission) throws PermissionManagementException {

    }

    @Override
    public void deletePermission(String permissionSetName, Permission permission) throws PermissionManagementException {
  
    	Iterator<Permission> itp= getPermissionSet(permissionSetName).getSubPermissions().iterator();
        while(itp.hasNext())
        {
        	Permission subPermission = itp.next();
        	if(subPermission.getName().equals(permission.getName()))
        	{
        		itp.remove();
        		break;
        	}
        }
        savePermissionFile();
    }

    /**
     * Sets a path to the file providing available permissions.
     *
     * @param permissionFile the path to a permission file.
     * @see #init() to load the content.
     */
    public void setPermissionFile(String permissionFile) {
        this.permissionFile = permissionFile;
    }

    public String getPermissionFile() {
        return permissionFile;
    }

    private void savePermissionFile() throws PermissionManagementException {
        try {
            writer.save(getPermissionSets(), new File(permissionFile));
            reloadPermissionFile();
        } catch (FileNotFoundException e) {
            throw new PermissionManagementException("Could not find permission file: '" + permissionFile + "'.", e);
        } catch (IOException e) {
            throw new PermissionManagementException("Could not write permission file: '" + permissionFile + "'.", e);
        }
    }

    @Override
    public void setServletContext(ServletContext sc) {
        permissionFile = sc.getRealPath(permissionFile);
    }

    @Override
    public SimplePermissionValidationService getSimplePermissionValidationService() {
        return simplePermissionValidationService;
    }

    @Override
    public void setSimplePermissionValidationService(SimplePermissionValidationService simplePermissionValidationService) {
        this.simplePermissionValidationService = simplePermissionValidationService;
    }

    @Override
    public Permission getPermission(String permissionSetName, String permissionName) {
        for(Permission permission: getPermissionSet(permissionSetName).getSubPermissions())
        {
            if(permission.getName().equals(permissionName))
            {
                return permission;
            }
        }
        return null;
    }


 }

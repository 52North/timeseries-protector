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
import java.util.List;
import javax.servlet.ServletContext;
import org.n52.security.service.pdp.simplepermission.Permission;
import org.n52.security.service.pdp.simplepermission.PermissionSet;
import org.n52.security.service.pdp.simplepermission.SimplePermissionFileProvider;
import org.n52.sensorweb.series.policy.api.ConfigurationError;
import org.n52.sensorweb.series.policy.api.PermissionManagementException;
import org.n52.sensorweb.series.policy.editor.srv.SimplePermissionService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.ServletContextAware;

/**
 *
 * @author Henning Bredel <h.bredel@52north.org>
 */
public class XmlFileSimplePermissionService implements SimplePermissionService, ServletContextAware {

    private static final Logger LOGGER = LoggerFactory.getLogger(XmlFileSimplePermissionService.class);

    private XmlFileSimplePermissionWriter writer;

	private SimplePermissionFileProvider provider;

    private String permissionFile = "/permissions.xml";

    public void init() throws ConfigurationError {
        try {
            writer = new XmlFileSimplePermissionWriter();
            provider = new SimplePermissionFileProvider();
            provider.setPath(getCheckedConfiguredFile());
            reloadPermissionFile();
        } catch (IOException e) {
            throw new ConfigurationError(e);
        }
    }

    private String getCheckedConfiguredFile() throws IOException {
        URL url = getClass().getResource(getPermissionFile());
        if (url == null) {
            File file = new File(getPermissionFile());
            writer.createEmptyPermissionFileIfNotExist(file);
            permissionFile = file.toPath().toString();
            LOGGER.info("Permissions File: '" + permissionFile + "'");
            return permissionFile;
        }
        return url.getFile();
    }

    private void reloadPermissionFile() {
        provider.init();
    }

    public List<PermissionSet> getPermissionSets() {
        return provider.getPermissionSets();
    }

    public void createPermissionSet(PermissionSet permissionSet) throws PermissionManagementException {
        getPermissionSets().add(permissionSet);
        savePermissionFile();
    }

    public void addPermission(Permission permission) throws PermissionManagementException {

    }

    public void editPermission(Permission permission) throws PermissionManagementException {

    }

    public void deletePermission(Permission permission) throws PermissionManagementException {

    }

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

    public void setServletContext(ServletContext sc) {
        permissionFile = sc.getRealPath("/permissions.xml");
    }

 }

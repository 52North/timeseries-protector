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
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import org.apache.xmlbeans.XmlObject;
import org.apache.xmlbeans.XmlOptions;
import org.n52.security.service.pdp.simplepermission.Attribute;
import org.n52.security.service.pdp.simplepermission.Obligation;
import org.n52.security.service.pdp.simplepermission.Permission;
import org.n52.security.service.pdp.simplepermission.PermissionSet;
import org.n52.security.service.pdp.simplepermission.TargetValue;
import org.n52.security.service.pdp.simplepermission.xb.XmlAttributeType;
import org.n52.security.service.pdp.simplepermission.xb.XmlDomainType;
import org.n52.security.service.pdp.simplepermission.xb.XmlObligationType;
import org.n52.security.service.pdp.simplepermission.xb.XmlPermissionSetType;
import org.n52.security.service.pdp.simplepermission.xb.XmlPermissionType;
import org.n52.security.service.pdp.simplepermission.xb.XmlSimplePermissionsDocument;
import org.n52.security.service.pdp.simplepermission.xb.XmlSimplePermissionsType;
import org.n52.security.service.pdp.simplepermission.xb.XmlTargetValueType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Creates a SimplePermission XML document and saves it to a file.
 *
 * @author Henning Bredel <h.bredel@52north.org>
 */
public class XmlFileSimplePermissionWriter {

    private static final Logger LOGGER = LoggerFactory.getLogger(XmlFileSimplePermissionWriter.class);

    private final Domains domains = new Domains();

    private XmlOptions getDefaultXmlOptions() {
        return new XmlOptions()
                .setSavePrettyPrint()
                .setSavePrettyPrintIndent(2);
    }

    /**
     * Creates an empty permission file if it does not exist yet.
     *
     * @param file the file to save.
     * @return the subjected file.
     * @throws IOException if saving the file fails.
     */
    public File createEmptyPermissionFileIfNotExist(File file) throws IOException {
        LOGGER.info("Create new permission file: '" + file.getAbsolutePath() + "'.");
        if (file.createNewFile()) {
            save(new ArrayList<PermissionSet>(), file);
        } else {
            LOGGER.info("Permissions file already exists!");
        }
        return file;
    }

    /**
     * Saves all permission sets into an XML file. If no permissions are present, an empty (but invalid) XML document is
     * being created.
     *
     * @param permissionSets the permission sets to be saved.
     * @param file the file to save to.
     * @throws FileNotFoundException if the file was not found and could not created appropriately.
     * @throws IOException if the file could not be written.
     */
    public void save(List<PermissionSet> permissionSets, File file) throws FileNotFoundException, IOException {
        permissionSets = permissionSets.isEmpty() ? new ArrayList<PermissionSet>() : permissionSets;
        XmlObject doc = createSimplePermissionsDocument(permissionSets);
        try (OutputStream out = new FileOutputStream(file)) {
            doc.save(out, getDefaultXmlOptions());
        }
    }

    private XmlObject createSimplePermissionsDocument(List<PermissionSet> permissionSets) {
        XmlSimplePermissionsDocument doc = XmlSimplePermissionsDocument.Factory.newInstance();
        XmlSimplePermissionsType simplePermissions = doc.addNewSimplePermissions();
        for (PermissionSet permissionSet : permissionSets) {
            addPermissionSetTo(simplePermissions, permissionSet);
        }
        return doc;
    }

    private void addPermissionSetTo(XmlSimplePermissionsType simplePermissions, PermissionSet permissionSet) {
        XmlPermissionSetType entry = simplePermissions.addNewPermissionSet();
        entry.setName(permissionSet.getName());
        addDomainsTo(entry, permissionSet);
        addPermissionsTo(entry, permissionSet);
    }

    private void addDomainsTo(XmlPermissionSetType entry, PermissionSet permissionSet) {
        for (Object domain : permissionSet.getResourceDomains()) {
            XmlDomainType resourceDomain = entry.addNewResourceDomain();
            resourceDomain.setValue((String) domain);
            domains.addResourceDomain((String) domain);
        }

        for (Object domain : permissionSet.getActionDomains()) {
            XmlDomainType actionDomain = entry.addNewActionDomain();
            actionDomain.setValue((String) domain);
            domains.addActionDomain((String) domain);
        }

        for (Object domain : permissionSet.getSubjectDomains()) {
            XmlDomainType subjectDomain = entry.addNewSubjectDomain();
            subjectDomain.setValue((String) domain);
            domains.addSubjectDomain((String) domain);
        }
    }

    private void addPermissionsTo(XmlPermissionSetType entry, PermissionSet permissionSet) {
        for (Object permission : permissionSet.getSubPermissions()) {
            XmlPermissionType permissionType = entry.addNewPermission();
            addPermissionTo(permissionType, (Permission) permission);
        }
    }

    private void addPermissionTo(XmlPermissionType permissionType, Permission permission) {
        permissionType.setName(permission.getName());
        for (Object resource : permission.getResources()) {
            XmlTargetValueType targetValue = permissionType.addNewResource();
            addResourceTo(targetValue, (TargetValue) resource);
        }

        for (Object action : permission.getActions()) {
            XmlTargetValueType targetValue = permissionType.addNewAction();
            addActionTo(targetValue, (TargetValue) action);
        }

        for (Object subject : permission.getSubjects()) {
            XmlTargetValueType targetValue = permissionType.addNewSubject();
            addSubjectTo(targetValue, (TargetValue) subject);
        }

        if (!(permission.getObligations() == null || permission.getObligations().isEmpty())) {
            for (Object obligation : permission.getObligations()) {
                XmlObligationType obligationType = permissionType.addNewObligation();
                addObligationTo(obligationType, (Obligation) obligation);
            }
        }
    }

    private void addResourceTo(XmlTargetValueType targetValueType, TargetValue targetValue) {
        targetValueType.setValue(targetValue.getValue());
        if (isOverriddenResourceDomain(targetValue)) {
            Object domain = targetValue.getDomains().get(0);
            targetValueType.setDomain((String) domain);
        }
    }

    private boolean isOverriddenResourceDomain(TargetValue targetValue) {
        if (targetValue.getDomains().size() != 1) {
            return false;
        }
        String domain = (String) targetValue.getDomains().get(0);
        return domains.containsResourceDomain(domain);
    }

    private void addActionTo(XmlTargetValueType targetValueType, TargetValue targetValue) {
        targetValueType.setValue(targetValue.getValue());
        if (isOverriddenActionDomain(targetValue)) {
            Object domain = targetValue.getDomains().get(0);
            targetValueType.setDomain((String) domain);
        }
    }

    private boolean isOverriddenActionDomain(TargetValue targetValue) {
        if (targetValue.getDomains().size() != 1) {
            return false;
        }
        String domain = (String) targetValue.getDomains().get(0);
        return domains.containsActionDomain(domain);
    }

    private void addSubjectTo(XmlTargetValueType targetValueType, TargetValue targetValue) {
        targetValueType.setValue(targetValue.getValue());
        if (isOverriddenSubjectDomain(targetValue)) {
            Object domain = targetValue.getDomains().get(0);
            targetValueType.setDomain((String) domain);
        }
    }

    private boolean isOverriddenSubjectDomain(TargetValue targetValue) {
        if (targetValue.getDomains().size() != 1) {
            return false;
        }
        String domain = (String) targetValue.getDomains().get(0);
        return domains.containsSubjectDomain(domain);
    }

    private void addObligationTo(XmlObligationType obligationType, Obligation obligation) {
        obligationType.setName(obligation.getName());
        for (Object attribute : obligation.getAttributes()) {
            XmlAttributeType attributeType = obligationType.addNewAttribute();
            addAttributeTo(attributeType, (Attribute) attribute);
        }
    }

    private void addAttributeTo(XmlAttributeType attributeType, Attribute attribute) {
        attributeType.setName(attribute.getName());
        attributeType.setAttributeDataType(attribute.getType());
        attributeType.getDomNode().setNodeValue((String) attribute.getValue());
    }

    private static class Domains {

        private final List<String> resourceDomains = new ArrayList<String>();
        private final List<String> actionDomains = new ArrayList<String>();
        private final List<String> subjectDomains = new ArrayList<String>();

        void addResourceDomain(String domain) {
            resourceDomains.add(domain);
        }

        void addActionDomain(String domain) {
            resourceDomains.add(domain);
        }

        void addSubjectDomain(String domain) {
            resourceDomains.add(domain);
        }

        List<String> getResourceDomains() {
            return resourceDomains;
        }

        List<String> getActionDomains() {
            return actionDomains;
        }

        List<String> getSubjectDomains() {
            return subjectDomains;
        }

        boolean containsResourceDomain(String domain) {
            return resourceDomains.contains(domain);
        }

        boolean containsActionDomain(String domain) {
            return actionDomains.contains(domain);
        }

        boolean containsSubjectDomain(String domain) {
            return subjectDomains.contains(domain);
        }
    }

}

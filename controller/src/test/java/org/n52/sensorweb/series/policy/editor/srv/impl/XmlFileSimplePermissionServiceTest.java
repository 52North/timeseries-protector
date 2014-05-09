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
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.util.List;
import static org.hamcrest.CoreMatchers.is;
import org.junit.After;
import static org.junit.Assert.*;
import org.junit.Before;
import org.junit.Test;
import org.n52.security.service.pdp.simplepermission.PermissionSet;
import org.n52.sensorweb.series.policy.api.PermissionManagementException;

public class XmlFileSimplePermissionServiceTest {

    private static final String FILE_PATH = "/files/";

    private static final String FILE_NAME = "test-file.xml";

    private static final String TEST_FILE = FILE_PATH + FILE_NAME;

    private XmlFileSimplePermissionTestData testdata;

    private XmlFileSimplePermissionService service;

    private File testfile;

    @Before
    public void setUp() throws IOException {
        service = new XmlFileSimplePermissionService();
        testdata = new XmlFileSimplePermissionTestData();
        testfile = new File(FileUtils.getAbsolutePathFor(FILE_PATH, FILE_NAME));
        initPermissionServiceWithConfigFile(FILE_PATH + "test-permissions.xml");
    }

    @After
    public void tearDown() throws IOException {
        if (testfile.exists()) {
            Files.delete(testfile.toPath());
        }
    }

    @Test
    public void shouldHaveInitializedFromDefaultFileLocation() {
        assertThat("Could not find test test-permissions.xml", service.getPermissionSets().size(), is(1));
    }

    @Test
    public void shouldInitializeFromAbsoluteFileLocation() throws URISyntaxException, FileNotFoundException {
        initPermissionServiceWithConfigFile(FileUtils.getAbsolutePathFor(FILE_PATH, "test-permissions.xml"));
        assertThat("Could not find test test-permissions.xml", service.getPermissionSets().size(), is(1));
    }

    @Test
    public void shouldReadSimplePermissionFile() {
        assertThat("Could not find test test-permissions.xml", service.getPermissionSets().size(), is(1));
    }

    @Test
    public void shouldCreatePermissionFileIfNotFound() {
        String expected = testfile.getAbsolutePath();
        initPermissionServiceWithConfigFile(expected);
        assertTrue("'" + expected + "' does not exist!", new File(expected).exists());
    }

    @Test
    public void shouldAddPermissionSet() throws PermissionManagementException {
        String file = testfile.getAbsolutePath();
        initPermissionServiceWithConfigFile(file);

        List<PermissionSet> testSets = testdata.getPermissionSets();
        PermissionSet permissionSet = testSets.get(0);
        service.savePermissionSet(permissionSet);

        assertThat(service.getPermissionSets().size(), is(1));
        PermissionSet set = service.getPermissionSets().get(0);
        assertThat(set.getSubPermissions().size(), is(4));
    }

    private void initPermissionServiceWithConfigFile(String configFile) {
        service.setPermissionFile(configFile);
        service.init();
    }

}

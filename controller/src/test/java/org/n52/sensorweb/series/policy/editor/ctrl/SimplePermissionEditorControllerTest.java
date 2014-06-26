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
package org.n52.sensorweb.series.policy.editor.ctrl;

import java.util.List;
import java.util.Map;
import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.not;
import static org.hamcrest.Matchers.empty;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.n52.security.service.pdp.simplepermission.PermissionSet;
import org.n52.sensorweb.series.policy.editor.srv.impl.XmlFileSimplePermissionService;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Henning Bredel <h.bredel@52north.org>
 */
public class SimplePermissionEditorControllerTest {
    private SimplePermissionEditorController controller;

    @Before
    public void setUp() {
        controller = new SimplePermissionEditorController();
        XmlFileSimplePermissionService service = new XmlFileSimplePermissionService();
        service.setPermissionFile("/files/test-permissions.xml");
        service.init();

        controller.setSimplePermissionService(service);
        Assert.assertThat(service.getPermissionSets(), is(not(empty())));
    }

    @Test
    public void testListPermission() {
        ModelAndView mav = controller.listPermissions(null);
        Assert.assertThat(mav.getViewName(), is("listPermissionSets"));
        Assert.assertTrue(mav.getModel().containsKey("permissionSets"));

        Map<String, Object> modelMap = mav.getModelMap();
        List<PermissionSet> permissionSets = (List<PermissionSet>) modelMap.get("permissionSets");
        Assert.assertNotNull(permissionSets);
        Assert.assertThat(permissionSets, is(not(empty())));
    }

}

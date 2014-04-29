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

import java.util.Collection;
import java.util.HashMap;
import org.n52.sensorweb.series.policy.editor.srv.SimplePermissionService;
import org.n52.server.mgmt.ConfigurationContext;
import org.n52.shared.serializable.pojos.sos.SOSMetadata;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Henning Bredel <h.bredel@52north.org>
 */
@Controller
public class SimplePermissionController {

    private SimplePermissionService simplePermissionService;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView startEditor() {

        HashMap<String, Object> services = new HashMap<String, Object>();
        for (SOSMetadata metadata : ConfigurationContext.getSOSMetadatas()) {
            services.put(metadata.getTitle(), metadata);
        }

        HashMap<String, Object> users = new HashMap<String, Object>();
        users.put("user", "user");

        HashMap<String, Object> content = new HashMap<String, Object>();
        content.put("services", services);
        content.put("users", users);

        return new ModelAndView("editor/newPolicy", content);
    }

    @RequestMapping(value = "/create", method = RequestMethod.PUT)
    public ModelAndView create(@RequestParam String serviceId, @RequestParam String user) {

        return null;
    }

    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public ModelAndView editPolicy() {

        return new ModelAndView("editor/editPolicy");
    }

    public SimplePermissionService getSimplePermissionService() {
        return simplePermissionService;
    }

    public void setSimplePermissionService(SimplePermissionService simplePermissionService) {
        this.simplePermissionService = simplePermissionService;
    }

}

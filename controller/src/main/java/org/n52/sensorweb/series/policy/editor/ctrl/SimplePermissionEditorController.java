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

import org.n52.io.IoParameters;
import org.n52.web.BadRequestException;
import org.n52.web.BaseController;
import org.n52.web.InternalServerException;
import org.n52.web.ResourceNotFoundException;
import org.n52.security.service.pdp.simplepermission.PermissionSet;
import org.n52.sensorweb.series.policy.api.PermissionManagementException;
import org.n52.sensorweb.series.policy.editor.srv.EnforcementPointService;
import org.n52.sensorweb.series.policy.editor.srv.SimplePermissionService;
import org.n52.sensorweb.series.policy.editor.srv.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Henning Bredel <h.bredel@52north.org>
 */
@Controller
public class SimplePermissionEditorController extends BaseController {

    private SimplePermissionService simplePermissionService;

    private EnforcementPointService enforcementPointService;

    private TimeseriesService parameterServiceProvider;

    private UserService userService;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView listPermissions() {
        ModelAndView mav = new ModelAndView("listPermissions");
        return mav.addObject("permissionSets", simplePermissionService.getPermissionSets());
    }

    @RequestMapping(value = "/new", method = RequestMethod.GET)
    public ModelAndView createPermissions() {
        ModelAndView mav = new ModelAndView("createPermission");
        mav.addObject("users", userService.getConfiguredUsers());
        mav.addObject("enforcementPoints", enforcementPointService.getEnforcementPoints());
        return mav;
    }

    //@RequestMapping(value = "/{permissionSetName}", method = RequestMethod.GET)
    public ModelAndView editPermission(@PathVariable("permissionSetName") String permissionSetName) {
        ModelAndView mav = new ModelAndView("editor/editPermission");
        PermissionSet permissionSet = simplePermissionService.getPermissionSet(permissionSetName);
        if (permissionSet == null) {
            throw new ResourceNotFoundException("No permissionSet with name '" + permissionSetName + "'.");
        }
        return mav.addObject(permissionSet);
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public ModelAndView createPermission(@RequestBody(required = true) PermissionSet permissionSet) {
        System.out.println("I got here :)");
        PermissionSet result = simplePermissionService.getPermissionSet(permissionSet.getName());
        if (result != null) {
            // TODO already exists ... let GUI ask to edit/override
            throw new BadRequestException("Overriding resources not supported yet.");
        }
        try {
            result = simplePermissionService.savePermissionSet(permissionSet);
        } catch (PermissionManagementException e) {
            throw new InternalServerException("Could not create resource.", e);
        }
        ModelAndView mav = new ModelAndView("resultView");
        return mav.addObject(result);
    }

    @RequestMapping(value = "/timeseries", method = RequestMethod.GET, produces = "application/json")
    public ModelAndView listTimeseries() {
        ModelAndView mav = new ModelAndView("timeseries");
        IoParameters query = IoParameters.createDefaults();
        return mav.addObject("parameterProvider",parameterServiceProvider.getTimeseriesService().getCondensedParameters(query));
    }

    public SimplePermissionService getSimplePermissionService() {
        return simplePermissionService;
    }

    public void setSimplePermissionService(SimplePermissionService simplePermissionService) {
        this.simplePermissionService = simplePermissionService;
    }

    public EnforcementPointService getEnforcementPointService() {
        return enforcementPointService;
    }

    public void setEnforcementPointService(EnforcementPointService enforcementPointService) {
        this.enforcementPointService = enforcementPointService;
    }

    public UserService getUserService() {
        return userService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public TimeseriesService getParameterServiceProvider() {
        return parameterServiceProvider;
    }

    public void setParameterServiceProvider(TimeseriesService parameterServiceProvider) {
        this.parameterServiceProvider = parameterServiceProvider;
    }


}

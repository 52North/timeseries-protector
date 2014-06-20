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

import java.util.LinkedHashMap;

import javax.servlet.http.HttpServletRequest;

import org.n52.io.IoParameters;
import org.n52.security.service.pdp.simplepermission.Permission;
import org.n52.security.service.pdp.simplepermission.PermissionSet;
import org.n52.sensorweb.series.policy.api.PermissionManagementException;
import org.n52.sensorweb.series.policy.editor.srv.EnforcementPointService;
import org.n52.sensorweb.series.policy.editor.srv.SimplePermissionService;
import org.n52.sensorweb.series.policy.editor.srv.UserService;
import org.n52.web.BadRequestException;
import org.n52.web.BaseController;
import org.n52.web.InternalServerException;
import org.n52.web.ResourceNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
/**
 * 
 * @author Henning Bredel <h.bredel@52north.org>
 * @author Dushyant Sabharwal <d.sabharwal@52north.org>
 */

@Controller
public class SimplePermissionEditorController extends BaseController {

    private SimplePermissionService simplePermissionService;

    private EnforcementPointService enforcementPointService;

    private TimeseriesService parameterServiceProvider;

    private UserService userService;

    /**
     * @return permissionSets to be displayed
     */
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView listPermissions()
    {
        ModelAndView mav = new ModelAndView("listPermissionSets");
        mav.addObject("permissionSets", simplePermissionService.getPermissionSets());
        mav.addObject("pageTitle", "List Permission Sets");
        mav.addObject("heading", "Timeseries Permission Manager");
        
        LinkedHashMap<String,String> breadCrumb=new LinkedHashMap<String,String>();
        breadCrumb.put("Manager","/protector-webapp/editor/");
        mav.addObject("breadCrumb",breadCrumb);
        return mav;
    }

    /**
     * @return The new Create Permission set view
     */
    @RequestMapping(value = "/new", method = RequestMethod.GET)
    public ModelAndView createPermissions()
    {
        ModelAndView mav = new ModelAndView("createPermissionSet");
        mav.addObject("pageTitle", "Create Permission Set");
        mav.addObject("heading", "Create Permission Set");
        
        LinkedHashMap<String,String> breadCrumb=new LinkedHashMap<String,String>();
        /* the ordering of elements maintains a rendering order for bread crumb*/
        breadCrumb.put("Manager","/protector-webapp/editor/");
        breadCrumb.put("Permission Set","/protector-webapp/editor/new");
        mav.addObject("breadCrumb",breadCrumb);
        
        /*
         * The below objects will no longer be used mav.addObject("users", userService.getConfiguredUsers());
         * mav.addObject("enforcementPoints", enforcementPointService.getEnforcementPoints());
         */
        return mav;
    }

    /**
     * @return
     */
    @RequestMapping(value = "/newPermission", method = RequestMethod.GET)
    public ModelAndView createPermission(HttpServletRequest request)
    {
        ModelAndView mav = new ModelAndView("createPermission");
        mav.addObject("users", userService.getConfiguredUsers());
        mav.addObject("pageTitle", "Create Permission");
        mav.addObject("heading", "Create Permission");
        
        String [] referer=request.getHeader("referer").split("/");
        
        LinkedHashMap<String,String> breadCrumb=new LinkedHashMap<String,String>();
        
        /* the ordering of elements maintains a rendering order for bread crumb*/
        
        breadCrumb.put("Manager","/protector-webapp/editor/");
        System.out.println(referer[5]);
        if(referer[5].equals("edit"))
        {
            breadCrumb.put("Permission Set","/protector-webapp/editor/edit/"+referer[6]);
        }   
        else
            breadCrumb.put("Permission Set","/protector-webapp/editor/new");
        
        breadCrumb.put("Permission","/protector-webapp/editor/new");
        mav.addObject("breadCrumb",breadCrumb);
        return mav;
    }

    /**
     * @param permissionSetName
     *        to be deleted
     * @return permissionSets the remaining permission sets
     */
    @RequestMapping(value = "/delete/{permissionSetName}", method = RequestMethod.POST)
    public ModelAndView deletePermissionSet(@PathVariable String permissionSetName)
    {
        ModelAndView mav = new ModelAndView("listPermissionSets");
        // splitting the string to get features which are to be deleted one by one
        String[] sets = permissionSetName.split(",");
        try
        {
            for (int i = 0; i < sets.length; i++)
            {
                simplePermissionService.deletePermissionSet(sets[i]);
            }
        }
        catch (PermissionManagementException e)
        {
            throw new InternalServerException("Could not delete permission set.", e);
        }
        mav.addObject("permissionSets", simplePermissionService.getPermissionSets());
        return mav;
    }

    /**
     * @param permissionSetName
     *        the permission set to be edited
     * @return permissionSet
     */
    @RequestMapping(value = "/edit/{permissionSetName}", method = RequestMethod.GET)
    public ModelAndView editPermissionSet(@PathVariable String permissionSetName)
    {
        ModelAndView mav = new ModelAndView("createPermissionSet");
        PermissionSet permissionSet = simplePermissionService.getPermissionSet(permissionSetName);
        if (permissionSet == null)
        {
            throw new ResourceNotFoundException("No permissionSet with name '" + permissionSetName + "'.");
        }
        mav.addObject(permissionSet);
        mav.addObject("pageTitle", "Modify Permission Set");
        mav.addObject("heading", "Modify " + permissionSetName);
        
        LinkedHashMap<String,String> breadCrumb=new LinkedHashMap<String,String>();
        breadCrumb.put("Manager","/protector-webapp/editor/");
        breadCrumb.put("Permission Set","/protector-webapp/editor/edit/"+permissionSetName);
        mav.addObject("breadCrumb",breadCrumb);
        return mav;
    }

    /**
     * @param permissionSetName
     *        whose permission is to be fetched
     * @param permissionName
     *        the permission to be edited
     * @return permission
     */
    @RequestMapping(value = "/edit/{permissionSetName}/{permissionName}", method = RequestMethod.GET)
    public ModelAndView editPermission(@PathVariable String permissionSetName, @PathVariable String permissionName)
    {
        ModelAndView mav = new ModelAndView("createPermission");
        PermissionSet permissionSet = simplePermissionService.getPermissionSet(permissionSetName);
        Permission permission = simplePermissionService.getPermission(permissionSetName, permissionName);
        if (permissionSet == null)
        {
            throw new ResourceNotFoundException("No permissionSet '" + permissionSetName + "' with permission '"
                    + permissionName + "'");
        }
        if (permission == null)
        {
            throw new ResourceNotFoundException("No permission '" + permissionName + "' under permission set '"
                    + permissionSetName + "'");
        }
        /*
         * Added because Subject field will need user roles defined in user database
         */
        mav.addObject("users", userService.getConfiguredUsers());
        mav.addObject(permission);
        mav.addObject("pageTitle", "Modify Permission");
        mav.addObject("heading", "Modify " + permissionName);
        
        LinkedHashMap<String,String> breadCrumb=new LinkedHashMap<String,String>();
        breadCrumb.put("Manager","/protector-webapp/editor/");
        breadCrumb.put("Permission Set","/protector-webapp/editor/edit/"+permissionSetName);
        breadCrumb.put("Permission","/protector-webapp/editor/edit/"+permissionSetName+"/"+permissionName);
        mav.addObject("breadCrumb",breadCrumb);
        
        return mav;
    }

    /**
     * @param permissionSet
     *        the permission set to be saved
     * @return
     */
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public ModelAndView createPermission(@RequestBody(required = true) PermissionSet permissionSet) {

        PermissionSet result = simplePermissionService.getPermissionSet(permissionSet.getName());
        if (result != null) {
            // TODO already exists ... let GUI ask to edit/override
            throw new BadRequestException("Overriding resources not supported yet.");
        }
        try {
            result = simplePermissionService.savePermissionSet(permissionSet);
        }
        catch (PermissionManagementException e) {
            throw new InternalServerException("Could not create resource.", e);
        }
        ModelAndView mav = new ModelAndView("resultView");
        return mav.addObject(result);
    }

    /**
     * @return
     */
    @RequestMapping(value = "/timeseries", method = RequestMethod.GET, produces = "application/json")
    public ModelAndView listTimeseries()
    {
        ModelAndView mav = new ModelAndView("timeseries");
        IoParameters query = IoParameters.createDefaults();
        mav.addObject("offerings", parameterServiceProvider.getOfferingsService().getCondensedParameters(query));
        mav.addObject("procedures", parameterServiceProvider.getProceduresService().getCondensedParameters(query));
        mav.addObject("featuresOfInterest", parameterServiceProvider.getFeaturesService().getCondensedParameters(query));
        return mav;
    }

    // Getters and setters
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

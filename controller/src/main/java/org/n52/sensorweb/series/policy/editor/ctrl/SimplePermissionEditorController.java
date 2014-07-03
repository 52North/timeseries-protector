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
import javax.servlet.http.HttpServletResponse;

import org.n52.io.IoParameters;
import org.n52.security.service.pdp.simplepermission.Permission;
import org.n52.security.service.pdp.simplepermission.PermissionSet;
import org.n52.sensorweb.series.policy.api.PermissionManagementException;
import org.n52.sensorweb.series.policy.api.beans.PermissionOutput;
import org.n52.sensorweb.series.policy.api.beans.PermissionSetOutput;
import org.n52.sensorweb.series.policy.editor.srv.EnforcementPointService;
import org.n52.sensorweb.series.policy.editor.srv.SimplePermissionService;
import org.n52.sensorweb.series.policy.editor.srv.UserService;
import org.n52.sensorweb.series.policy.editor.srv.impl.ActionValues;
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
public class SimplePermissionEditorController extends BaseController{

	private SimplePermissionService simplePermissionService;

	private EnforcementPointService enforcementPointService;

	private TimeseriesService parameterServiceProvider;

	private UserService userService;

	/**
	 * @return permissionSets to be displayed
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView listPermissions(HttpServletRequest request)
	{
		ModelAndView mav = new ModelAndView("listPermissionSets");
		mav.addObject("permissionSets", simplePermissionService.getPermissionSets());
		mav.addObject("pageTitle", "List Permission Sets");
		mav.addObject("heading", "Timeseries Permission Manager");

		LinkedHashMap<String,String> breadCrumb=new LinkedHashMap<String,String>();

		if(request!=null)
			breadCrumb.put("Manager",request.getContextPath()+"/editor/");

		mav.addObject("breadCrumb",breadCrumb);
		return mav;
	}

	/**
	 * @return The new Create Permission set view
	 */
	@RequestMapping(value = "/new", method = RequestMethod.GET)
	public ModelAndView createPermissions(HttpServletRequest request)
	{
		ModelAndView mav = new ModelAndView("createPermissionSet");
		mav.addObject("pageTitle", "Create Permission Set");
		mav.addObject("heading", "Create Permission Set");

		LinkedHashMap<String,String> breadCrumb=new LinkedHashMap<String,String>();
		/* the ordering of elements maintains a rendering order for bread crumb*/
		breadCrumb.put("Manager",request.getContextPath()+"/editor/");
		breadCrumb.put("Permission Set",request.getContextPath()+"/editor/new");
		mav.addObject("breadCrumb",breadCrumb);

		return mav;
	}

	/**
	 * @return
	 */
	@RequestMapping(value = "/edit/{permissionSet}/newPermission", method = RequestMethod.GET)
	public ModelAndView createPermission(@PathVariable String permissionSet,HttpServletRequest request)
	{
		ModelAndView mav = new ModelAndView("createPermission");

		mav.addObject("users", userService.getConfiguredUsers());
		mav.addObject("pageTitle", "Create Permission");
		mav.addObject("heading", "Create Permission");

		String [] referer=request.getHeader("referer").split("/");

		LinkedHashMap<String,String> breadCrumb=new LinkedHashMap<String,String>();

		/* the ordering of elements maintains a rendering order for bread crumb*/

		breadCrumb.put("Manager",request.getContextPath()+"/editor/");
		if(referer[5].equals("edit"))
		{
			breadCrumb.put("Permission Set",request.getContextPath()+"/editor/edit/"+referer[6]);
		}   
		else
			breadCrumb.put("Permission Set",request.getContextPath()+"/editor/new");

		breadCrumb.put("Permission",request.getContextPath()+"/editor/new");

		mav.addObject("breadCrumb",breadCrumb);

		/*Adding the timeseries parameters now*/
		IoParameters query = IoParameters.createDefaults();
		mav.addObject("offerings", parameterServiceProvider.getOfferingsService().getCondensedParameters(query));
		mav.addObject("procedures", parameterServiceProvider.getProceduresService().getCondensedParameters(query));
		mav.addObject("featuresOfInterest", parameterServiceProvider.getFeaturesService().getCondensedParameters(query));
		mav.addObject("phenomenon", parameterServiceProvider.getPhenomenaService().getCondensedParameters(query));
		mav.addObject("actionValues",ActionValues.getActionValues());

		/* Addded to see whether the user is attempting to save a permission for non-existent permission set*/
		mav.addObject("permissionSet",permissionSet);
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
	public ModelAndView editPermissionSet(@PathVariable String permissionSetName, HttpServletRequest request)
	{
		ModelAndView mav = new ModelAndView("createPermissionSet");
		PermissionSet permissionSet = simplePermissionService.getPermissionSet(permissionSetName);
		if (permissionSet == null)
		{
			throw new ResourceNotFoundException("No permissionSet with name '" + permissionSetName + "'.");
		}

		/*for page titles*/
		mav.addObject(permissionSet);
		mav.addObject("pageTitle", "Modify Permission Set");
		mav.addObject("heading", "Modify " + permissionSetName);

		/*for the breadcrumb*/
		LinkedHashMap<String,String> breadCrumb=new LinkedHashMap<String,String>();
		breadCrumb.put("Manager",request.getContextPath()+"/editor/");
		breadCrumb.put("Permission Set",request.getContextPath()+"/editor/edit/"+permissionSetName);
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
	public ModelAndView editPermission(@PathVariable String permissionSetName, @PathVariable String permissionName, HttpServletRequest request)
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
		/*for page titles*/
		mav.addObject("pageTitle", "Modify Permission");
		mav.addObject("heading", "Modify " + permissionName);

		IoParameters query = IoParameters.createDefaults();
		mav.addObject("offerings", parameterServiceProvider.getOfferingsService().getCondensedParameters(query));
		mav.addObject("procedures", parameterServiceProvider.getProceduresService().getCondensedParameters(query));
		mav.addObject("featuresOfInterest", parameterServiceProvider.getFeaturesService().getCondensedParameters(query));
		mav.addObject("phenomenon", parameterServiceProvider.getPhenomenaService().getCondensedParameters(query));
		mav.addObject("actionValues",ActionValues.getActionValues());

		/*For the breadcrumb*/
		LinkedHashMap<String,String> breadCrumb=new LinkedHashMap<String,String>();
		breadCrumb.put("Manager",request.getContextPath()+"/editor/");
		breadCrumb.put("Permission Set",request.getContextPath()+"/editor/edit/"+permissionSetName);
		breadCrumb.put("Permission",request.getContextPath()+"/editor/edit/"+permissionSetName+"/"+permissionName);
		mav.addObject("breadCrumb",breadCrumb);

		/* Addded to see whether the user is attempting to save a permission for an existent permission set*/
		mav.addObject("permissionSet",permissionSetName);

		return mav;
	}

	/**
	 * @param permissionSet
	 *        the permission set to be saved
	 * @return
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST, consumes = "application/json")
	public ModelAndView savePermissionSet(@RequestBody(required = true) PermissionSetOutput permissionSet,HttpServletResponse response
			,HttpServletRequest request) {

		PermissionSet result = simplePermissionService.getPermissionSet(permissionSet.getName());
		/*if (result != null) {
            // TODO already exists ... let GUI ask to edit/override
            throw new BadRequestException("Overriding resources not supported yet.");
        }*/
		try {
			result = simplePermissionService.savePermissionSet(permissionSet.getPermissionSet());
		}
		catch (PermissionManagementException e) {
			throw new InternalServerException("Could not create resource.", e);
		}
		response.setHeader("Location",request.getContextPath()+"/editor/");
		return null;
	}

	@RequestMapping(value = "/{permissionSet}/save", method = RequestMethod.POST, consumes = "application/json")
	public ModelAndView savePermission(@PathVariable String permissionSet,@RequestBody(required = true) PermissionOutput permission,
			HttpServletRequest request,HttpServletResponse response) {
		try 
		{
			simplePermissionService.addPermission(permissionSet, permission.getPermission());
		} 
		catch (PermissionManagementException e) 
		{
			throw new InternalServerException("Could not create resource.", e);
		}
		response.setHeader("Location",request.getContextPath()+"/editor/edit/"+permissionSet);
		return null;
	}

	/**
	 * @return
	 */
	@RequestMapping(value = "/timeseries", method = RequestMethod.GET)
	public ModelAndView listTimeseries()
	{
		ModelAndView mav = new ModelAndView("timeseries");
		IoParameters query = IoParameters.createDefaults();
		mav.addObject("offerings", parameterServiceProvider.getOfferingsService().getCondensedParameters(query));
		mav.addObject("procedures", parameterServiceProvider.getProceduresService().getCondensedParameters(query));
		mav.addObject("featuresOfInterest", parameterServiceProvider.getFeaturesService().getCondensedParameters(query));
		mav.addObject("phenomenon", parameterServiceProvider.getPhenomenaService().getCondensedParameters(query));
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

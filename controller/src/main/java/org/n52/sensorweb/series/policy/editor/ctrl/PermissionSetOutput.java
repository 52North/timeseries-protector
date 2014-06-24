/**
 * 
 */
package org.n52.sensorweb.series.policy.editor.ctrl;


import java.util.ArrayList;

import org.n52.security.service.pdp.simplepermission.Permission;
import org.n52.security.service.pdp.simplepermission.PermissionSet;

/**
 * @author Dushyant Sabharwal
 * Wrapper Class for the PermissionSet class
 * so as to map the JSON to PermissionSet 
 * since we do not have a default constructor
 */
public class PermissionSetOutput extends PermissionSet {

    private String m_name;
    /**
     * Default Constructor
     */
    public PermissionSetOutput() 
    {
        super("", new ArrayList<String>(),new ArrayList<String>(),new ArrayList<String>(), new ArrayList<Permission>());
        // TODO Auto-generated constructor stub
    }
    public void setName(String name) {
        this.m_name = name;
    }
    
}

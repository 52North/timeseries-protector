/**
 * 
 */
package org.n52.sensorweb.series.policy.editor.ctrl;

import java.util.ArrayList;
import java.util.List;

import org.n52.security.service.pdp.simplepermission.Obligation;
import org.n52.security.service.pdp.simplepermission.Permission;
import org.n52.security.service.pdp.simplepermission.TargetValue;

/**
 * @author Dushyant Sabharwal
 *
 */
public class PermissionOutput extends Permission {

    /**
     * Default Constructor
     */
    public PermissionOutput() 
    {
        super("", new ArrayList<TargetValue>(),new ArrayList<TargetValue>(),new ArrayList<TargetValue>());
        // TODO Auto-generated constructor stub
    }

}

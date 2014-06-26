package org.n52.sensorweb.series.policy.editor.ctrl;

import java.util.List;

import org.n52.security.service.pdp.simplepermission.TargetValue;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

public abstract class MixInPermission {

    @JsonCreator
    public MixInPermission(@JsonProperty("name") String name,@JsonProperty("resources") List<TargetValue> resources,
                           @JsonProperty("actions") List<TargetValue> actions,
                           @JsonProperty("subjects") List<TargetValue> subjects
                            ) {
    };

}

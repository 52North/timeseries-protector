package org.n52.sensorweb.series.policy.editor.ctrl;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

public abstract class MixInTargetValue {

    @JsonCreator
    public MixInTargetValue(@JsonProperty("m_value") String value,
                            @JsonProperty("m_domains") List<String> domains
                            ) {
    };

}

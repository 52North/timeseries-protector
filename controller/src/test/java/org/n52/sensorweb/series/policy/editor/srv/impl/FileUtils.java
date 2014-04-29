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
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.n52.sensorweb.series.policy.editor.srv.impl;

import java.io.File;
import java.io.FileNotFoundException;
import java.net.URISyntaxException;
import java.net.URL;

/**
 *
 * @author Henning Bredel <h.bredel@52north.org>
 */
public class FileUtils {

    public static String getAbsolutePathFor(String path) throws FileNotFoundException {
        return getAbsolutePathFor(path, null);
    }

    public static String getAbsolutePathFor(String path, String name) throws FileNotFoundException {
        URL base = FileUtils.class.getResource(path);
        if (base != null) {
            try {
                File file = new File(base.toURI());
                return name != null
                        ? file.getAbsolutePath() + File.separator + name
                        : file.getAbsolutePath();

            } catch (URISyntaxException e) {
                throw new RuntimeException("Invalid: '" + path + "'.", e);
            }
        }
        throw new FileNotFoundException("Could not find '" + path + "'.");
    }
}

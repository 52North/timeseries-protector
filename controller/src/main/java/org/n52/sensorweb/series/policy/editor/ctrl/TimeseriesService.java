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

package org.n52.sensorweb.series.policy.editor.ctrl;
import org.n52.io.v1.data.CategoryOutput;
import org.n52.io.v1.data.FeatureOutput;
import org.n52.io.v1.data.OfferingOutput;
import org.n52.io.v1.data.PhenomenonOutput;
import org.n52.io.v1.data.ProcedureOutput;
import org.n52.io.v1.data.StationOutput;
import org.n52.io.v1.data.TimeseriesMetadataOutput;
import org.n52.sensorweb.v1.spi.CountingMetadataService;
import org.n52.sensorweb.v1.spi.ParameterService;
import org.n52.sensorweb.v1.spi.SearchService;
import org.n52.sensorweb.v1.spi.ServiceParameterService;
import org.n52.sensorweb.v1.spi.TimeseriesDataService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author Henning Bredel <h.bredel@52north.org>
 */
public class TimeseriesService {

    private static final Logger LOGGER = LoggerFactory.getLogger(TimeseriesService.class);

    private String componentNameToBeProxied;

    private ParameterService<PhenomenonOutput> phenomenonaService;

    private ParameterService<ProcedureOutput> procedureService;

    private ParameterService<CategoryOutput> categoryService;

    private ParameterService<OfferingOutput> offeringService;

    private ParameterService<FeatureOutput> featureService;

    private ParameterService<StationOutput> stationService;

    private ParameterService<TimeseriesMetadataOutput> timeseriesService;

    private TimeseriesDataService timeseriesDataService;

    private CountingMetadataService contingMetadataService;

    private ServiceParameterService servicesService;

    private SearchService searchService;

    public ParameterService<PhenomenonOutput> getPhenomenonaService() {
        return phenomenonaService;
    }

    public void setPhenomenonaService(ParameterService<PhenomenonOutput> phenomenonaService) {
        this.phenomenonaService = phenomenonaService;
    }

    public ParameterService<ProcedureOutput> getProcedureService() {
        return procedureService;
    }

    public void setProcedureService(ParameterService<ProcedureOutput> procedureService) {
        this.procedureService = procedureService;
    }

    public ParameterService<CategoryOutput> getCategoryService() {
        return categoryService;
    }

    public void setCategoryService(ParameterService<CategoryOutput> categoryService) {
        this.categoryService = categoryService;
    }

    public ParameterService<OfferingOutput> getOfferingService() {
        return offeringService;
    }

    public void setOfferingService(ParameterService<OfferingOutput> offeringService) {
        this.offeringService = offeringService;
    }

    public ParameterService<FeatureOutput> getFeatureService() {
        return featureService;
    }

    public void setFeatureService(ParameterService<FeatureOutput> featureService) {
        this.featureService = featureService;
    }

    public ParameterService<StationOutput> getStationService() {
        return stationService;
    }

    public void setStationService(ParameterService<StationOutput> stationService) {
        this.stationService = stationService;
    }

    public CountingMetadataService getContingMetadataService() {
        return contingMetadataService;
    }

    public void setContingMetadataService(CountingMetadataService contingMetadataService) {
        this.contingMetadataService = contingMetadataService;
    }

    public void setTimeseriesService(ParameterService<TimeseriesMetadataOutput> timeseriesService) {
        this.timeseriesService = timeseriesService;
    }

    public void setTimeseriesDataService(TimeseriesDataService timeseriesDataService) {
        this.timeseriesDataService = timeseriesDataService;
    }

    public void setServicesService(ServiceParameterService servicesService) {
        this.servicesService = servicesService;
    }

    public void setSearchService(SearchService searchService) {
        this.searchService = searchService;
    }

    public ParameterService<PhenomenonOutput> getPhenomenaService() {
        if (phenomenonaService == null) {
            LOGGER.warn("No phenomena service configured for '{}'.", componentNameToBeProxied);
        }
        return phenomenonaService;
    }

    public ParameterService<ProcedureOutput> getProceduresService() {
        if (procedureService == null) {
            LOGGER.warn("No procedure service configured for '{}'.", componentNameToBeProxied);
        }
        return procedureService;
    }

    public ParameterService<CategoryOutput> getCategoriesService() {
        if (categoryService == null) {
            LOGGER.warn("No procedure service configured for '{}'.", componentNameToBeProxied);
        }
        return categoryService;
    }

    public ParameterService<OfferingOutput> getOfferingsService() {
        if (offeringService == null) {
            LOGGER.warn("No procedure service configured for '{}'.", componentNameToBeProxied);
        }
        return offeringService;
    }

    public ParameterService<FeatureOutput> getFeaturesService() {
        if (featureService == null) {
            LOGGER.warn("No ParameterService<FeatureOutput> configured for '{}'.", componentNameToBeProxied);
        }
        return featureService;
    }

    public ParameterService<StationOutput> getStationsService() {
        if (stationService == null) {
            LOGGER.warn("No ParameterService<StationOutput configured for '{}'.", componentNameToBeProxied);
        }
        return stationService;
    }

    public ParameterService<TimeseriesMetadataOutput> getTimeseriesService() {
        if (timeseriesService == null) {
            LOGGER.warn("No ParameterService<TimeseriesMetadataOutput> configured for '{}'.", componentNameToBeProxied);
        }
        return timeseriesService;
    }

    public TimeseriesDataService getTimeseriesDataService() {
        if (timeseriesDataService == null) {
            LOGGER.warn("No TimeseriesDataService configured for '{}'.", componentNameToBeProxied);
        }
        return timeseriesDataService;
    }

    public CountingMetadataService getCountingMetadataService() {
        if (contingMetadataService == null) {
            LOGGER.warn("No CountingMetadataService service configured for '{}'.", componentNameToBeProxied);
        }
        return contingMetadataService;
    }

    public ServiceParameterService getServicesService() {
        if (servicesService == null) {
            LOGGER.warn("No ServiceParameterService configured for '{}'.", componentNameToBeProxied);
        }
        return servicesService;
    }

    public SearchService getSearchService() {
        if (searchService == null) {
            LOGGER.warn("No SearchService configured for '{}'.", componentNameToBeProxied);
        }
        return searchService;
    }

}

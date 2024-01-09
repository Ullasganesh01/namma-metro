package com.xworkz.namma_metro.configuration;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class MetroWebInit extends AbstractAnnotationConfigDispatcherServletInitializer {
    protected Class<?>[] getRootConfigClasses() {
        return new Class[]{MetroConfiguration.class};
    }

    protected Class<?>[] getServletConfigClasses() {
        return new Class[]{MetroConfiguration.class};
    }

    protected String[] getServletMappings() {
        return new String[]{"/"};
    }
}

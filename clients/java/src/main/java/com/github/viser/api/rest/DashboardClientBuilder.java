package com.github.viser.api.rest;

import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.WebTarget;

/**
 * Viser dashboard REST client builder based on JAX-RS client.
 */
public class DashboardClientBuilder
{
    private String baseUrl = "http://localhost:3000";
    private String path = "api";
    private String apiVersion = "v1";

    public void setBaseUrl(String baseUrl) {
        this.baseUrl = baseUrl;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public void setApiVersion(String apiVersion) {
        this.apiVersion = apiVersion;
    }

    /**
     * @return ready to use, configured Viser dashboard client
     */
    public DashboardClient build()
    {
        WebTarget target = ClientBuilder
                .newClient()
                .target(baseUrl)
                .path(path + "/" + apiVersion +"/event");

        return new DashboardClient(target);
    }
}

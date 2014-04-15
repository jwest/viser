package com.github.viser.api.rest;

import com.github.viser.api.rest.exception.ResponseException;
import com.github.viser.api.rest.exception.UnknownErrorException;
import com.github.viser.api.rest.request.EventRequest;
import com.github.viser.api.rest.response.EventResponse;

import javax.ws.rs.BadRequestException;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;

/**
 * Simple Viser dashboard REST client.
 */
public class DashboardClient
{
    private WebTarget webTarget;

    public DashboardClient(WebTarget webTarget)
    {
        this.webTarget = webTarget;
    }

    /**
     * Triggers an event with default empty ID in Viser dashboard.
     *
     * @param source start of an event
     * @param target end of an event
     *
     * @throws com.github.viser.api.rest.exception.ResponseException
     * @throws com.github.viser.api.rest.exception.UnknownErrorException
     */
    public void event(String source, String target)
    {
        event("", source, target);
    }

    /**
     * Triggers an event in Viser dashboard.
     *
     * @param id     client ID
     * @param source start of an event
     * @param target end of an event
     *
     * @throws com.github.viser.api.rest.exception.ResponseException
     * @throws com.github.viser.api.rest.exception.UnknownErrorException
     */
    public void event(String id, String source, String target)
    {
        try {
            webTarget
                    .request(MediaType.APPLICATION_JSON_TYPE)
                    .post(createEventRequestEntity(id, source, target), EventResponse.class);
        } catch (BadRequestException e) {
            throw new ResponseException();
        } catch (Exception e) {
            throw new UnknownErrorException();
        }
    }

    public Entity<EventRequest> createEventRequestEntity(String id, String source, String target)
    {
        return Entity.json(new EventRequest(id, source, target));
    }
}

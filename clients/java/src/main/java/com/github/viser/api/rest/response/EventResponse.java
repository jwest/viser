package com.github.viser.api.rest.response;

/**
 * Viser dashboard event response entity.
 */
public class EventResponse
{
    private String status;

    public EventResponse()
    {
    }

    public EventResponse(String status)
    {
        this.status = status;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }
}

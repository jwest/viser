package com.github.viser.api.rest.request;

/**
 * Viser dashboard event request entity.
 */
public class EventRequest
{
    private final String source;
    private final String target;

    public EventRequest(String source, String target)
    {
        this.source = source;
        this.target = target;
    }

    public String getSource()
    {
        return source;
    }

    public String getTarget()
    {
        return target;
    }
}

package com.github.viser.api.rest.request;

/**
 * Viser dashboard event request entity.
 */
public class EventRequest
{
    private final String id;
    private final String source;
    private final String target;

    public EventRequest(String id, String source, String target)
    {
        this.id = id;
        this.source = source;
        this.target = target;
    }

    public String getId()
    {
        return id;
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

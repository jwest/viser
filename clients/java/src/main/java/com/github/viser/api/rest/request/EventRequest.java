package com.github.viser.api.rest.request;

/**
 * Viser dashboard event request entity.
 */
public class EventRequest
{
    private String source;
    private String target;

    public EventRequest()
    {
    }

    public EventRequest(String source, String target)
    {
        this.source = source;
        this.target = target;
    }

    public String getSource()
    {
        return source;
    }

    public void setSource(String source)
    {
        this.source = source;
    }

    public String getTarget()
    {
        return target;
    }

    public void setTarget(String target)
    {
        this.target = target;
    }
}

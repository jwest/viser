package com.github.viser.api.rest;

import com.github.viser.api.rest.exception.ResponseException;
import com.github.viser.api.rest.exception.UnknownErrorException;
import com.github.viser.api.rest.request.EventRequest;
import com.github.viser.api.rest.response.EventResponse;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import javax.ws.rs.BadRequestException;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.Invocation;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;

import static org.mockito.Mockito.*;

public class DashboardClientTest
{
    @Mock private WebTarget target;
    @Mock private Invocation.Builder builder;
    @Mock private EventRequest eventRequest;
    private Entity<EventRequest> eventRequestEntity;
    private DashboardClient client;

    @Before
    public void setUp()
    {
        MockitoAnnotations.initMocks(this);
        eventRequestEntity = Entity.json(eventRequest);
        client = spy(new DashboardClient(target));
    }

    @Test
    public void shouldTriggerDashboardEvent()
    {
        when(target.request(MediaType.APPLICATION_JSON_TYPE))
                .thenReturn(builder);
        when(client.createEventRequestEntity(eq("client id"), eq("source"), eq("target")))
                .thenReturn(eventRequestEntity);

        client.event("client id", "source", "target");

        verify(builder).post(eventRequestEntity, EventResponse.class);
    }

    @Test
    public void shouldTriggerDashboardEventWithEmptyId()
    {
        when(target.request(MediaType.APPLICATION_JSON_TYPE))
                .thenReturn(builder);
        when(client.createEventRequestEntity(eq(""), eq("source"), eq("target")))
                .thenReturn(eventRequestEntity);

        client.event("source", "target");

        verify(builder).post(eventRequestEntity, EventResponse.class);
    }

    @Test(expected = ResponseException.class)
    public void shouldThrowResponseExceptionOnBadRequest()
    {
        when(target.request(MediaType.APPLICATION_JSON_TYPE))
                .thenReturn(builder);
        when(client.createEventRequestEntity(eq("client id"), eq("source"), eq("target")))
                .thenReturn(eventRequestEntity);
        when(builder.post(eventRequestEntity, EventResponse.class))
                .thenThrow(BadRequestException.class);

        client.event("client id", "source", "target");
    }

    @Test(expected = UnknownErrorException.class)
    public void shouldThrowUnknownErrorExceptionOnUnrecognizedException()
    {
        when(target.request(MediaType.APPLICATION_JSON_TYPE))
                .thenReturn(builder);
        when(client.createEventRequestEntity(eq("client id"), eq("source"), eq("target")))
                .thenReturn(eventRequestEntity);
        when(builder.post(eventRequestEntity, EventResponse.class))
                .thenThrow(RuntimeException.class);

        client.event("client id", "source", "target");
    }
}

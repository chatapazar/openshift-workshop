package org.acme;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

import jakarta.ws.rs.core.Response;


@Path("/status")
public class GreetingResource {

    @GET
    @Path("/200")
    public Response hello200() {
        return Response.status(200).build(); 
    }



    @GET
    @Path("/400")
    public Response hello400() {
        return Response.status(400).build(); 
    }
}

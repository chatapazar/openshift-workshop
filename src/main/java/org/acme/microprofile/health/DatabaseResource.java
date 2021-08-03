package org.acme.microprofile.health;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import org.jboss.logging.Logger;

@Path("/databasestatus")
public class DatabaseResource {
    
    @Inject
    DataBaseStatusBean dbstatus;

    @GET
    @Produces(MediaType.TEXT_PLAIN)
    @Path("/down")
    public String down() {
        dbstatus.setDatabaseUp(false);
        return "DOWN";
    }

    @GET
    @Produces(MediaType.TEXT_PLAIN)
    @Path("/up")
    public String up() {
        dbstatus.setDatabaseUp(true);
        return "UP";
    }
}

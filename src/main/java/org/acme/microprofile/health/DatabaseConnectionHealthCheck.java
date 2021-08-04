package org.acme.microprofile.health;

//import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.eclipse.microprofile.health.HealthCheck;
import org.eclipse.microprofile.health.HealthCheckResponse;
import org.eclipse.microprofile.health.HealthCheckResponseBuilder;
import org.eclipse.microprofile.health.Readiness;

import javax.enterprise.context.ApplicationScoped;
//import javax.xml.crypto.Data;
import javax.inject.Inject;
//import org.jboss.logging.Logger;

@Readiness
@ApplicationScoped
public class DatabaseConnectionHealthCheck implements HealthCheck {

    //@ConfigProperty(name = "database.up", defaultValue = "false")
    //private boolean databaseUp;
    @Inject
    DataBaseStatusBean dbstatus;

    @Override
    public HealthCheckResponse call() {

        HealthCheckResponseBuilder responseBuilder = HealthCheckResponse.named("Database connection health check");

        try {
            simulateDatabaseConnectionVerification();
            responseBuilder.up();
        } catch (IllegalStateException e) {
            // cannot access the database
            responseBuilder.down();
        }

        return responseBuilder.build();
    }

    private void simulateDatabaseConnectionVerification() {
        if (!dbstatus.getDatabaseUp()) {
            throw new IllegalStateException("Cannot contact database");
        }
    }
}
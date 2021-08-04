package org.acme.microprofile.health;

import org.eclipse.microprofile.health.HealthCheck;
import org.eclipse.microprofile.health.HealthCheckResponse;
import org.eclipse.microprofile.health.HealthCheckResponseBuilder;
import org.eclipse.microprofile.health.Liveness;

import javax.enterprise.context.ApplicationScoped;
import org.acme.getting.started.ApplicationConfig;

@Liveness
@ApplicationScoped  
public class SimpleHealthCheck implements HealthCheck {

    @Override
    public HealthCheckResponse call() {
        HealthCheckResponseBuilder responseBuilder = HealthCheckResponse.named("Sample Live health check");
        if (ApplicationConfig.IS_ALIVE.get()){
            responseBuilder.up();
        }else{
            responseBuilder.down();
        }
        return responseBuilder.build();
    }


}
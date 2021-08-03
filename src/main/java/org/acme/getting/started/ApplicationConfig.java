package org.acme.getting.started;

import java.util.concurrent.atomic.AtomicBoolean;

//import javax.ws.rs.ApplicationPath;

import javax.ws.rs.core.Application;


public class ApplicationConfig extends Application {
    public static final AtomicBoolean IS_ALIVE = new AtomicBoolean(true);
    public static final AtomicBoolean IS_READY = new AtomicBoolean(true);
}

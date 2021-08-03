package org.acme.microprofile.health;

import javax.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class DataBaseStatusBean {
    private boolean databaseUp = true;

    public void setDatabaseUp(boolean value){
        databaseUp = value;
    }

    public boolean getDatabaseUp(){
        return databaseUp;
    }
}

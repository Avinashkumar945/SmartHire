package com.smartHire.config;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

/**
 * Application Lifecycle Listener implementation class AppInitializer
 *
 */
@WebListener
public class AppInitializer implements ServletContextListener {

    /**
     * Default constructor. 
     */
    public AppInitializer() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent sce)  { 
         // TODO Auto-generated method stub
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent sce)  { 
    	System.out.println("[SmartHire] Application starting...");
        DBConnectionPool.initilize();
        System.out.println("[SmartHire] Application ready.");
    	 
    	 
    }
	
}

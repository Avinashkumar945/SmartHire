package com.smartHire.config;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DBConnectionPool {
    private static DataSource dataSource;
    
    private DBConnectionPool(){
    	
    }
    
    public static void initilize() {
    	  try {
			Context context = new InitialContext();
			System.out.println("DataSource initialized successfully");
			dataSource=(DataSource)context.lookup("java:comp/env/jdbc/smarthire_db");
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			System.out.println("failed to initilised connection pool");
			e.printStackTrace();
		}
    }
    
    public static Connection getConnection() throws SQLException {
        if (dataSource == null) {
            throw new SQLException(
                "[SmartHire] DataSource is not initialized. " +
                "Call initialize() first."
            );
        }
        System.out.println("DataSource is succefully connected");
        return dataSource.getConnection();
    }
}

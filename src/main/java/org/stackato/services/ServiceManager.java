package org.stackato.services;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import argo.jdom.JdomParser;
import argo.jdom.JsonNode;
import argo.jdom.JsonRootNode;

public enum ServiceManager implements StackatoServices {

    INSTANCE;

    private static final String NULL_STRING = "";

    public Object getInstance(int service_type) throws Exception {
        if (service_type == MYSQL)
        {
            return getMySQLConnection();
        }
        else
        {
            throw new IllegalArgumentException("Service for id " + service_type + " not found...");
        }
    }
    
    /*
    * This method is responsible for establishing a valid connection to the MySQL service,
    * using the credentials available in the environment variable, namely "VCAP_SERVICES".
    *
    * The content of VCAP_SERVICES environment variable is a JSON string, thus this method
    * uses standard interfaces from the Argo JSON parsing API to extract the credentials.
    */
    
    private Object getMySQLConnection() throws SQLException {
        
        String vcap_services = System.getenv("VCAP_SERVICES");
        
        String hostname = NULL_STRING;
        String dbname = NULL_STRING;
        String user = NULL_STRING;
        String password = NULL_STRING;
        String port = NULL_STRING;
        
        if (vcap_services != null && vcap_services.length() > 0) {
            try
            {
                JsonRootNode root = new JdomParser().parse(vcap_services);
                
                JsonNode mysqlNode = root.getNode("mysql");
                JsonNode credentials = mysqlNode.getNode(0).getNode("credentials");
                
                dbname = credentials.getStringValue("name");
                hostname = credentials.getStringValue("hostname");
                user = credentials.getStringValue("user");
                password = credentials.getStringValue("password");
                port = credentials.getNumberValue("port");
                
                String dbUrl = "jdbc:mysql://" + hostname + ":" + port + "/" + dbname;
                
                Class.forName("com.mysql.jdbc.Driver");
                Connection connection = DriverManager.getConnection(dbUrl, user, password);
                return connection;
                
            }
                catch (Exception e)
            {
                throw new SQLException(e);
            }
        }
            return null;
        }
}

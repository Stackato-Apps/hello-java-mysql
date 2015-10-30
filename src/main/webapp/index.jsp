<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@page import="java.sql.*,javax.sql.*"%><%@page import="org.stackato.services.*"%><%
String query = "Select * FROM users";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=us-ascii">

    <title>HPE Helion Stackato with Simple Java</title>
</head>

<body>
    Welcome to the simple web application on HPE Helion Stackato...
    
    <%
    Connection connection = null;

    try {
        // establish connection to MySQL Service
        ServiceManager services = ServiceManager.INSTANCE;
        connection = (Connection) services.getInstance(StackatoServices.MYSQL);

        if (connection != null && !connection.isClosed()) {
            out.println("<p>Successfully connected to MySQL service</p>");

            // creating a database table and populating some values
            Statement s = connection.createStatement();
            int count;
            s.executeUpdate("DROP TABLE IF EXISTS animal");
            s.executeUpdate("CREATE TABLE animal (" + "id INT UNSIGNED NOT NULL AUTO_INCREMENT," + "PRIMARY KEY (id)," + "name CHAR(40), category CHAR(40))");

            out.println("<p>[1] Table successfully created.</p>");

            count = s.executeUpdate("INSERT INTO animal (name, category)" + " VALUES" + "('snake', 'reptile')," + "('frog', 'amphibian')," + "('tuna', 'fish')," + "('racoon', 'mammal')");

            out.println("<p>[2] " + count + " rows were inserted.</p>");

            count = 0;
            ResultSet rs = s.executeQuery("select * from animal");
            while (rs.next()) {
                count++;
            }
            out.println("<p>[3] " + count + " rows were fetched.</p>");

            s.close();
        }
    } catch (Exception e) {
        out.println(e.getMessage());
    } finally {
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }

        connection = null;
    }
    %>
</body>
</html>

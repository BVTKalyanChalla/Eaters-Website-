<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // Retrieve the submitted form data
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    // Database connection details
    String jdbcURL = "jdbc:oracle:thin:@localhost:1521:xe";
    String dbUser = "username";
    String dbPassword = "password";
    
    // Create a connection to the database
    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","system");
        
        // Prepare a SQL statement to check the credentials
        String sql = "SELECT * FROM login WHERE username=? AND password=?";
        statement = connection.prepareStatement(sql);
        statement.setString(1, username);
        statement.setString(2, password);
        
        // Execute the query
        resultSet = statement.executeQuery();
        
        // Check if the user exists
        if (resultSet.next()) {
            // User is authenticated, redirect to a success page
            response.sendRedirect("home.html");
        } else {
            // User authentication failed, redirect back to the login page
            response.sendRedirect("signin.html");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close the database resources
        if (resultSet != null) {
            resultSet.close();
        }
        if (statement != null) {
            statement.close();
        }
        if (connection != null) {
            connection.close();
        }
    }
%>

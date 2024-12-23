<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    // Get the form inputs
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String pincode = request.getParameter("pincode");
    String address = request.getParameter("address");

    // JDBC driver and database URL
    String jdbcDriver = "oracle.jdbc.driver.OracleDriver";
    String dbUrl = "jdbc:oracle:thin:@localhost:1521:xe";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Register JDBC driver
        Class.forName("oracle.jdbc.driver.OracleDriver");

        // Open a connection
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","system");

        // Prepare SQL statement to insert data
        String sql = "INSERT INTO login (name, email, password, pincode, address) VALUES (?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);

        // Set the parameter values
        pstmt.setString(1, name);
        pstmt.setString(2, email);
        pstmt.setString(3, password);
        pstmt.setString(4, pincode);
        pstmt.setString(5, address);

        // Execute the query
        pstmt.executeUpdate();

        // Close the statement and connection
        pstmt.close();
        conn.close();

        // Redirect to a success page
        response.sendRedirect("login.html");
    } catch (SQLException se) {
        se.printStackTrace();
        // Handle any errors here
        response.sendRedirect("signup.html");
    } catch (Exception e) {
        e.printStackTrace();
        // Handle any errors here
        response.sendRedirect("signup.html");
    } finally {
        // Close resources in finally block to ensure they get closed even if an exception occurs
        try {
            if (pstmt != null)
                pstmt.close();
        } catch (SQLException se2) {
        }
        try {
            if (conn != null)
                conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
%>

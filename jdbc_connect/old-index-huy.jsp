<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> <html>
<head>
<title>JDBC Connection example</title> </head>
<body>
<h1>JDBC Connection example</h1> <%
           try {
               //or root
               String db = "feedmeup";
              Class.forName("com.mysql.cj.jdbc.Driver");
               Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db,"root","root");
               out.println (db+ " database successfully opened.");
               Statement stmt=con.createStatement();
               ResultSet rs=stmt.executeQuery("select * from feedmeup.recipes");
               out.println("hello");
               while(rs.next()){
                out.println("<br>" + rs.getInt(1)+" "+rs.getString(2)+" "+rs.getString(3));
              }
               con.close();
               }
               catch (SQLException e) {
               out.println("SQLException caught: "+e.getMessage());
           }
%> </body> </html>

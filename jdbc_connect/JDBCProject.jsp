<%@ page import="java.sql.*"%>
<html>
  <head>
    <title>JDBC Connection</title>
  </head>
  <body>
    <h1>JDBC Example Project Connection</h1>
    <table border="1">
      <tr>
        <td>User ID</td>
        <td>Username</td>
        <td>Password</td>
      </tr>
    <% 
        String db = "FeedMeUp";
        String user = "root";
        String password = "root";
        try {
            java.sql.Connection con; 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FeedMeUp?autoReconnect=true&useSSL=false", user, password);
            out.println(db + " database successfully opened.<br/><br/>");
            out.println("Initial entries in table \"Users\": <br/>");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM Users");
            while (rs.next()) {
                out.println(rs.getInt(1) + " " + rs.getString(2) + " " + rs.getString(3) + "<br/><br/>");
		%>
                <tr>
                    <td><%=rs.getInt(1) %></td>
                    <td><%=rs.getString(2) %></td>
                    <td><%=rs.getString(3) %></td>
                </tr>
            	<%
            }
            rs.close();
            stmt.close();
            con.close();
        } catch(SQLException e) { 
            out.println("SQLException caught: " + e.getMessage()); 
        }
    %>
	</table>
  </body>
</html>

<%@ page import="java.sql.*"%>
<html>
  <head>
    <title>JDBC Connection example</title>
  </head>
  <body>
    <h1>JDBC Connection example</h1>
    <table border="1">
      <tr>
        <td>ID</td>
        <td>Name</td>
        <td>Age</td>
      </tr>
    <% 
        String db = "name";
        String user = "root";
        String password = "root";
        try {
            java.sql.Connection con; 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/name?autoReconnect=true&useSSL=false", user, password);
            out.println(db + " database successfully opened.<br/><br/>");
            out.println("Initial entries in table \"table\": <br/>");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM table");
            while (rs.next()) {
                out.println(rs.getInt(1) + " " + rs.getString(2) + " " + rs.getString(3) + "<br/><br/>");
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

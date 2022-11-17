<!-- Code reference: https://www.w3schools.com/css/css_navbar_horizontal.asp -->

<%@ page import="java.sql.*" %>

<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
      body {
        font-family: Arial, Helvetica, sans-serif;
        background-color: rgb(237, 198, 123);
      }

      * {
        box-sizing: border-box;
      }

      h1 {
        text-align: center;
      }

      .container {
        padding: 25px;
        width: 500px;
        height: 500px;
        margin: auto;
        top: 50%;
        transform: translate(0, 22.5%);
        background-color: white;
      }

      ul {
        list-style-type: none;
        margin: 0;
        padding: 0;
        overflow: hidden;
        background-color: #333;
      }

      li {
        float: left;
      }

      li a {
        display: block;
        color: white;
        text-align: center;
        padding: 14px 16px;
        text-decoration: none;
      }

      li a:hover:not(.active) {
        background-color: #111;
      }

      .active {
        background-color: rgb(255, 80, 80);
      }

      .message {
        position: fixed;
        left: 50%;
        bottom: 20px;
        transform: translate(-50%, -50%);
        margin: 0 auto;
      }
    </style>
  </head>

  <body>
    <ul>
      <li><a class="active" href="admin_home.jsp">Home</a></li>
      <li><a href="">Users</a></li>
      <li><a href="">Categories</a></li>
      <li style="float:right"><a href="login.jsp">Log out</a></li>
    </ul>
    <div class="container">
      <h1>Reported Users</h1>

      <table style="width:50%">
      <% 
      String db="FeedMeUp"; 
      String un="root"; 
      String pw="root"; 
      try { 
        java.sql.Connection con;
        Class.forName("com.mysql.jdbc.Driver");
        con=DriverManager.getConnection("jdbc:mysql://localhost:3306/FeedMeUp?autoReconnect=true&useSSL=false", un, pw); 
        Statement stmt=con.createStatement(); 
        ResultSet rs=stmt.executeQuery("SELECT DISTINCT reported_user_id, username FROM report JOIN Users ON reported_user_id=user_id"); 
        while (rs.next()) { %>
          <tr>
            <td><input type='text' style='border: 0' value='<%=rs.getString(2)%>' /></td>
            <td>
              <form action="admin_home.jsp" method="POST" style="padding-top: 5px">
                <input type="hidden" name="user" value="<%=rs.getString(2)%>" />
                <input type="submit" name="submit" value="Monitor" />
              </form>
          </tr>
      <% } %>
      </table>
      <% 
        rs.close(); 
        String x=request.getParameter("submit"); 
        if(x!=null && x.equals("Monitor")) { 
          int admin_id = 10;
          String username=request.getParameter("user"); 
          String query=String.format("UPDATE General_Users SET checked_by=%d WHERE user_id=(SELECT user_id FROM Users WHERE username='%s' )", admin_id, username); 
          int rows=stmt.executeUpdate(query); 
          if(rows !=0) { %>
            <div class="message">
              <p>Monitor Updated</p>
            </div>
          <% } else { %>
            <div class="message">
              <p>Monitor unable to Update</p>
            </div>
          <% } 
        } 
        stmt.close(); 
        con.close(); 
      } 
      catch(SQLException e) { 
        out.println("SQLException caught: " + e.getMessage()); 
      }
    %>
  </body>
</html>
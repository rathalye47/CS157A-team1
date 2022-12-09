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
        height: auto;
        margin: auto;
        top: 50%;
        transform: translate(0, 22.5%);
        background-color: white;
      }

      .remove_button {
        background-color: #04AA6D;
        color: white;
        padding: 8px 8px;
        margin: 8px ;
        border: none;
        cursor: pointer;
      }

      .remove_button:hover {
        opacity: 10;
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
        background-color: #04AA6D;
      }

      .name:disabled {
        background: white;
        color: black;
      }

      .view {
        background: none!important;
        border: none;
        padding: 0!important;
        color: black;
        cursor: pointer;
        margin-right:60px;
      }

      .view:hover {
        color:blue;
      }

    </style>
  </head>

  <body>
    <ul>
      <li><a href="admin_home.jsp">Home</a></li>
      <li><a class="active" href="admin_users.jsp">Users</a></li>
      <li><a href="admin_category.jsp">Categories</a></li>
      <li style="float:right"><a href="login.jsp">Log out</a></li>
    </ul>
    <div class="container">
      <h1>Monitored Users</h1>

      <table style="width:50%; margin:auto;">
      <% 
      int admin_id=(int)session.getAttribute("admin_id"); 
      String db="FeedMeUp"; 
      String un="root"; 
      String pw="root"; 
      try { 
        java.sql.Connection con;
        Class.forName("com.mysql.jdbc.Driver");
        con=DriverManager.getConnection("jdbc:mysql://localhost:3306/FeedMeUp?autoReconnect=true&useSSL=false", un, pw); 
        Statement stmt=con.createStatement(); 
        String query = String.format("SELECT General_Users.user_id, username FROM General_Users NATURAL JOIN Users WHERE checked_by = %d", admin_id); 
        ResultSet rs=stmt.executeQuery(query);
        // create link to direct to users videos to check
        while (rs.next()) { %>
          <tr>
            <td>
              <form action="admin_users.jsp" method="POST">
              <input type="hidden" name="user-num" value="<%=rs.getInt(1)%>" />
              <input type="submit" name="view_user" class="view" value="<%=rs.getString(2)%>" />
            </form>
            </td>
            <td>
              <form action="admin_users.jsp" method="POST" style="padding-top: 5px">
                <input type="hidden" name="user" value="<%=rs.getInt(1)%>" />
                <input type="submit" name="submit" class="remove_button" value="Remove" />
              </form>
          </tr>
      <% } %>
      </table>
      <% 
        rs.close(); 
        // view user link
        if(request.getParameter("view_user") !=null){ 
          int user=Integer.parseInt(request.getParameter("user-num"));
          session.setAttribute("view_user", user);
          response.sendRedirect("admin_user_info.jsp");
          return;
        }

        String x=request.getParameter("submit"); 
        if(x!=null && x.equals("Remove")) { 
          int user_id=Integer.parseInt(request.getParameter("user")); 
          String query1=String.format("DELETE FROM General_Users WHERE user_id=%d", user_id); 
          String query2=String.format("DELETE FROM Users WHERE user_id=%d", user_id); 
          int rows=stmt.executeUpdate(query1); 
          int rows1=stmt.executeUpdate(query2); 
          // refresh the page here
          if(rows !=0 && rows1 !=0) {
            response.sendRedirect("admin_users.jsp");
          } else { %>
            <script type="text/javascript">
              alert("Couldn't remove general user");
            </script>
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
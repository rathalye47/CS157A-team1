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

      .back_button {
        background-color: #04AA6D;
        color: white;
        padding: 8px 8px;
        margin: 8px ;
        text-align: center;
        text-decoration: none;
        display: inline-block;
      }

      .active {
        background-color: #04AA6D;
      }

      .message {
        position: fixed;
        left: 50%;
        bottom: 20px;
        transform: translate(-50%, -50%);
        margin: 0 auto;
      }

      .name:disabled {
        background: white;
        color: black;
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
      <a href="admin_users.jsp" class="back_button">< Back</a>
      <h1>User Videos</h1>

      <table style="width:50%; margin:auto;">
      <% 
      int admin_id=(int)session.getAttribute("admin_id"); 
      String db="FeedMeUp"; 
      int user=(int)session.getAttribute("view_user"); 
      String un="root"; 
      String pw="root"; 
      try { 
        java.sql.Connection con;
        Class.forName("com.mysql.jdbc.Driver");
        con=DriverManager.getConnection("jdbc:mysql://localhost:3306/FeedMeUp?autoReconnect=true&useSSL=false", un, pw); 
        Statement stmt=con.createStatement(); 
        String query = String.format("SELECT * FROM Videos WHERE user_id=%d", user); 
        ResultSet rs=stmt.executeQuery(query);
        // create link to direct to users videos to check
        while (rs.next()) { %>
          <tr>
            <td>
              <div class="videos-list"><%
                String title = rs.getString("title");
                String videoPath = "videos/" + rs.getString("file_path");
                %>
                <div class="card m-md-4">
                  <video id="myVideo" width="420" height="345" controls="controls">
                  <source src="<%=videoPath%>" type="video/mp4" /> </video>
                  <div class="card-body">
                    <h5 class="card-title"><%=title %></h5>
                  </div>
                  <form action="admin_user_info.jsp" method="POST" style="padding-top: 5px">
                  <input type="hidden" name="video" value='<%=rs.getInt("video_id")%>' />
                  <input type="submit" name="submit" class="remove_button" value="Remove" />
                </form>
              </div>
            </td>
          </tr>
      <% } %>
      </table>
      <% 
        rs.close(); 
        String x=request.getParameter("submit"); 
        if(x!=null && x.equals("Remove")) { 
          int video_id=Integer.parseInt(request.getParameter("video")); 
          String query1=String.format("DELETE FROM Videos WHERE video_id=%d", video_id);  
          int rows=stmt.executeUpdate(query1); 
          // refresh the page here
          if(rows !=0) {
            response.sendRedirect("admin_user_info.jsp");
          }
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
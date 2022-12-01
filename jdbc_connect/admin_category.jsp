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
        width: 600px;
        height: auto;
        margin: auto;
        margin-top: 5%;
        background-color: white;
      }

      input[type=text] {
        padding: 15px;
        margin: 5px 0 22px 0;
        display: inline-block;
        border: none;
        background: #f1f1f1;
      }

      input[type=text]:focus {
        background-color: #ddd;
        outline: none;
      }

      .add_button, .del_button {
        background-color: #04AA6D;
        color: white;
        padding: 8px 8px;
        margin: 8px ;
        border: none;
        cursor: pointer;
      }

      .add_button:hover, .del_button:hover {
        opacity: 1;
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
    </style>
  </head>

  <body>
    <ul>
      <li><a href="admin_home.jsp">Home</a></li>
      <li><a href="admin_users.jsp">Users</a></li>
      <li><a class="active" href="admin_category.jsp">Categories</a></li>
      <li style="float:right"><a href="login.jsp">Log out</a></li>
    </ul>
    <div class="container">
      <h1>Add a New Category</h1>
      <form method = 'post' action="admin_category.jsp">
        <table style='margin:auto'>
          <tr>
            <td><input type="text" placeholder="Create New Category" name="new_category" id="new_category" required><br></td>
            <td><input type="submit" name="add_submit" class="add_button" value="Add Category" /></td>
          </tr>
        </table>
      </form>
      <h1>Existing Food Categories</h1>
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
        ResultSet rs=stmt.executeQuery("SELECT category_id, category_name FROM Categories");
        // create link to direct to users videos to check
        while (rs.next()) { %>
          <tr>
            <td><input type='text' style='border: 0' value='<%=rs.getString(2)%>' class='name' disabled/></td>
            <td>
              <form action="admin_category.jsp" method="POST" style="padding-top: 5px">
                <input type="hidden" name="category" value="<%=rs.getInt(1)%>" />
                <input type="submit" name="del_submit" class="del_button" value="Delete" />
              </form>
          </tr>
      <% } %>
      </table>
      <% 
        rs.close(); 
        String x=request.getParameter("del_submit"); 
        if(x!=null && x.equals("Delete")) { 
          int cat_id=Integer.parseInt(request.getParameter("category")); 
          String query=String.format("DELETE FROM Categories WHERE category_id=%d", cat_id); 
          int rows=stmt.executeUpdate(query); 
          // refresh the page here
          if(rows !=0) { 
            response.sendRedirect("admin_category.jsp"); 
          } else { %>
            <script type="text/javascript">
                alert("Couldn't Delete Category");
            </script>
          <% } 
        } 

        int category_id = 0;
        String y=request.getParameter("add_submit"); 
        if(y!=null && y.equals("Add Category") && request.getParameter("new_category") != null) { 
          String cat=request.getParameter("new_category");
          String query0=String.format("SELECT category_name FROM Categories WHERE category_name='%s'", cat);  
          ResultSet rs0 = stmt.executeQuery(query0);
          boolean status=rs0.next();
          if(status == true) { 
              %> <script type="text/javascript">
                  alert("Duplicate Category");
                </script> 
              <% 
          } else {
            ResultSet rs1 = stmt.executeQuery("SELECT COUNT(*) FROM Categories");
            while (rs1.next()) {
              category_id = rs1.getInt(1);
            }
            String query1 = String.format("INSERT INTO Categories VALUES('%d', '%s', '%d')", category_id, cat, admin_id);
            int rows1 = stmt.executeUpdate(query1);
            if(rows1 != 0) { 
              response.sendRedirect("admin_category.jsp");
            } else { 
              %>
                <script type="text/javascript">
                  alert("Addition Unsuccessful");
                </script>
              <%
            }
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

<!-- Code reference: https://www.w3schools.com/howto/howto_css_register_form.asp -->
<!-- Code reference: https://www.w3schools.com/howto/howto_css_contact_form.asp -->

<%@ page import="java.sql.*"%>

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
  width: 700px;
  height: 1250px;
  margin: auto;
  top: 50%;
  transform: translate(0, 0%);
  background-color: white;
}

input[type=text], select, textarea {
  width: 50%;
  padding: 15px;
  margin: 5px 0 22px 0;
  display: inline-block;
  border: none;
  background: #f1f1f1;
  resize: none;
}

input[type=text]:focus, textarea:focus {
  background-color: #ddd;
  outline: none;
}

hr {
  border: 1px solid #f1f1f1;
  margin-bottom: 25px;
}

.recipebutton {
  background-color: #04AA6D;
  color: white;
  padding: 16px 20px;
  margin: 8px 245;
  border: none;
  cursor: pointer;
  width: 25%;
}

.recipebutton:hover {
  opacity: 1;
}

.message {
  position: fixed;
  top: 10px;
  left: 435px;
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

</style>
</head>

<body>
  <div class="container">
    <%
    if(((String)session.getAttribute("prev_page")).equals("user")) {%>
          <a href="user_info.jsp" class="back_button">< Back</a>
       <% } else if (((String)session.getAttribute("prev_page")).equals("vid")) {%>
          <a href="videos.jsp" class="back_button">< Back</a>
        <%}%>
    <h1>Recipe Details</h1>
    <table style="width:50%; margin:auto;">

    <%
    int video_id=(int)session.getAttribute("view_recipe"); 
    String db = "FeedMeUp";
    String un = "root";
    String pw = "root";

    try {
      java.sql.Connection con; 
      Class.forName("com.mysql.jdbc.Driver");
      con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FeedMeUp?autoReconnect=true&useSSL=false", un, pw);

      Statement stmt = con.createStatement();
      String query = String.format("SELECT * FROM Recipes WHERE recipe_id IN (SELECT recipe_id FROM Videos WHERE video_id=%d)", video_id);
      ResultSet rs = stmt.executeQuery(query);
      while (rs.next()) { %>
        <tr>
            <td>
              <%=rs.getString(2)%>
            </td>
            <td></td>
        </tr>
        <tr>
            <td>
              <%=rs.getString("cuisine")%>
            </td>
            <td></td>
        </tr>
        <tr>
          <td>
              <%=rs.getInt("time")%>
            </td>
            <td>
              <%=rs.getInt("cost")%>
            </td>
        </tr>
        <tr>
           <td>
              <%=rs.getString("ingredients")%>
            </td>
            <td></td> 
        </tr>
        <tr>
           <td>
              <%=rs.getString("steps")%>
            </td>
            <td></td> 
        </tr>
     <% }

      stmt.close();
      con.close();
    }

    catch(SQLException e) {
      out.println("SQLException caught: " + e.getMessage());
    }

    %>
    </table>
    <br>
</body>
</html>

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
  height: 1400px;
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

.back_button {
  background-color: #04AA6D;
  color: white;
  padding: 8px 8px;
  margin: 8px ;
  text-align: center;
  text-decoration: none;
  display: inline-block;
}

.message {
  position: fixed;
  top: 10px;
  left: 435px;
}

</style>
</head>

<body>
<form method = 'post' action="recipe.jsp">
  <div class="container">
    <a href="videos.jsp" class="back_button">< Back</a>

    <% if ((int)session.getAttribute("update_recipe") != 0) {%>
      <h1>Update Recipe</h1>
    <%}else {%>
      <h1>Upload Recipe</h1>
    <%}%>
    <p>Please enter the details of your recipe below.</p>

    <hr style="text-align:left;margin-left:0">

    <label for="recipe_name"><b>Recipe Name</b></label><br>
    <input type="text" placeholder="Recipe Name" name="recipe_name" id="recipe_name" required><br>

    <label for="category"><b>Category</b></label><br>
    <select name="category" id="category">

    <%
    String db = "FeedMeUp";
    String un = "root";
    String pw = "root";

    try {

      java.sql.Connection con; 
      Class.forName("com.mysql.jdbc.Driver");
      con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FeedMeUp?autoReconnect=true&useSSL=false", un, pw);

      Statement stmt = con.createStatement();
      ResultSet rs = stmt.executeQuery("SELECT category_name FROM Categories");
      while (rs.next()) {
        %>
        <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
        <%
      }

      stmt.close();
      con.close();
    }

    catch(SQLException e) {
      out.println("SQLException caught: " + e.getMessage());
    }

    %>
    </select>
    <br>

    <label for="cuisine"><b>Cuisine</b></label><br>
    <input type="text" placeholder="Type of Cuisine" name="cuisine" id="cuisine" required><br>

    <label for="cost"><b>Cost</b></label><br>
    <input type="text" placeholder="Cost" name="cost" id="cost" required><br>

    <label for="cooking_time"><b>Cooking Time</b></label><br>
    <input type="text" placeholder="Cooking Time in minutes" name="cooking_time" id="cooking_time" required><br>

    <label for="ingredients"><b>Ingredients</b></label><br>
    <textarea id="ingredients" name="ingredients" placeholder="List of Ingredients" style="height:200px; width:650px" required></textarea><br>

    <label for="steps"><b>Steps</b></label><br>
    <textarea id="steps" name="steps" placeholder="List of Steps" style="height:200px; width:650px" required></textarea><br>

    <hr style="text-align:left;margin-left:0">
    <% if ((int)session.getAttribute("update_recipe") != 0) {%>
     <button type="submit" class="recipebutton">Update Recipe</button>
    <%}else {%>
     <button type="submit" class="recipebutton">Upload Recipe</button>
    <%}%>

  </div>
</form>

<%
if (request.getParameter("recipe_name") != null) {
    int recipe_id = 0;
    String recipe_name = request.getParameter("recipe_name");
    String chosen_category = request.getParameter("category");
    String cuisine = request.getParameter("cuisine");
    int cost = Integer.parseInt(request.getParameter("cost"));
    int cooking_time = Integer.parseInt(request.getParameter("cooking_time"));
    String ingredients = request.getParameter("ingredients");
    String steps = request.getParameter("steps");

    try {
        java.sql.Connection con; 
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FeedMeUp?autoReconnect=true&useSSL=false", un, pw);

        Statement stmt = con.createStatement();
        if ((int)session.getAttribute("update_recipe") != 0) {
          recipe_id=(int)session.getAttribute("update_recipe"); 

          String query = String.format("UPDATE Recipes SET recipe_name='%s', cuisine='%s', ingredients='%s', cost='%d', time='%d', steps='%s' WHERE recipe_id='%d'", recipe_name, cuisine, ingredients, cost, cooking_time, steps, recipe_id);
          int rows = stmt.executeUpdate(query);

          if (rows > 0) {
              %> <div class="message"><p>Recipe Update Successful</p></div> <%
              response.sendRedirect("videos.jsp");
          }

          else {
              %> <div class="message"><p>Recipe Update Unsuccessful</p></div> <%
          }
        } else {
          ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM Recipes");

          while (rs.next()) {
              recipe_id = rs.getInt(1) + 1;
          }

          String query = String.format("INSERT INTO Recipes VALUES('%d', '%s', '%s', '%s', '%d', '%d', '%s')", recipe_id, recipe_name, cuisine, ingredients, cost, cooking_time, steps);
          int rows = stmt.executeUpdate(query);

          if (rows > 0) {
              %> <div class="message"><p>Recipe Upload Successful</p></div> <%
              session.setAttribute("recipe_id", recipe_id);
              session.setAttribute("recipe_name", recipe_name);
              session.setAttribute("chosen_category", chosen_category);
              response.sendRedirect("videos.jsp");
          }

          else {
              %> <div class="message"><p>Recipe Upload Unsuccessful</p></div> <%
          }
        }

        stmt.close();
        con.close();
    }

    catch(SQLException e) {
        out.println("SQLException caught: " + e.getMessage());
    }
}

%>

</body>
</html>

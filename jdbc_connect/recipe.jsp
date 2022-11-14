<!-- Code reference: https://www.w3schools.com/howto/howto_css_register_form.asp -->

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
  height: 1200px;
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
  margin: 8px 250;
  border: none;
  cursor: pointer;
  width: 25%;
}

.recipebutton:hover {
  opacity: 1;
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
<form method = 'post' action="recipe.jsp">
  <div class="container">
    <h1>Upload Recipe</h1>
    <p>Please enter the details of your recipe below.</p>

    <hr style="text-align:left;margin-left:0">

    <label for="recipe_name"><b>Recipe Name</b></label><br>
    <input type="text" placeholder="Recipe Name" name="recipe_name" id="recipe_name" required><br>

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

    <button type="submit" class="recipebutton">Upload Recipe</button>
  </div>
</form>


</body>
</html>
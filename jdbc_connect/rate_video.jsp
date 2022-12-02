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
  width: 500px;
  height: 300px;
  margin: auto;
  top: 50%;
  transform: translate(0, 22.5%);
  background-color: white;
}

input[type=text] {
  width: 50%;
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

hr {
  border: 1px solid #f1f1f1;
  margin-bottom: 25px;
}

.ratebutton {
  background-color: #04AA6D;
  color: white;
  padding: 16px 20px;
  margin: 8px 170;
  border: none;
  cursor: pointer;
  width: 25%;
}

.ratebutton:hover {
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

<form method = 'post' action="rate_video.jsp">
  <div class="container">
    <h1>Rate Video</h1>
    <p>On a scale of 1 (worst) to 5 (best), how would you rate the video you just watched?</p>

    <label for="rating">Choose a rating:</label>
    <select name="rating" id="rating">
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        <option value="5">5</option>
    </select>
    <br><br>

    <button type="submit" class="ratebutton">Rate Video</button>
  </div>
</form>

<%
if (request.getParameter("rating") != null) {
  int rating = Integer.parseInt(request.getParameter("rating"));
  int user_id = (int)session.getAttribute("user_id");
  int video_id = (int)session.getAttribute("video_id");

  String db = "FeedMeUp";
  String un = "root";
  String pw = "root";

  try {
    java.sql.Connection con; 
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FeedMeUp?autoReconnect=true&useSSL=false", un, pw);

    Statement stmt = con.createStatement();
    String query = String.format("INSERT INTO rates VALUES('%d', '%d', '%d')", user_id, video_id, rating);
    int rows = stmt.executeUpdate(query);
    
    if(rows != 0) { 
        %> <div class="message"><p>Rating Successful</p></div> <% 
        response.sendRedirect("index.jsp");
    } else { 
        %> <div class="message"><p>Rating Unsuccessful</p></div> <% 
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
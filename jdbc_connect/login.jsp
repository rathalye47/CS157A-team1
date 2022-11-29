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
              height: 500px;
              margin: auto;
              top: 50%;
              transform: translate(0, 22.5%);
              background-color: white;
            }
            input[type=text], input[type=password] {
              width: 50%;
              padding: 15px;
              margin: 5px 0 22px 0;
              display: inline-block;
              border: none;
              background: #f1f1f1;
            }
            input[type=text]:focus, input[type=password]:focus {
              background-color: #ddd;
              outline: none;
            }
            hr {
              border: 1px solid #f1f1f1;
              margin-bottom: 25px;
            }
            .loginbutton {
              background-color: #04AA6D;
              color: white;
              padding: 16px 20px;
              margin: 8px 170;
              border: none;
              cursor: pointer;
              width: 25%;
            }
            .loginbutton:hover {
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
        <form method = 'post' action="login.jsp">
          <div class="container">
            <h1>Log in to your account</h1>

            <hr style="text-align:left;margin-left:0">

            <label for="username"><b>Username</b></label><br>
            <input type="text" placeholder="Username" name="username" id="username" required><br>

            <label for="password"><b>Password</b></label><br>
            <input type="password" placeholder="Password" name="password" id="password" required>

            <hr style="text-align:left;margin-left:0">

            <button type="submit" class="loginbutton">Login</button>
          </div>
        </form>

        <%
        if (request.getParameter("username") != null) {
          String username = request.getParameter("username");
          String password = request.getParameter("password");
          boolean status = false;
          String db = "FeedMeUp";
          String un = "root";
          String pw = "root";
          try {
            java.sql.Connection con; 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FeedMeUp?autoReconnect=true&useSSL=false", un, pw);
            Statement stmt = con.createStatement();
            String query = String.format("SELECT username, password,user_id FROM Users WHERE username = '%s' AND password = SHA('%s')", username, password);
            ResultSet rs = stmt.executeQuery(query);
            status=rs.next();
            if(status == true) { 
                %> <div class="message"><p>Login Successful</p></div> <% 
                  session.setAttribute("username", username);
                  session.setAttribute("user_id",rs.getInt(3));
                  response.sendRedirect("index.jsp");

            } else { 
                %> <div class="message"><p>Login Unsuccessful</p></div> <% 
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

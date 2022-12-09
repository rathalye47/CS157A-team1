<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="java.util.Random" %>
  <!DOCTYPE html>
    <html lang="en">

      <head>
        <title>Upload</title>
        <!-- Font Awesome Icons -->
        <link href="css/font-awesome.css" rel="stylesheet" />
        <link rel="stylesheet" href="css/creativetim/creativetim.min.css">
        <link rel="icon" sizes="16x16" href="favicon.ico">
      </head>

      <body>
        <div class="wrapper">
          <header class="header-1">
            <nav class="navbar navbar-expand-lg bg-default navbar-absolute">
              <div class="container">
                <a class="navbar-brand text-white" href="index.jsp">FeedMeUp</a>
              </div>
            </nav>
          </header>
        </div>

          <div class="bg-image d-flex justify-content-center align-items-center" style="
                    background-color: black;
                    height: 30vh;">
                <div class="col-md-8 mx-auto text-center">
                  <h2 class="display-2"><br>
                    Welcome <%=(String)session.getAttribute("username") %>
                  </h2>
                </div>
              </div>
  
          <br>
          <br>
          <%-- ADD RECIPE HERE --%>
          <form method='post' action='videos.jsp'>
          <style>
              body {
                  text-align: center;
              }
          </style>
          <body>
          Please upload your recipe for your cooking video:&emsp; <br><button class="btn btn-dark" type="submit" name="upload_recipe" id="upload_recipe">Upload recipe</button>
          </form><br>

          <%-- ADD VIDEO HERE --%>
          <form method = 'post' action="videos.jsp" enctype = "multipart/form-data>
          <label for="formFileMultiple" class="form-label"></label>
          Please choose a cooking video to upload:&emsp; <br><input name="uploadVideo" type="file" id="formFileMultiple" class="btn btn-dark" multiple /><br><br>
          Click on the button to upload your cooking video:&emsp; <br><button type="submit" class="btn btn-dark">Upload Video</button>
          </form>
          </body>
          </div>

          <br><br>
          

          <%
          session.setAttribute("update_recipe", 0);
          session.setAttribute("prev_page", "vid");
          if (request.getParameter("upload_recipe") != null) {
            response.sendRedirect("recipe.jsp");
          }

          if(request.getParameter("uploadVideo") != null){
            String videoTitle = request.getParameter("uploadVideo");
              String fromFile = "C:\\Users\\ronro\\Downloads\\videos\\" + videoTitle;
            String toFile = "C:\\Users\\ronro\\Downloads\\apache-tomcat-10.0.23\\webapps\\ROOT\\CS157A-team1\\jdbc_connect\\videos\\" + videoTitle;

            Path source = Paths.get(fromFile);
            Path target = Paths.get(toFile);

            try {            
                
                Files.copy(source, target, StandardCopyOption.REPLACE_EXISTING);
                
                Class.forName("com.mysql.cj.jdbc.Driver");
                int video_id = 0;          
                String db = "feedmeup";  
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db,"root","root");

                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM videos");

                while (rs.next()) {
                  video_id = rs.getInt(1) + 10; // change to +1
                }
                int user_id = (int)session.getAttribute("user_id");
                int recipe_id = 0;
                if(session.getAttribute("recipe_id") !=null) {
                  recipe_id = (int)session.getAttribute("recipe_id");
                }
                if(recipe_id == 0) {
                  %><p style='color:navy; font-weight: bold'><%out.println("please upload a recipe first");%></p><%
              } else {
                String recipe_name = (String)session.getAttribute("recipe_name");
                
                String chosen_category = (String)session.getAttribute("chosen_category");
                String query2 = String.format("SELECT category_id FROM categories WHERE category_name='%s'", chosen_category);
                ResultSet rs2 = stmt.executeQuery(query2);
                out.println(query2);
                rs2.next();
                int category_id = rs2.getInt(1);

                String query = String.format("INSERT INTO videos (video_id, user_id, recipe_id, category_id, title, file_path) VALUES ('%d', '%d', '%d', '%d', '%s', '%s')", video_id, user_id, recipe_id, category_id, recipe_name, videoTitle);
                out.println(query);
                stmt.executeUpdate(query);
                session.setAttribute("recipe_id", 0);
               }

            } catch (IOException e) {
              e.printStackTrace();
            } catch(SQLException e) {
              out.println("SQLException caught: " + e.getMessage());
            }
          }
          %>

          <div class="bg-image d-flex justify-content-center align-items-center" style="
                    background-color: black;
                    height: 10vh; margin-top:30px;">
                <div class="col-md-8 mx-auto text-center">
                  <h2 class="display-2">
                    Uploaded Videos
                  </h2>
                </div>
              </div>
 
          <!-- VIDEOS LIST -->
          <div class="videos-list">
            <%-- Fetching videos based on user_id --%>
          <%
          try {
            Class.forName("com.mysql.cj.jdbc.Driver");          
            int user_id = (int)session.getAttribute("user_id");
            String db = "feedmeup";  
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db,"root","root");
            Statement stmt=con.createStatement();
            String statement1 = "SELECT * FROM Videos LEFT JOIN (SELECT video_id, AVG(score) AS rating FROM rates GROUP BY video_id)ratings  ON Videos.video_id=ratings.video_id WHERE Videos.user_id = " + user_id;
            ResultSet rs=stmt.executeQuery(statement1);
                            
            while (rs.next()) {

            String title = rs.getString("title");
            String videoPath = "videos/" + rs.getString("file_path");
            // get the rating value to display
            String rating_value = "";   
            if (rs.getDouble("rating") != 0) {
              rating_value=String.format("%.2f", rs.getDouble("rating"));
            } else {
              rating_value="No rating";
            } 
            %>
            <div class="card m-md-4" style='background-color: black;'>
            <video id="myVideo" width="420" height="345" controls="controls">
            <source src="<%=videoPath%>" type="video/mp4" /> </video>
              <div class="card-body">
                <h5 class="card-title" style="text-align:left"><%=title %></h5>
                <p class="card-text" style="text-align:left">Rating: <%=rating_value %></p>
                <form method='post' action="videos.jsp">
                  <input type="hidden" name="video" value="<%=rs.getInt(1)%>" />
                  <input type="hidden" name="recipe" value='<%=rs.getInt("recipe_id")%>' />
                  <table>
                  <tr>
                    <td><input type="submit"  name="remove_video" class="btn btn-outline-primary" style='margin-top:15px; margin-bottom:15px;' value="Remove Video" /></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td><input type="submit" name="recipe-submit" class="btn btn-outline-primary" value=" View Recipe "/></td>
                    <td><input type="submit" name="recipe-update" class="btn btn-outline-primary" value="Update Recipe"/></td>
                  </tr>
                </table>
                </form>
              </div>
            </div>
            <%
            
            }

            rs.close();
            // go to recipe page
            if (request.getParameter("recipe-submit") != null) {
              int video_id=Integer.parseInt(request.getParameter("video"));
              session.setAttribute("view_recipe", video_id);
              response.sendRedirect("recipe_info.jsp");
            }

            // go to recipe form page
            if (request.getParameter("recipe-update") != null) {
              int recipe_id=Integer.parseInt(request.getParameter("recipe"));
              session.setAttribute("update_recipe", recipe_id);
              response.sendRedirect("recipe.jsp");
            }

            String x = request.getParameter("remove_video");

            if(x!=null && x.equals("Remove Video")) { 
              int video_id=Integer.parseInt(request.getParameter("video")); 
              String query1=String.format("DELETE FROM Videos WHERE video_id=%d", video_id);  
              int rows=stmt.executeUpdate(query1); 
              
              if(rows !=0) {
                response.sendRedirect("videos.jsp");
              }
            } 

            stmt.close(); 
            con.close(); 
          } 
            
          catch (SQLException e) {
            out.println("SQLException caught: "+e.getMessage());
          }
          %> 

        </div>
      </body>
    </html>
    

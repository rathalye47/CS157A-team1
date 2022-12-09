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
          <%-- ADD VIDEO HERE --%>
          <form method='post' action='videos.jsp'>
          <style>
              body {
                  text-align: center;
              }
          </style>
          <body>
          Please upload your recipe for your cooking video:&emsp; <button class="btn btn-dark" type="submit" name="upload_recipe" id="upload_recipe">Upload recipe</button>
          </form><br>

          <form method = 'post' action="videos.jsp" enctype = "multipart/form-data>
          <label for="formFileMultiple" class="form-label"></label>
          Please choose a cooking video to upload:&emsp; <input name="uploadVideo" type="file" id="formFileMultiple" multiple /><br><br>
          Click on the button to upload your cooking video:&emsp; <button type="submit" class="btn btn-dark">Upload Video</button>
          </form>
          </body>
          </div>

          <br><br>
          <div class="bg-image d-flex justify-content-center align-items-center" style="
                    background-color: black;
                    height: 10vh;">
                <div class="col-md-8 mx-auto text-center">
                  <h2 class="display-2">
                    Uploaded Videos
                  </h2>
                </div>
              </div>

          <%
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
                int recipe_id = (int)session.getAttribute("recipe_id");
                String recipe_name = (String)session.getAttribute("recipe_name");
                int random_int = (int)Math.floor(Math.random()*(2000000-500+1)+500);
                
                String chosen_category = (String)session.getAttribute("chosen_category");
                String query2 = String.format("SELECT category_id FROM categories WHERE category_name='%s'", chosen_category);
                ResultSet rs2 = stmt.executeQuery(query2);
                rs2.next();
                int category_id = rs2.getInt(1);

                String query = String.format("INSERT INTO videos (video_id, user_id, recipe_id, category_id, title, file_path, duration, views, video_resolution, language) VALUES ('%d', '%d', '%d', '%d', '%s', '%s', '1:00', '%d', '1080p', 'EN')", video_id, user_id, recipe_id, category_id, recipe_name, videoTitle, random_int);
                stmt.executeUpdate(query);

            } catch (IOException e) {
              e.printStackTrace();
            } catch(SQLException e) {
              out.println("SQLException caught: " + e.getMessage());
            }
          }
          %>
 
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
            String statement1 = "SELECT * FROM Videos WHERE user_id = " + user_id;
            ResultSet rs=stmt.executeQuery(statement1);
                            
            while (rs.next()) {
            String title = rs.getString("title");
            int viewCount = rs.getInt(5);
            String videoPath = "videos/" + rs.getString("file_path");
            %>
            <div class="card m-md-4" style='background-color: black;'>
            <video id="myVideo" width="420" height="345" controls="controls">
            <source src="<%=videoPath%>" type="video/mp4" /> </video>
              <div class="card-body">
                <h5 class="card-title"><%=title %></h5>
                <form class="form-inline" method='post' action="videos.jsp">
                <input type="hidden" name="video" value="<%=rs.getInt(1)%>" />
                <input type="submit" style="margin:0px auto" name="remove_video" class="btn btn-outline-primary" value="Remove Video" />
                </form>
              </div>
            </div>
            <%
            
            }

            rs.close();
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
    
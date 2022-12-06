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

        <!-- USER PROFILE   -->
        <div class="container py-8 h-100">
          <div class="row d-flex justify-content-left align-items-center h-100">
            <div class="col col-md-9 col-lg-7 col-xl-6">
              <div class="card" style="border-radius: 15px;">
                <div class="card-body p-2">
                  <div class="d-flex text-black">
                    <div class="flex-shrink-0">
                      <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-profiles/avatar-1.webp"
                        alt="Generic placeholder image" class="img-fluid"
                        style="width: 180px; border-radius: 10px;">
                    </div>
                    <div class="flex-grow-1 ms-3">
                      <h5 class="mb-1">

                        <%=(String)session.getAttribute("username")%>

                      </h5>
                      <p class="mb-2 pb-1" style="color: #2b2a2a;">Food Enthusiast</p>
                      <div class="d-flex justify-content-start rounded-3 p-2 mb-2"
                        style="background-color: #efefef;">
                        <div>
                          <p class="small text-muted mb-1">Videos</p>
                          <p class="mb-0">41</p>
                        </div>
                        <div class="px-3">
                          <p class="small text-muted mb-1">Rating</p>
                          <p class="mb-0">4.5/5</p>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
  
          <%-- ADD VIDEO HERE --%>
          <form method='post' action='videos.jsp'>
          <button class="btn btn-sm btn-outline-primary" type="submit" name="upload_recipe" id="upload_recipe">Upload recipe</button>
          </form><br>

          <form method = 'post' action="videos.jsp" enctype = "multipart/form-data>
          <label for="formFileMultiple" class="form-label"></label>
          <input class="form-control" name="uploadVideo" type="file" id="formFileMultiple" multiple />
          <button type="submit" class="btn btn-dark">Upload Video</button>
          </form>
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
                  video_id = rs.getInt(1) + 1;
                }

                int user_id = (int)session.getAttribute("user_id");
                int recipe_id = (int)session.getAttribute("recipe_id");
                String recipe_name = (String)session.getAttribute("recipe_name");
                int random_int = (int)Math.floor(Math.random()*(2000000-500+1)+500);

                String query = String.format("INSERT INTO videos VALUES ('%d', '%d', '%d', 2, 11, '%s', '%s', '1:15', '%d', '1080p', 'EN')", video_id, user_id, recipe_id, recipe_name, videoTitle, random_int);
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
                            
            if(rs.next() == false){
              out.println("Your channel is empty!" + "<br><br><br>");
            }
            else{
              do {
              String title = rs.getString("title");
              int viewCount = rs.getInt(5);
              String videoPath = "videos/" + rs.getString("file_path");
              %>

              <div class="card m-md-4">
                                <video id="myVideo" width="420" height="345" controls="controls">
              <source src="<%=videoPath%>" type="video/mp4" /> </video>
                <div class="card-body">
                  <h5 class="card-title"><%=title %></h5>
                  <p class="card-text"><%=viewCount %> views</p>
                </div>
              </div>

              
              <%
              } while (rs.next());
                }
            con.close();
          } catch (SQLException e) {
            out.println("SQLException caught: "+e.getMessage());
          }
          %> 

        </div>
      </body>
    </html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ page import="java.sql.*" %>
    <%@ page import="java.io.*" %>
      <%@ page import="java.nio.file.*" %>
        <%@ page import="java.util.Random" %>

      <!DOCTYPE html>
        <html lang="en">
          
          <head>
            <title>Category</title>
            <!-- Font Awesome Icons -->
            <link href="css/font-awesome.css" rel="stylesheet" />
            <link rel="stylesheet" href="css/creativetim/creativetim.min.css" />
            <link rel="icon" sizes="16x16" href="favicon.ico" />
          </head>
          
          <body>
            <div class="wrapper">
              <nav class="navbar navbar-light bg-dark">
                <form>
                  <button class="btn btn-outline-success" type="submit" name="categoryButton" id="categoryButtonID">Go
                    Back</button>
                </form>
              </nav>
          
              <div class="bg-image d-flex justify-content-center align-items-center" style="
                    background-color: black;
                    height: 30vh;">
                <div class="col-md-8 mx-auto text-center">
                  <h2 class="display-2">
                    <%= session.getAttribute("chosenCategory") %>
                  </h2>
                </div>
              </div>

              <%
              if(request.getParameter("categoryButton") !=null){ 
                session.setAttribute("chosenCategory","");
                response.sendRedirect("index.jsp");
              }
              %>

              <%-- DISPLAY CHOSEN CATEGORY VIDEO --%>
              <% 
                  int userid=(int)session.getAttribute("user_id"); 
                  Class.forName("com.mysql.cj.jdbc.Driver");
                  try{
                    String db="feedmeup" ; 
                    
                    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/" +
                    db,"root","root"); 
                    Statement stmt=con.createStatement(); 
                    String statement3= "SELECT *  FROM Videos  INNER JOIN Categories  ON Videos.category_id=Categories.category_id  WHERE Categories.category_name= '" + session.getAttribute("chosenCategory") + "'  AND Videos.user_id!="+userid+";"; 

                    ResultSet rs=stmt.executeQuery(statement3); 

                    if(rs.next() == false){
                      out.println("Unable to query popular videos");
                    }
                    else{  
                        %><form class="form-inline" method='post' action="category.jsp"> <%                        
                        %><div class="videos-list"> <%
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
                              <a href="#" class="btn btn-primary">Like</a>
                              <input type="submit" name="rate" class="btn btn-outline-primary" value= "Rate Video <%=rs.getInt(1)%>"/>
                            </div>
                          </div>
                          <%

                          } while (rs.next());

                          if (request.getParameter("rate") != null) {
                            String video_id_string = request.getParameter("rate");
                            int video_id = Integer.parseInt(video_id_string.split(" ")[2].trim());
                            session.setAttribute("video_id", video_id);
                            response.sendRedirect("rate_video.jsp");
                          }
                        %> </div> <%
                        %> </form> <%
                    }
                  } catch(Exception e) {
                    out.println(e);
                  }
 
              %>

          </body>
        </html>

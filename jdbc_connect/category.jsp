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
              
              <nav class="navbar navbar-light bg-dark">
                <h3>Sort By</h3>
                <form class="form-inline" method='post' action="category.jsp">
                <input type="submit" name="sort" class="btn btn-outline-primary" value= "Low Rating"/> 
                 <input type="submit" name="sort" class="btn btn-outline-primary" value= "High Rating"/>  
                </form>
              </nav>

              <%
              // go back button
              if(request.getParameter("categoryButton") !=null){ 
                session.setAttribute("chosenCategory","");
                response.sendRedirect("index.jsp");
              }
            
            // direction to sort in
              if(request.getParameter("sort") !=null) {
                String x=request.getParameter("sort"); 
                session.setAttribute("sort", x);
                response.sendRedirect("category.jsp");
              } 
              %>

              <%-- DISPLAY CHOSEN CATEGORY VIDEO --%>
              <% 
                  int userid=(int)session.getAttribute("user_id"); 
                  // get sort if there is any
                  String sortby= "";
                  if (session.getAttribute("sort") != null) {
                    sortby=(String)session.getAttribute("sort"); 
                  }
                  Class.forName("com.mysql.cj.jdbc.Driver");
                  try{
                    String db="feedmeup" ; 
                    String statement3 = ""; 
                    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/" +
                    db,"root","root"); 
                    Statement stmt=con.createStatement(); 
                    // subquery for getting video ratings
                    String rating_query = "LEFT JOIN (SELECT video_id, AVG(score) AS rating FROM rates GROUP BY video_id)ratings";
                    // query for popular button
                    if(session.getAttribute("chosenCategory").equals("Popular")) {
                      statement3 = "SELECT * FROM Videos "+ rating_query+ " ON Videos.video_id=ratings.video_id WHERE user_id <> " + Integer.toString(userid); 
                  } 
                  // query for favorites button
                  else if(session.getAttribute("chosenCategory").equals("Favorited")) {
                    statement3= "SELECT * FROM Videos JOIN save ON Videos.video_id = save.video_id " + rating_query + " ON Videos.video_id=ratings.video_id WHERE save.user_id="+userid; 
                  } 
                  // query for specific categories
                  else { 
                    statement3= "SELECT *  FROM Videos  INNER JOIN Categories  ON Videos.category_id=Categories.category_id " + rating_query + " ON Videos.video_id=ratings.video_id WHERE Categories.category_name= '" + session.getAttribute("chosenCategory") + "'  AND Videos.user_id!="+userid; 
                  }
                  
                  // add order by specification if sort is chosen
                    if(sortby.equals("Low Rating")) {
                      statement3 = statement3 + " ORDER BY rating ASC";
                    } else if (sortby.equals("High Rating")) {
                      statement3 = statement3 + " ORDER BY rating DESC";
                    }
         
                    ResultSet rs=stmt.executeQuery(statement3);

                    // display the videos
          while (rs.next()){     
            // get the rating value to display
            String rating_value = "";   
            if (rs.getDouble("rating") != 0) {
             rating_value=String.format("%.2f", rs.getDouble("rating"));
            } else {
             rating_value="No rating";
            }  

            // check if the video has already been favorited by the user
            Statement stmt4=con.createStatement(); 
            String check_save_query = String.format("SELECT * FROM save WHERE user_id='%d' AND video_id='%d'", userid, rs.getInt(1));
            ResultSet rs4 = stmt4.executeQuery(check_save_query);
            boolean status=rs4.next();    

                      %><div class="videos-list"> <%
                          String title = rs.getString("title");
                          String videoPath = "videos/" + rs.getString("file_path");
                          %>
                          <div class="card m-md-4" style='background-color: black;'>
                              <video id="myVideo" width="420" height="345" controls="controls">
                                <source src="<%=videoPath%>" type="video/mp4" /> 
                              </video>
                              <div class="card-body">
                                <h5 class="card-title"><%=title %></h5>
                                <p class="card-text">Rating: <%=rating_value %></p>
                                <!--form for favorite button-->
                                <form class="form-inline" method='post' action="category.jsp">
                                  <input type="hidden" name="save-video" value="<%=rs.getInt(1)%>" />
                                  <% if(status == true) { %>
                                    <input type="submit" name="save-submit" class="btn btn-primary" value="Favorited" disabled/>
                                  <% } else { %>
                                    <input type="submit" name="save-submit" class="btn btn-primary" value="Favorite" />
                                  <% } %>
                              </form>
                              <!--form for rate button-->
                                <form class="form-inline" method='post' action="category.jsp">
                                  <input type="hidden" name="rate-video" value="<%=rs.getInt(1)%>" />
                                  <input type="submit" name="rate-submit" class="btn btn-outline-primary" value="Rate Video" />
                                </form>
                              </div>
                            </div>
                      </div> <%
                    }
                    // go to page to give video a rating
                    if (request.getParameter("rate-submit") != null) {
                    int video_id=Integer.parseInt(request.getParameter("rate-video"));
                    session.setAttribute("video_id", video_id);
                    response.sendRedirect("rate_video.jsp");
                    }

                    // save the video that was favorited
                    if (request.getParameter("save-submit") != null) {
                      Statement stmt3=con.createStatement();
                    int video_id=Integer.parseInt(request.getParameter("save-video"));  
            String save_query = String.format("INSERT INTO save VALUES('%d', '%d')", userid, video_id);
            int rows = stmt3.executeUpdate(save_query);
            if(rows != 0) { 
                response.sendRedirect("category.jsp");
              } else { 
                %> <script type="text/javascript">
                  alert("Unable to favorite video");
                </script> <%
              }
                    }
                  } catch(Exception e) {
                    out.println(e);
                  }
              %>
          </body>
        </html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ page import="java.sql.*" %>
    <%@ page import="java.io.*" %>
      <%@ page import="java.nio.file.*" %>
        <%@ page import="java.util.Random" %>

      <!DOCTYPE html>
        <html lang="en">
          
          <head>
            <title>User</title>
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
                    <%= session.getAttribute("video_user") %>'s Page
                  </h2>
                  <%
                  String user=(String)session.getAttribute("video_user"); 
                  int userid=(int)session.getAttribute("user_id"); 
                  Class.forName("com.mysql.cj.jdbc.Driver");
                  try{
                    String db="feedmeup" ; 
                    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/" +
                    db,"root","root"); 
                    Statement stmt1=con.createStatement(); 
                    String check_report_query = String.format("SELECT * FROM report WHERE reporter_user_id='%d' AND reported_user_id IN (SELECT user_id FROM Users WHERE username='%s')", userid, user);
                    ResultSet rs1 = stmt1.executeQuery(check_report_query);
                    boolean reported=rs1.next();  

                    %>
                  <form method='post' action="user_info.jsp">
                    <% if(reported == true) { %>
                        <input type="submit" name="reportButton" class="btn btn-outline-danger" value="Reported" disabled/>
                      <% } else { %>
                        <input type="submit" name="reportButton" class="btn btn-outline-danger" value="Report" />
                      <% } %>
                  </form>
                </div>
              </div>
              
              <nav class="navbar navbar-light bg-dark">
                <h3>Sort By</h3>
                <form class="form-inline" method='post' action="user_info.jsp">
                <input type="submit" name="user_sort" class="btn btn-outline-primary" value= "Low Rating"/> 
                 <input type="submit" name="user_sort" class="btn btn-outline-primary" value= "High Rating"/>  
                </form>
              </nav>

              <%
              
              session.setAttribute("prev_page", "user");
              // go back button
              if(request.getParameter("categoryButton") !=null){ 
                response.sendRedirect("category.jsp");
              }

              // report button
              if(request.getParameter("reportButton") !=null){ 
                Statement stmt5=con.createStatement(); 
                String report_query = String.format("INSERT INTO report VALUES('%d', (SELECT user_id FROM Users WHERE username='%s'))", userid, user);
                int rows = stmt5.executeUpdate(report_query);
                if(rows != 0) { 
                  response.sendRedirect("user_info.jsp");
                } else { 
                  %> <script type="text/javascript">
                    alert("Unable to report user");
                  </script> <%
                }
              }
             
              // direction to sort in
              if(request.getParameter("user_sort") !=null) {
                String x=request.getParameter("user_sort"); 
                session.setAttribute("user_sort", x);
                response.sendRedirect("user_info.jsp");
              } 
              %>

              <%-- DISPLAY USERS VIDEOS --%>
              <% 
                  String sortby= "";
                  if (session.getAttribute("user_sort") != null) {
                    sortby=(String)session.getAttribute("user_sort"); 
                  }
                  
                    Statement stmt=con.createStatement(); 
                    // subquery to get user_id
                    String user_id_query = String.format("(SELECT user_id FROM Users WHERE username='%s')", user);
                    // subquery for getting video ratings
                    String rating_query = "LEFT JOIN (SELECT video_id, AVG(score) AS rating FROM rates GROUP BY video_id)ratings";
                    String video_query = "SELECT * FROM Videos "+ rating_query+ " ON Videos.video_id=ratings.video_id WHERE user_id IN " +user_id_query; 
                  
                    // add order by specification if sort is chosen
                    if(sortby.equals("Low Rating")) {
                      video_query = video_query + " ORDER BY rating ASC";
                    } else if (sortby.equals("High Rating")) {
                      video_query= video_query + " ORDER BY rating DESC";
                    }
         
                    ResultSet rs=stmt.executeQuery(video_query);

                    // display the videos
                    %> <div class="videos-list"> <%
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

                      %>
                      <%
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
                            
                            <!--form for favorite and rate button-->
                            <form class="form-inline" method='post' action="user_info.jsp">
                              <table>
                              <input type="hidden" name="video-id" value="<%=rs.getInt(1)%>" />
                              <tr>
                                <td>
                                  <input type="submit" name="recipe-submit" class="btn btn-outline-primary" value="View Recipe" style='margin-top:15px; margin-bottom:15px;'/>
                                </td>
                                <td></td>
                              </tr>
                              <tr>
                                <td>
                              <% if(status == true) { %>
                                <input type="submit" name="save-submit" class="btn btn-primary" value="Favorited" disabled/>
                              <% } else { %>
                                <input type="submit" name="save-submit" class="btn btn-primary" value="Favorite" />
                              <% } %>
                                </td>
                                <td>
                              <input type="submit" name="rate-submit" class="btn btn-outline-primary" value="Rate Video" />
                                </td>
                              </tr>
                            </table>
                            </form>
                          </div>  
                      </div> <%
                    } %> </div> <%
                    
                    // go to recipe page
                    if (request.getParameter("recipe-submit") != null) {
                      int video_id=Integer.parseInt(request.getParameter("video-id"));
                      session.setAttribute("view_recipe", video_id);
                      response.sendRedirect("recipe_info.jsp");
                    }

                    // go to page to give video a rating
                    if (request.getParameter("rate-submit") != null) {
                      int video_id=Integer.parseInt(request.getParameter("video-id"));
                      session.setAttribute("rate_video_id", video_id);
                      response.sendRedirect("rate_video.jsp");
                    }

                    // save the video that was favorited
                    if (request.getParameter("save-submit") != null) {
                      Statement stmt3=con.createStatement();
                      int video_id=Integer.parseInt(request.getParameter("video-id"));  
                      String save_query = String.format("INSERT INTO save VALUES('%d', '%d')", userid, video_id);
                      int rows = stmt3.executeUpdate(save_query);
                      if(rows != 0) { 
                          response.sendRedirect("user_info.jsp");
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

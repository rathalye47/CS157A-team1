<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ page import="java.sql.*" %>
    <%@ page import="java.io.*" %>
      <%@ page import="java.nio.file.*" %>
        <%@ page import="java.util.Random" %>

      <!DOCTYPE html>
        <html lang="en">
          <style>
            .landing {
              font-size: 2.75rem;
              font-weight: 600;
              line-height: 1.5; 
              background-color: black;
            }
          </style>

          <head>
            <title>Main</title>

            <!-- Font Awesome Icons -->
            <link href="css/font-awesome.css" rel="stylesheet" />
            <link rel="stylesheet" href="css/creativetim/creativetim.min.css" />
            <link rel="icon" sizes="16x16" href="favicon.ico" />
          </head>

          <body>
            <div class="wrapper">

              <div class="bg-image d-flex justify-content-center align-items-center" style="
          background-image: url('https://i.ibb.co/dWghRff/HeroAlt3.jpg');
          height: 80vh;
        ">
                <div class="col-md-8 mx-auto text-center">
                  <h2 class="landing">WELCOME</h2>
                </div>
              </div>

              <!-- CATEGORIES NAVIGATION BAR -->

              <nav class="navbar navbar-light bg-dark">
                <h3>Browse Categories</h3>
                <form class="form-inline" method='post' action="index.jsp">
                  <input type="submit" name="category" class="btn btn-outline-success" value= "Favorited"/> 
                  <input type="submit" name="category" class="btn btn-outline-success" value= "Popular"/>  
                  <%
                  session.setAttribute("sort","");
                  int userid=(int)session.getAttribute("user_id"); 
                  Class.forName("com.mysql.cj.jdbc.Driver");
                  try{
                    String db="feedmeup" ; 
                    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/" +
                    db,"root","root"); 
                    Statement stmt=con.createStatement(); 
                    String statement2= "SELECT category_name FROM Categories INNER JOIN Videos ON Categories.category_id=Videos.category_id GROUP BY category_name;";
                    ResultSet rs=stmt.executeQuery(statement2); 

                    while (rs.next()) { 
                      String category_name = rs.getString("category_name"); 
                      // check if the category has been favorited by the user
                      Statement stmt4=con.createStatement(); 
                      String check_fav_query = String.format("SELECT * FROM prefers WHERE user_id='%d' AND category_id IN (SELECT category_id FROM Categories WHERE category_name='%s')", userid, category_name);
                      ResultSet rs4 = stmt4.executeQuery(check_fav_query);
                      boolean status=rs4.next(); 
                      if(status == true) { 
                      %>
                      <input type="submit" name="category" class="btn btn-outline-success" value= "<%=category_name%>"/>
                    <% } else {
                    %>
                      <input type="submit" name="category" class="btn btn-outline-primary" value= "<%=category_name%>"/>
                    <% 
                    }
                   }
                    %> </div> <%
                    String x=request.getParameter("category"); 
                    if(x!=null) {
                      session.setAttribute("chosenCategory",x);
                      response.sendRedirect("category.jsp");
                    }
                    
                  } catch(Exception e) {
                      out.println(e);
                  }
                  %>
                </form>
              </nav>

              <div class="section projects-3">
                <div class="container">
                  <div class="row">
                    <div class="col-md-8 mr-auto ml-auto text-center">
                      <h2 class="title mb-5">Have your own cooking / food video? <br> Upload it here.</h2>
                      <form>
                        <button class="btn btn-outline-primary" type="submit" name="upload_video" id="upload_video">Upload a
                          video</button>
                      </form>
                    </div>
                  </div>

              <% if (request.getParameter("upload_video") !=null) { 
                    response.sendRedirect("videos.jsp"); 
                  } %>      
          
          </body>     
        </html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="java.util.Random"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <title>Page title</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
  <link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">
  <!-- Nucleo Icons -->
  <link href="css/nucleo-icons.css" rel="stylesheet" />
  <link href="css/nucleo-svg.css" rel="stylesheet" />
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
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-header-1"
            aria-controls="navbar-header-1" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbar-header-1">
            <div class="navbar-collapse-header">
              <div class="row">
                <div class="col-6 collapse-brand">
                  <a href="javascript:;">
                    <img src="https://app.creative-tim.com/argon_placeholder/brand/blue.png"></a>
                </div>
                <div class="col-6 collapse-close">
                  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-header-1"
                    aria-controls="navbar-header-1" aria-expanded="false" aria-label="Toggle navigation">
                    <span></span>
                    <span></span>
                  </button>
                </div>
              </div>
            </div>
            <ul class="navbar-nav mx-auto">
              <li class="nav-item"><a class="nav-link text-white" href="javascript:;">Videos</a></li>
              <li class="nav-item"><a class="nav-link text-white" href="javascript:;">About Us</a></li>
              <li class="nav-item"><a class="nav-link text-white" href="javascript:;">Contact Us</a>
              </li>
            </ul>
            <ul class="nav navbar-nav">
              <li class="nav-item"><a class="nav-link text-white" href="https://twitter.com/CreativeTim"><i
                    class="fab fa-twitter"></i></a></li>
              <li class="nav-item"><a class="nav-link text-white" href="https://www.facebook.com/CreativeTim"><i
                    class="fab fa-facebook-square"></i></a></li>
              <li class="nav-item"><a class="nav-link text-white"
                  href="https://www.instagram.com/CreativeTimOfficial"><i class="fab fa-instagram"></i></a></li>
            </ul>
          </div>
        </div>
      </nav>

      
      <!-- USER PROFILE   -->
      <div class="container py-8 h-100">
        <div class="row d-flex justify-content-left align-items-center h-100">
          <div class="col col-md-9 col-lg-7 col-xl-6">
            <div class="card" style="border-radius: 15px;">
              <div class="card-body p-2">
                <div class="d-flex text-black">
                  <div class="flex-shrink-0">
                    <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-profiles/avatar-1.webp"
                      alt="Generic placeholder image" class="img-fluid" style="width: 180px; border-radius: 10px;">
                  </div>
                  <div class="flex-grow-1 ms-3">
                    <h5 class="mb-1">
                    
                    <%=(String)session.getAttribute("username")%>
                    
                    </h5>
                    <p class="mb-2 pb-1" style="color: #2b2a2a;">Food Enthusiast</p>
                    <div class="d-flex justify-content-start rounded-3 p-2 mb-2" style="background-color: #efefef;">
                      <div>
                        <p class="small text-muted mb-1">Videos</p>
                        <p class="mb-0">41</p>
                      </div>
                      <div class="px-3">
                        <p class="small text-muted mb-1">Followers</p>
                        <p class="mb-0">976</p>
                      </div>
                      <div>
                        <p class="small text-muted mb-1">Rating</p>
                        <p class="mb-0">4.5/5</p>
                      </div>
                    </div>
                    <div class="d-flex pt-1">
                      <button type="button" class="btn btn-outline-primary me-1 flex-grow-1">Subscribe</button>
                      <button type="button" class="btn btn-primary flex-grow-1">Follow</button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
              <%-- ADD VIDEO HERE --%>
      <form method='post' action='videos.jsp'>
      <button class="btn btn-sm btn-outline-secondary" type="submit" name="upload_recipe" id="upload_recipe">Upload recipe</button>
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
            int random_int = (int)Math.floor(Math.random()*(2000000-500+1)+500);

            String query = String.format("INSERT INTO videos VALUES ('%d', '%d', 5, 2, 11, 'Veggie Pad Thai #shorts', '%s', '1:15', '%d', '1080p', 'EN')", video_id, user_id, videoTitle, random_int);
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
                out.println("<br>" + "Your channel is empty!");
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
              }
               catch (SQLException e) {
               out.println("SQLException caught: "+e.getMessage());
              }
%> 

      </div>


      <div class="page-header">
        <div class="page-header-image" style="background-image: url('https://i.ibb.co/pxhhXKr/Meat-Screegrab.png')">
        </div>
        <div class="container">
          <div class="row">
            <div class="col-lg-5 col-md-7 mr-auto text-left d-flex justify-content-center flex-column">
              <h3 class="display-3">Let's get grillin'</h3>
              <p class="lead mt-0">The time is now for it to be okay to be great. People in this world shun people for
                being great. For being a bright color.</p>
              <br>
              <div class="buttons"><a class="btn btn-danger" href="javascript:;">Got it</a></div>
            </div>
          </div>
        </div>
      </div>
    </header>



  </div>

  <!--   Core JS Files   -->
  <script src="js/core/jquery.min.js" type="text/javascript"></script>
  <script src="js/core/popper.min.js" type="text/javascript"></script>
  <script src="js/core/bootstrap.min.js" type="text/javascript"></script>
  <script src="js/plugins/perfect-scrollbar.jquery.min.js"></script>
  <!--  Plugin for Switches, full documentation here: http://www.jque.re/plugins/version3/bootstrap.switch/ -->
  <script src="js/plugins/bootstrap-switch.js"></script>
  <!--  Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
  <script src="js/plugins/nouislider.min.js" type="text/javascript"></script>
  <!--  Plugin for the Carousel, full documentation here: http://jedrzejchalubek.com/ -->
  <script src="js/plugins/glide.js" type="text/javascript"></script>
  <!--  Plugin for the DatePicker, full documentation here: https://flatpickr.js.org/ -->
  <script src="js/plugins/moment.min.js"></script>
  <!--	Plugin for Select, full documentation here: https://joshuajohnson.co.uk/Choices/ -->
  <script src="js/plugins/choices.min.js" type="text/javascript"></script>
  <!--  Plugin for the DateTimePicker, full documentation here: https://flatpickr.js.org/ -->
  <script src="js/plugins/datetimepicker.js" type="text/javascript"></script>
  <!-- Plugin for Fileupload, full documentation here: http://www.jasny.net/bootstrap/javascript/#fileinput -->
  <script src="js/plugins/jasny-bootstrap.min.js"></script>
  <!-- Plugin for Headrom, full documentation here: https://wicky.nillia.ms/headroom.js/ -->
  <script src="js/plugins/headroom.min.js"></script>
  <!-- Control Center for Argon UI Kit: parallax effects, scripts for the example pages etc -->
  <%-- <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE" type="text/javascript"></script> --%>
  <script src="js/argon-design-system.min.js?v=1.0.2" type="text/javascript"></script>
  <script>
    function argonScripts() {
      if (document.querySelectorAll('.glide').length) {
        // Carousel
        new Glide('.glide', {
          type: 'carousel',
          startAt: 0,
          focusAt: 2,
          perTouch: 1,
          perView: 4
        }).mount();
      }

      if (document.querySelectorAll('.testimonial-glide').length) {
        // Testimonial Carousel
        new Glide('.testimonial-glide', {
          type: 'carousel',
          startAt: 0,
          focusAt: 2,
          perTouch: 1,
          perView: 4
        }).mount();
      }

      if (document.querySelectorAll('.map').length) {
        ArgonKit.initGoogleMaps();
        ArgonKit.initGoogleMaps2();
      }
    }
    argonScripts();
  </script>
  
</body>

</html>

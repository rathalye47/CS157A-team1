<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ page import="java.sql.*" %>
    <%@ page import="java.io.*" %>
      <%@ page import="java.nio.file.*" %>
        <%@ page import="java.util.Random" %>

          <!DOCTYPE html>
          <html lang="en">

          <head>
            <title>Page title</title>
            <meta charset="utf-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
            <meta name="description" content="" />
            <meta name="author" content="" />
            <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" />
            <link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet" />
            <!-- Nucleo Icons -->
            <link href="css/nucleo-icons.css" rel="stylesheet" />
            <link href="css/nucleo-svg.css" rel="stylesheet" />
            <!-- Font Awesome Icons -->
            <link href="css/font-awesome.css" rel="stylesheet" />
            <link rel="stylesheet" href="css/creativetim/creativetim.min.css" />
            <link rel="icon" sizes="16x16" href="favicon.ico" />
          </head>

          <body>
            <div class="wrapper">
              <header class="header-2 skew-separator">
                <nav class="navbar navbar-expand-lg bg-white navbar-absolute">
                  <div class="container">
                    <div class="navbar-translate">
                      <a class="navbar-brand" href="javascript:;">FeedMeUp</a>
                      <button class="navbar-toggler" type="button" data-toggle="collapse"
                        data-target="#example-header-2" aria-controls="navbarSupportedContent" aria-expanded="false"
                        aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                      </button>
                    </div>
                    <div class="collapse navbar-collapse" id="example-header-2">
                      <div class="navbar-collapse-header">
                        <div class="row">
                          <div class="col-6 collapse-brand">
                            <a>
                              FeedMe
                              <span>UP</span>
                            </a>
                          </div>
                          <div class="col-6 collapse-close text-right">
                            <button class="navbar-toggler" type="button" data-toggle="collapse"
                              data-target="#example-header-2" aria-controls="navigation-index" aria-expanded="false"
                              aria-label="Toggle navigation">
                              <span></span>
                              <span></span>
                            </button>
                          </div>
                        </div>
                      </div>
                      <ul class="navbar-nav mx-auto">
                        <li class="nav-item">
                          <a class="nav-link" href="javascript:;">Home</a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link" href="javascript:;">About Us</a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link" href="javascript:;">Products</a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link" href="javascript:;">Contact Us</a>
                        </li>
                      </ul>
                      <ul class="nav navbar-nav navbar-right">
                        <li class="nav-item">
                          <a class="nav-link" href="https://twitter.com/CreativeTim"><i class="fab fa-twitter"></i></a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link" href="https://www.facebook.com/CreativeTim"><i
                              class="fab fa-facebook-square"></i></a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link" href="https://www.instagram.com/CreativeTimOfficial"><i
                              class="fab fa-instagram"></i></a>
                        </li>
                      </ul>
                    </div>
                  </div>
                </nav>
              </header>

              <!-- BBQ IS LIFE -->

              <div class="bg-image d-flex justify-content-center align-items-center" style="
          background-image: url('https://i.ibb.co/dWghRff/HeroAlt3.jpg');
          height: 100vh;
        ">
                <div class="col-md-8 mx-auto text-center">
                  <h2 class="display-2">BBQ IS LIFE</h2>
                </div>
              </div>

              <!-- CATEGORIES NAVIGATION BAR -->

              <nav class="navbar navbar-light bg-light">
                <form class="form-inline" method='post' action="index.jsp">
                  <button class="btn btn-outline-success" type="submit" name="popularButton" id="popularButtonID">Popular</button>

                  <%
                  int userid=(int)session.getAttribute("user_id"); 
                  Class.forName("com.mysql.cj.jdbc.Driver");
                  try{
                        String db="feedmeup" ; 
                        
                        Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/" +
                        db,"root","root"); 
                        Statement stmt=con.createStatement(); 
                        String statement2= "SELECT category_name FROM Categories INNER JOIN Videos ON Categories.category_id=Videos.category_id GROUP BY category_name;";
                        ResultSet rs=stmt.executeQuery(statement2); 

                              if(rs.next() == false){
                                out.println("Query returns empty tuples!");
                              }
                              else{
                                do {
                                String category_name = rs.getString("category_name");
                                session.setAttribute("chosenCategory",category_name);
                                 %>
    
                                <a class="btn btn-outline-primary" href="category.jsp" role="button"><%=category_name%></a>
                      
                                 <%                                               
                                    } while (rs.next());


                                 %> </div> <%
                              }


                    } catch(Exception e) {
                          out.println(e);
                      }
                  %>




                  <button class="btn btn-sm btn-outline-secondary" type="submit" name="asianCuisineButton">Asian
                    Cuisine</button><br><br>
                  <button class="btn btn-sm btn-outline-secondary" type="submit" name="upload_video" id="upload_video">Upload a video</button>
                </form>
              </nav>

              <%-- <script>
                document.addEventListener("DOMContentLoaded", function(event) { 
                  document.getElementById("popularButtonID").click();
              });
              </script> --%>
              <% 
                if(request.getParameter("popularButton") !=null){ 
                  try{
                        String db="feedmeup" ; 
                        
                        Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/" +
                        db,"root","root"); 
                        Statement stmt=con.createStatement(); 
                        String statement1= "SELECT * FROM Videos WHERE user_id <> " + Integer.toString(userid) + " ORDER BY views DESC"; 
                        ResultSet rs=stmt.executeQuery(statement1); 

                              if(rs.next() == false){
                                out.println("Unable to query popular videos");
                              }
                              else{                          
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
                                        <a href="rate_video.jsp" class="btn btn-primary">Rate</a>
                                      </div>
                                    </div>
                                    <%

                                    } while (rs.next());
                                 %> </div> <%
                              }
                    } catch(Exception e) {
                          out.println(e);
                      }

                
                }

                if(request.getParameter("asianCuisineButton") !=null){ out.println("Asian cuisine button"); } 

                if (request.getParameter("upload_video") != null) {
                  response.sendRedirect("videos.jsp");
                }

                %>







                  <div class="section projects-3">
                    <div class="container">
                      <div class="row">
                        <div class="col-md-8 mr-auto ml-auto text-center">
                          <h6 class="category text-muted">WHAT'S COOKIN'?</h6>
                          <h2 class="title mb-5">BBQ Sauce. Just Tastier.</h2>
                        </div>
                      </div>
                      <div class="row">
                        <div class="col-lg-4">
                          <div class="card card-background" style="
                  background-image: url('https://app.creative-tim.com/argon_placeholder/theme/masha-rostovskaya.jpg');
                ">
                            <div class="card-body text-left">
                              <div class="icon icon-shape bg-gradient-white shadow rounded-circle mb-3">
                                <i class="ni ni-atom text-warning"></i>
                              </div>
                              <a href="javascript:;">
                                <h2 class="card-title">The Secret Sauce</h2>
                              </a>
                              <h6 class="desc text-white opacity-8">Java App</h6>
                              <a class="btn btn-sm btn-warning" href="javascript:;">Watch the video</a>
                            </div>
                          </div>
                        </div>
                        <div class="col-lg-4">
                          <div class="card card-background" style="
                  background-image: url('https://app.creative-tim.com/argon_placeholder/theme/ali-pazani.jpg');
                ">
                            <div class="card-body text-center">
                              <div class="icon icon-shape bg-gradient-white shadow rounded-circle mb-3">
                                <i class="ni ni-controller text-danger"></i>
                              </div>
                              <a href="javascript:;">
                                <h2 class="card-title">How to Smoke Brats</h2>
                              </a>
                              <h6 class="desc text-white opacity-8">College project</h6>
                              <a class="btn btn-sm btn-danger" href="javascript:;">Watch the video</a>
                            </div>
                          </div>
                        </div>
                        <div class="col-lg-4">
                          <div class="card card-background" style="
                  background-image: url('https://app.creative-tim.com/argon_placeholder/theme/willy-dade.jpg');
                ">
                            <div class="card-body text-right">
                              <div class="icon icon-shape bg-gradient-white shadow rounded-circle mb-3">
                                <i class="ni ni-html5 text-success"></i>
                              </div>
                              <a href="javascript:;">
                                <h2 class="card-title">Choosing the right meat</h2>
                              </a>
                              <h6 class="desc text-white opacity-8">HTML code</h6>
                              <a class="btn btn-sm btn-success" href="javascript:;">Watch Later</a>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
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
            <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE" type="text/javascript"></script>
            <script src="js/argon-design-system.min.js?v=1.0.2" type="text/javascript"></script>
            <script>
              function argonScripts() {
                if (document.querySelectorAll(".glide").length) {
                  // Carousel
                  new Glide(".glide", {
                    type: "carousel",
                    startAt: 0,
                    focusAt: 2,
                    perTouch: 1,
                    perView: 4,
                  }).mount();
                }

                if (document.querySelectorAll(".testimonial-glide").length) {
                  // Testimonial Carousel
                  new Glide(".testimonial-glide", {
                    type: "carousel",
                    startAt: 0,
                    focusAt: 2,
                    perTouch: 1,
                    perView: 4,
                  }).mount();
                }

                if (document.querySelectorAll(".map").length) {
                  ArgonKit.initGoogleMaps();
                  ArgonKit.initGoogleMaps2();
                }
              }
              argonScripts();
            </script>
          </body>

          </html>

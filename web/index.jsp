<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>AAI Project</title>

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template -->
    <link href="https://fonts.googleapis.com/css?family=Saira+Extra+Condensed:100,200,300,400,500,600,700,800,900" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i" rel="stylesheet">
    <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="vendor/devicons/css/devicons.min.css" rel="stylesheet">
    <link href="vendor/simple-line-icons/css/simple-line-icons.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/resume.min.css" rel="stylesheet">

    <style type="text/css">
/*    	#aai-logo
    	{
    		width: 100px;
    		height: 100px;
    	}*/
/*        .p1
        {
            max-height: 10%;
        }*/
    </style>

  </head>

  <body id="page-top">
      
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top" id="sideNav">
      <a class="navbar-brand js-scroll-trigger" href="#page-top">
        <span class="d-block d-lg-none">Menu</span>
        <span class="d-none d-lg-block">
          <img class="img-fluid img-profile rounded-circle mx-auto mb-2" src="img/aai-logo.jpg" alt="aai">
        </span>
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="#initiative">Initiative</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="#underdevelopment">Under Development</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="#completed">Completed</a>
          </li>
        </ul>
      </div>
    </nav>
      
    <div class="container-fluid" style="margin-top: 10px;">
        <h3 class="col-md-10 col-xs-12" style="display: inline; font-size: xx-large; font-family: fantasy;">Monitoring of various projects at Indian Airports</h3>
        <button class="btn btn-outline-dark col-md-2 pull-right" data-toggle="collapse" data-target="#login-form">LOGIN</button>
        <br><br><br>
        <center>
            <div class="collapse bg-light col-md-8" id="login-form" aria-expanded="false">
                <form action="login" method="POST">
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="username" name="username" required />
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control" placeholder="password" name="password" required />
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-outline-secondary">LOGIN</button>
                    </div>
                </form>
            </div>
        </center>
    </div>
      
    <div class="container-fluid p-0">

      <section class="resume-section p-3 p-lg-5 d-flex d-column" id="about">
        <div class="my-auto">
          <h1 class="mb-0">Airports Authority of
            <span class="text-primary">India</span>
          </h1>
          <div class="subheading mb-5">
          	(A Miniratna - Category -1 Public Sector Enterprise)
          </div>
          <p class="mb-5">
          	Airports Authority of India (AAI) was constituted by an Act of Parliament and came into being    on 1st April 1995 by merging erstwhile National Airports Authority and International Airports    Authority of India. The merger brought into existence a single Organization entrusted with the    responsibility of creating, upgrading, maintaining and managing civil aviation infrastructure both    on the ground and air space in the country.

AAI manages 125 airports, which include 18 International Airport, 07 Customs Airports, 78    Domestic Airports and 26 Civil Enclaves at Defense airfields. AAI provides air navigation services over 2.8 million square nautical miles of air space. During the year 2013-14, AAI    handled aircraft movement of 1536.60 Thousand [International 335.95 & Domestic 1200.65],    Passengers handled 168.91 Million [International 46.62 & Domestic 122.29] and the cargo    handled 2279.14 thousand MT [International 1443.04 & Domestic 836.10].
          </p>
        </div>
      </section>

      <section class="resume-section p-3 p-lg-5 d-flex flex-column" id="initiative">
        <div class="my-auto">
          <h2 class="mb-5">Initiatives</h2>
            <%
                int count = 0;
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql?aai","root","kaka");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("select * from initiative order by date DESC");
                while(rs.next())
                {
                    String name = rs.getString(1);
                    String airport = rs.getString(2);
                    String about = rs.getString(3);
                    Date date = rs.getDate(4);                           
                %>

              <div class="resume-item d-flex flex-column flex-md-row mb-5">
                <div class="resume-content mr-auto">
                  <h3 class="mb-0"><%= name %></h3>
                  <div class="subheading mb-3"><%= airport %></div>
                  <button class="btn btn-outline-primary" data-toggle="modal" data-target="#about<%= count %>">View</button>
                </div>
                <div class="resume-date text-md-right">
                  <span class="text-primary"><%= date %></span>
                </div>
              </div>
                
              <div class="modal fade" id="about<%= count %>">
                  <div class="modal-dialog">
                      <div class="modal-content">
                          <div class="modal-header">
                              <h3><%= name %></h3>
                              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                  <span aria-hidden="true">&times;</span>
                              </button>
                          </div>
                          <div class="modal-body">
                              <%= about %>
                          </div>
                          <div class="modal-footer">
                              <h4 class="text-muted"><%= airport %></h4>
                          </div>

                      </div>
                  </div>
              </div>

                <%
                    count++;
                    }
                %>
          </div>

      </section>
            
      <section class="resume-section p-3 p-lg-5 d-flex flex-column" id="underdevelopment">
        <div class="my-auto">
          <h2 class="mb-5">Under Development</h2>
          
          <%
            Statement stmt1 = con.createStatement();
            ResultSet rs1 = stmt1.executeQuery("select name,airport,about,date,id from underdevelopment order by date DESC");
            while(rs1.next())
            {
                String name = rs1.getString(1);
                String airport = rs1.getString(2);
                String about = rs1.getString(3);
                Date date = rs1.getDate(4);
                int id = rs1.getInt(5);
            %>

            <div class="resume-item d-flex flex-column flex-md-row mb-5">
            <div class="resume-content mr-auto">
              <h3 class="mb-0"><%= name %></h3>
              <div class="subheading mb-3"><%= airport %></div>
              <button class="btn btn-outline-primary" data-toggle="modal" data-target="#about<%= count %>">View</button>
            </div>
            <div class="resume-date text-md-right">
              <span class="text-primary"><%= date %></span>
            </div>
          </div>
            
              <div class="modal fade" id="about<%= count %>">
                  <div class="modal-dialog">
                      <div class="modal-content">
                          <div class="modal-header">
                              <h3><%= name %></h3>
                              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                  <span aria-hidden="true">&times;</span>
                              </button>
                          </div>
                          <div class="modal-body">
                                <div class="carousel slide" id="carouselid" data-ride="carousel">
                  
                                <!-- Indicators dot -->
                                <ol class="carousel-indicators">
                                  <li data-target="#carouselid" data-slide-to="0" class="active"></li>
                                  <li data-target="#carouselid" data-slide-to="1"></li>
                                  <li data-target="#carouselid" data-slide-to="2"></li>
                                  <li data-target="#carouselid" data-slide-to="3"></li>
                                  <li data-target="#carouselid" data-slide-to="4"></li>
                                </ol>

                                <!-- Images -->
                                <div class="carousel-inner" role="listbox">
                                  <div class="carousel-item active">
                                    <img src="RetriveImage1?<%=id%>" class="d-block w-100" alt="Not Available" />
                                  </div>
                                  <div class="carousel-item">
                                    <img src="RetriveImage2?<%=id%>" class="d-block w-100" alt="Not Available" />
                                  </div>
                                  <div class="carousel-item">
                                    <img src="RetriveImage3?<%=id%>" class="d-block w-100" alt="Not Available" />
                                  </div>
                                  <div class="carousel-item">
                                    <img src="RetriveImage4?<%=id%>" class="d-block w-100" alt="Not Available" />
                                  </div>
                                  <div class="carousel-item">
                                    <img src="RetriveImage5?<%=id%>" class="d-block w-100" alt="Not Available" />
                                  </div>

                                <!-- Left and right arrow keys -->
                                <a class="carousel-control-prev" href="#carouselid" role="button" data-slide="prev">
                                  <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                  <span class="sr-only">Previous</span>
                                </a>
                                <a class="carousel-control-next" href="#carouselid" role="button" data-slide="next">
                                  <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                  <span class="sr-only">Next</span>
                                </a>

                              </div>

                            </div>

                            <%= about %>
                          </div>
                          <div class="modal-footer">
                              <h4 class="text-muted"><%= airport %></h4>
                          </div>

                      </div>
                  </div>
              </div>            
            
            <%
                count++;
                }
            %>            

        </div>
      </section>

      <section class="resume-section p-3 p-lg-5 d-flex flex-column" id="completed">
        <div class="my-auto">
          <h2 class="mb-5">Completed</h2>
          
          <%
            Statement stmt2 = con.createStatement();
            ResultSet rs2 = stmt1.executeQuery("select name,airport,about,date,id from completed order by date DESC");
            while(rs2.next())
            {
                String name = rs2.getString(1);
                String airport = rs2.getString(2);
                String about = rs2.getString(3);
                Date date = rs2.getDate(4);   
                int id = rs2.getInt(5);
            %>

          <div class="resume-item d-flex flex-column flex-md-row mb-5">
            <div class="resume-content mr-auto">
              <h3 class="mb-0"><%= name %></h3>
              <div class="subheading mb-3"><%= airport %></div>
              <button class="btn btn-outline-primary" data-toggle="modal" data-target="#about<%= count %>">View</button>
            </div>
            <div class="resume-date text-md-right">
              <span class="text-primary"><%= date %></span>
            </div>
          </div>
            
              <div class="modal fade" id="about<%= count %>">
                  <div class="modal-dialog">
                      <div class="modal-content">
                          <div class="modal-header">
                              <h3><%= name %></h3>
                              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                  <span aria-hidden="true">&times;</span>
                              </button>
                          </div>
                          <div class="modal-body">
                              
                              <video width="100%" height="100%" controls muted>
                                  <source src="RetriveVideo?<%=id%>" type="video/mp4">
                                  Your browser does not support the video tag.
                              </video>
                              
                              <%= about %>
                          </div>
                          <div class="modal-footer">
                              <h4 class="text-muted"><%= airport %></h4>
                          </div>

                      </div>
                  </div>
              </div>            
            
            <%
                count++;
                }
            %>            

        </div>
      </section>
            

    </div>

    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for this template -->
    <script src="js/resume.min.js"></script>

  </body>

</html>

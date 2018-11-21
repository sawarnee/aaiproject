<%-- 
    Document   : operator
    Created on : 15 Jul, 2018, 4:33:05 AM
    Author     : Dell
--%>

<%@page import="java.sql.Date"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      <meta name="description" content="">
      <meta name="author" content="">

      <title>operator portal</title>

      <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

      <link href="https://fonts.googleapis.com/css?family=Saira+Extra+Condensed:100,200,300,400,500,600,700,800,900" rel="stylesheet">
      <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i" rel="stylesheet">
      <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet">
      <link href="vendor/devicons/css/devicons.min.css" rel="stylesheet">
      <link href="vendor/simple-line-icons/css/simple-line-icons.css" rel="stylesheet">

      <!--<link href="css/resume.min.css" rel="stylesheet">-->

      <style type="text/css">
          .nav 
          {
            display: -ms-flexbox;
            display: flex;
            -ms-flex-wrap: wrap;
            flex-wrap: wrap;
            padding-left: 0;
            margin-bottom: 0;
            list-style: none;
          }

      </style>

    </head>
    <body>
        
        <%
            String airport = application.getAttribute("airport").toString();
            String name = application.getAttribute("name").toString();
            %>
        
<!--        <h1>Welcome <%= name %> </h1>
        <h2><%= airport %></h2>
        <h3><%= session.getAttribute("username") %></h3>
        
        -Logout
        -Transfer from one database to another
        -Pictures
        -admin account    -->
            
        <!--navbar--> 
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
          <a class="navbar-brand" href="index.jsp">AAI</a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>

          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
              <li class="nav-item">
                <a class="nav-link" href="index.jsp">Home <span class="sr-only">(current)</span></a>
              </li>
              <li class="nav-item">
                  <a class="nav-link" data-toggle="modal" data-target="#accountinfo" href="">My Account</a>                                
              </li>
            </ul>
              <ul class="navbar-nav">
              <li class="nav-item">
                  <a class="btn btn-outline-light my-2 my-sm-0" href="index.jsp"><span class="glyphicon glyphicon-log-in"></span> Logout </a>
              </li>
            </ul>
          </div>
        </nav>
            
        <div class="modal fade" id="accountinfo">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <h3>Account Information</h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>        
              <div class="modal-body">
                <h4 class="text-muted">Name of the account holder : <span class="text-success"><%= name %></span></h4>
              </div>
              <div class="modal-footer">
                <h4 class="text-muted">Name of the Airport : <span class="text-success"><%= airport %></span></h4>
              </div>
            </div>
          </div>
        </div>
            
            
        <div class="container-fluid">
            <div class="row">
                <div class="">
                    <br><br><br>
                    <center><h2>Previous Entries</h2></center>
                    
                    <div class="col-sm-12">
                        <ul class="list-group-flush">
                    
                            <!--Initiative Table-->
                            <li class="list-group-item">
                                <button class="btn btn-link" data-toggle="collapse" data-target="#initiative_table">Initiative</button>
                                <div class="collapse" id="initiative_table" aria-expanded="false">
                                    <table class="table table-hover table-bordered">
                                        <tr>
                                            <th>Date</th>
                                            <th colspan="5">Initiative</th>
                                        </tr>
                                        <tr>

                                            <%
                                                int count = 0;
                                                Class.forName("com.mysql.jdbc.Driver");
                                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql?aai","root","kaka");
                                                PreparedStatement stmt = con.prepareStatement("select * from initiative where airport=? order by date DESC");
                                                stmt.setString(1, airport);
                                                ResultSet rs = stmt.executeQuery();
                                                while(rs.next())
                                                {
                                                    String initiative_name = rs.getString(1);
                                                    String initiative_about = rs.getString(3);
                                                    Date initiative_date = rs.getDate(4);
                                                    int initiative_id = rs.getInt(5);
                                            %>

                                            <td><%= initiative_date %></td>
                                            <td><%= initiative_name %></td>
                                            <td>
                                                <button class="btn btn-outline-success" data-toggle="collapse" data-target="#view<%= count %>">View</button>
                                                
                                                <div class="collapse fade" id="view<%= count %>">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">

                                                            <div class="modal-header"><h3><%= initiative_name %></h3></div>

                                                            <div class="modal-body"><%= initiative_about %></div>

                                                            <div class="modal-footer"><h4 class="text-muted"><%= airport %></h4></div>

                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <button class="btn btn-outline-info" data-toggle="collapse" data-target="#edit<%= count %>">Edit</button>
                                                
                                                <div class="collapse fade" id="edit<%= count %>">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">

                                                            <form action="EditInitiative">
                                                                <div class="modal-header">
                                                                    <input type="text" name="project_name" value="<%= initiative_name %>" maxlength="50" required style="width: 100%;" />
                                                                </div>

                                                                <div class="modal-body">
                                                                    <input type="hidden" value="<%= initiative_id %>" name="project_id" />
                                                                    <textarea maxlength="1000" name="project_desc" rows="5" cols="40"><%= initiative_about %></textarea>
                                                                </div>

                                                                <div class="modal-footer">
                                                                    <input type="text" value="<%= airport %>" disabled style="cursor: not-allowed; width: 100%;" />
                                                                    <button type="submit" class="btn btn-outline-dark">Edit Changes</button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>                                                                                                
                                            </td>
                                            <td><a href="DeleteInitiative?<%= initiative_id %>" class="btn btn-outline-danger">Delete</a></td>
                                            <td>
                                                <button class="btn btn-outline-dark" data-toggle="collapse" data-target="#transfer<%= count %>">Transfer</button>
                                                
                                                <div class="collapse fade" id="transfer<%= count %>">
                                                    <div class="jumbotron">
                                                        <form action="TransferInitiative" method="post" enctype="multipart/form-data">
                                                            <div class="form-group">
                                                                <label for="img1">Upload Image 1</label>
                                                                <input type="file" id="img1" name="img1" accept="image/*">
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="img2">Upload Image 2</label>
                                                                <input type="file" id="img2" name="img2" accept="image/*">
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="img3">Upload Image 3</label>
                                                                <input type="file" id="img3" name="img3" accept="image/*">
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="img4">Upload Image 4</label>
                                                                <input type="file" id="img4" name="img4" accept="image/*">
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="img5">Upload Image 5</label>
                                                                <input type="file" id="img5" name="img5" accept="image/*">
                                                            </div>
                                                            <div class="form-group">
                                                                <input type="submit" class="btn btn-outline-dark">
                                                                <input type="reset" class="btn btn-outline-dark">
                                                            </div>
                                                            <div class="form-group">
                                                                <input type="hidden" value="<%= airport %>" name="airport_name" />
                                                                <input type="hidden" value="<%= initiative_name %>" name="initiative_name" />
                                                                <input type="hidden" value="<%= initiative_about %>" name="initiative_about" />
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>                                                                                                
                                                
                                            </td>
                                        </tr>

                                            <%
                                                count++;
                                                }
                                            %>

                                    </table>
                                </div>
                            </li>

                            <!--Under Development Table-->                
                            <li class="list-group-item">
                                <button class="btn btn-link" data-toggle="collapse" data-target="#underdevelopment_table">Under Development</button>
                                <div class="collapse" id="underdevelopment_table" aria-expanded="false">
                                    <table class="table table-hover table-bordered">
                                        <tr>
                                            <th>Date</th>
                                            <th colspan="5">Project Name</th>
                                        </tr>
                                        <tr>

                                            <%
                                                PreparedStatement stmt1 = con.prepareStatement("select * from underdevelopment where airport=? order by date DESC");
                                                stmt1.setString(1, airport);
                                                ResultSet rs1 = stmt1.executeQuery();
                                                while(rs1.next())
                                                {
                                                    String underdevelopment_name = rs1.getString(1);
                                                    String underdevelopment_about = rs1.getString(3);
                                                    Date underdevelopment_date = rs1.getDate(4);
                                                    int underdevelopment_id = rs1.getInt(5);
                                            %>

                                            <td><%= underdevelopment_date %></td>
                                            <td><%= underdevelopment_name %></td>
                                            <td>
                                                <button class="btn btn-outline-success" data-toggle="collapse" data-target="#view<%= count %>">View</button>
                                                
                                                <div class="collapse fade" id="view<%= count %>">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">

                                                            <div class="modal-header"><h3><%= underdevelopment_name %></h3></div>

                                                            <div class="modal-body"><%= underdevelopment_about %></div>

                                                            <div class="modal-footer"><h4 class="text-muted"><%= airport %></h4></div>

                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <button class="btn btn-outline-info" data-toggle="collapse" data-target="#edit<%= count %>">Edit</button>
                                                
                                                <div class="collapse fade" id="edit<%= count %>">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">

                                                            <form action="EditUnderDevelopment">
                                                                <div class="modal-header">
                                                                    <input type="text" name="project_name" value="<%= underdevelopment_name %>" maxlength="50" required style="width: 100%;" />
                                                                </div>

                                                                <div class="modal-body">
                                                                    <input type="hidden" value="<%= underdevelopment_id %>" name="project_id" />
                                                                    <textarea maxlength="1000" name="project_desc" rows="5" cols="40"><%= underdevelopment_about %></textarea>
                                                                </div>

                                                                <div class="modal-footer">
                                                                    <input type="text" value="<%= airport %>" disabled style="cursor: not-allowed; width: 100%;" />
                                                                    <button type="submit" class="btn btn-outline-dark">Edit Changes</button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td><a href="DeleteUnderDevelopment?<%= underdevelopment_id %>" class="btn btn-outline-danger">Delete</a></td>
                                            <td>

                                                <button class="btn btn-outline-dark" data-toggle="collapse" data-target="#transfer<%= count %>">Transfer</button>
                                                
                                                <div class="collapse fade" id="transfer<%= count %>">
                                                    <div class="jumbotron">
                                                        <form action="TransferCompleted" method="post" enctype="multipart/form-data">
                                                            <div class="form-group">
                                                                <label for="video">Upload Video</label>
                                                                <input type="file" id="video" name="video" accept="video/*">
                                                            </div>
                                                            <div class="form-group">
                                                                <input type="submit" class="btn btn-outline-dark">
                                                                <input type="reset" class="btn btn-outline-dark">
                                                            </div>                                                            
                                                            <div class="form-group">
                                                                <input type="hidden" value="<%= airport %>" name="airport_name" />
                                                                <input type="hidden" value="<%= underdevelopment_name %>" name="underdevelopment_name" />
                                                                <input type="hidden" value="<%= underdevelopment_about %>" name="underdevelopment_about" />
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>                                                                                                
                                                
                                            </td>                                        
                                        </tr>

                                            <%
                                                count++;
                                                }
                                            %>

                                    </table>
                                </div>
                            </li>

                            <!--Completed Table-->                
                            <li class="list-group-item">
                                <button class="btn btn-link" data-toggle="collapse" data-target="#completed_table">Completed</button>
                                <div class="collapse" id="completed_table" aria-expanded="false">
                                    <table class="table table-hover table-bordered">
                                        <tr>
                                            <th>Date</th>
                                            <th colspan="4">Project Name</th>
                                        </tr>
                                        <tr>

                                            <%
                                                PreparedStatement stmt2 = con.prepareStatement("select * from completed where airport=? order by date DESC");
                                                stmt2.setString(1, airport);
                                                ResultSet rs2 = stmt2.executeQuery();
                                                while(rs2.next())
                                                {
                                                    String completed_name = rs2.getString(1);
                                                    String completed_about = rs2.getString(3);
                                                    Date completed_date = rs2.getDate(4);
                                                    int completed_id = rs2.getInt(5);
                                            %>

                                            <td><%= completed_date %></td>
                                            <td><%= completed_name %></td>
                                            <td>
                                                <button class="btn btn-outline-success" data-toggle="collapse" data-target="#view<%= count %>">View</button>
                                                
                                                <div class="collapse fade" id="view<%= count %>">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">

                                                            <div class="modal-header"><h3><%= completed_name %></h3></div>

                                                            <div class="modal-body"><%= completed_about %></div>

                                                            <div class="modal-footer"><h4 class="text-muted"><%= airport %></h4></div>

                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <button class="btn btn-outline-info" data-toggle="collapse" data-target="#edit<%= count %>">Edit</button>
                                                
                                                <div class="collapse fade" id="edit<%= count %>">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">

                                                            <form action="EditCompleted">
                                                                <div class="modal-header">
                                                                    <input type="text" name="project_name" value="<%= completed_name %>" maxlength="50" required style="width: 100%;" />
                                                                </div>

                                                                <div class="modal-body">
                                                                    <input type="hidden" value="<%= completed_id %>" name="project_id" />
                                                                    <textarea maxlength="1000" name="project_desc" rows="5" cols="40"><%= completed_about %></textarea>
                                                                </div>

                                                                <div class="modal-footer">
                                                                    <input type="text" value="<%= airport %>" disabled style="cursor: not-allowed; width: 100%;" />
                                                                    <button type="submit" class="btn btn-outline-dark">Edit Changes</button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>                                                                                                
                                            </td>
                                            <td><a href="DeleteCompleted?<%= completed_id %>" class="btn btn-outline-danger">Delete</a></td>
                                        </tr>

                                            <%
                                                count++;
                                                }
                                            %>

                                    </table>
                                </div>
                            </li>
                                    
                        </ul>           
                    </div>            
                                    
                </div>
            </div>
        </div>
        
        
        <div class="container">
            
            <button class="btn btn-lg btn-primary" data-toggle="collapse" data-target="#newentry">Add new Entry</button> 
                        
            <div class="collapse" id="newentry" aria-expanded="false">
                <div class="jumbotron col-md-6" style="border-style: double;">
                    <form action="AddEntry" method="GET">
                        <input type="hidden" value="<%= airport %>" name="airport_name"/>  
                      <div class="form-group">
                        <label for="name">Project Name (50 characters only)</label>
                        <input type="text" maxlength="50" class="form-control" id="name" name="project_name" required>
                      </div>
                      <div class="form-group">
                        <label for="about">Project Description (1000 characters only)</label>
                        <textarea rows="4" maxlength="1000" class="form-control" id="about" name="project_desc"></textarea>
                      </div>
                      <div class="form-group">
                        <label for="category">Choose Category (select one):</label>
                        <select class="form-control" id="category" name="project_category">
                          <option>Initiative</option>
                          <option>Under Development</option>
                          <option>Completed</option>
                        </select>
                      </div>
<!--                      <div class="form-group">
                        <label for="file">Upload File</label>
                        <input type="file" id="file">
                      </div>-->
                      <div class="form-group">
                        <center>
                            <input type="submit" class="btn btn-outline-dark">
                            <input type="reset" class="btn btn-outline-dark">
                        </center>
                      </div>
                    </form>
                </div>
            </div>
            
        </div>
                                            
        
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

        <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

        <script src="js/resume.min.js"></script>
        
    </body>
</html>

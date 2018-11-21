<%-- 
    Document   : admin
    Created on : 26 Jul, 2018, 9:17:15 PM
    Author     : Dell
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin portal</title>
        
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

        <%--<%= session.getAttribute("username") %>--%>        
        
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
                <h4 class="text-muted">Username : <span class="text-success">admin</span></h4>
                <h4 class="text-muted">Password : <span class="text-success">admin</span></h4>
              </div>
            </div>
          </div>
        </div>
        
        <br><br><br>
        
        <div class="container">
            
            <div class="row">
                <table class="table table-hover table-bordered">
                    <tr>
                        <th>Airport Name</th>
                        <th>Name</th>
                        <th>Username</th>
                        <th>Password</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                    <tr>
                        <%
                            int count = 0;
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql?aai","root","kaka");
                            Statement stmt = con.createStatement();
                            ResultSet rs = stmt.executeQuery("select * from login order by airport");
                            while(rs.next())
                            {
                                String username = rs.getString(1);
                                String password = rs.getString(2);
                                String name = rs.getString(3);
                                String airport = rs.getString(4);
                        %>
                        <td><%= airport %></td>
                        <td><%= name %></td>
                        <td><%= username %></td>
                        <td><%= password %></td>
                        <td>
                            <button class="btn btn-outline-info" data-toggle="modal" data-target="#edit<%= count %>">Edit</button>
                                                
                            <div class="modal fade" id="edit<%= count %>">
                                <div class="modal-dialog">
                                    <div class="modal-content">

                                        <form action="EditOperator" method="post">
                                            <div class="modal-header">
                                                <input type="text" name="airport_name" value="<%= airport %>" maxlength="50" required style="width: 100%" />
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>

                                            <div class="modal-body">
                                                <div class="form-group">
                                                    <label for="name">Name</label>
                                                    <input type="text" name="name" id="name" value="<%= name %>" maxlength="50" required class="form-control" />
                                                </div>
                                                <div class="form-group">
                                                    <!--<label for="username">Username</label>-->
                                                    <input type="hidden" name="unm" id="username" value="<%= username %>" />
                                                </div>
                                                <div class="form-group">
                                                    <label for="password">Password</label>
                                                    <input type="text" name="pwd" id="password" value="<%= password %>" maxlength="50" required class="form-control" />
                                                </div>
                                            </div>

                                            <div class="modal-footer">
                                                <button type="submit" class="btn btn-outline-dark">Edit Changes</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>                                                                                                
                            
                        </td>
                        <td><a href="DeleteOperator?<%= username %>" class="btn btn-outline-danger">Delete</a></td>
                    </tr>
                        <%
                            count++;
                            }
                        %>
                </table>
            </div>
                
                <div>
                    <button class="btn btn-lg btn-primary" data-toggle="collapse" data-target="#newoperator">Add new Entry</button>
                    
                    <div class="collapse" id="newoperator" aria-expanded="false">
                        <div class="jumbotron col-md-6" style="border-style: double;">
                            <form action="AddOperator" method="POST">
                              <div class="form-group">
                                <label for="username">Username (50 characters only)</label>
                                <input type="text" maxlength="50" class="form-control" id="username" name="username" required>
                              </div>
                              <div class="form-group">
                                <label for="name">Name (50 characters only)</label>
                                <input type="text" maxlength="50" class="form-control" id="name" name="name" required>
                              </div>
                              <div class="form-group">
                                <label for="password">Password (50 characters only)</label>
                                <input type="text" maxlength="50" class="form-control" id="password" name="password" required>
                              </div>
                              <div class="form-group">
                                <label for="airport_name">Airport Name</label>
                                <input type="text" maxlength="50" class="form-control" id="airport_name" name="airport_name" required>
                              </div>
                                <center>
                                    <input type="submit" class="btn btn-outline-dark">
                                    <input type="reset" class="btn btn-outline-dark">
                                </center>
                              </form>
                            </div>
                        </div>
                    
                    </div>
                              
                    </div>        
        
        
        
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

        <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

        <script src="js/resume.min.js"></script>
        
    </body>
</html>

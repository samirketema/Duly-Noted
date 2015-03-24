<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Search.aspx.cs" Inherits="Template" %>


<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang=""> <!--<![endif]-->
    <head runat="server">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title></title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="apple-touch-icon" href="apple-touch-icon.png">

        <link rel="stylesheet" href="css/bootstrap.min.css">
        <style>
            body {
                padding-top: 50px;
                padding-bottom: 20px;
            }
        </style>
        <link rel="stylesheet" href="css/bootstrap-theme.min.css">
        <link rel="stylesheet" href="css/main.css">

        <script src="js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>


    </head>
    <body>
        <!--[if lt IE 8]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="Default.aspx">Duly Noted</a>
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
        <div id="navbarRight" class="navbar-form navbar-right" role="form" runat="server">
        </div>
        </div><!--/.navbar-collapse -->
      </div>
    </nav>
        <!-- Docs page layout -->

    <div class="container">
        <div class="bs-docs-header" id="content">
          <div class="container">
          <form id="form1" runat="server">
              <h1>Search for Notes</h1>
              <table>
                <tr>
                    <td>Subject: </td>
                    <td><asp:TextBox ID="txtSubject" runat="server"></asp:TextBox></td>
                    <td><asp:Button ID="btnCheckSubject" runat="server" OnClick="btnCheckSubject_Click" Text="Check"/> </td>
                    <td><asp:Label ID="lblError" runat="server" /></td>
                </tr>
                <tr>
                    <td>Course Number: </td>
                    <td><asp:DropDownList ID="ddlCourseNumber" runat="server" Enabled="False" OnSelectedIndexChanged="course_select" AutoPostBack="True">
                            <asp:ListItem Value="">Course Number</asp:ListItem>
                        </asp:DropDownList>           
                    </td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>Section: </td>
                    <td><asp:DropDownList ID="ddlSection" runat="server" Enabled="False" AutoPostBack="True">
                            <asp:ListItem Value="">Section Number</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td><asp:Button ID="btnSearch" runat="server" Enabled="False" OnClick="btnSearch_Click" Text="Search" /></td>
                    <td></td>
                    <td></td>
                </tr>                
            </table>
            <div>
                <!-- populate data -->
            </div>
          </form>
          </div>
        </div>
    </div>
    <!-- Main jumbotron for a primary marketing message or call to action -->
<%--    <div class="jumbotron">
      <div class="container">
        <h1>Missed a class?</h1>
        <p>Duly Noted is a tool where you can search, upload, and download notes for your classes to create a collaborative educational environment with your classmates.</p>
        <p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more &raquo;</a></p>
      </div>
    </div>--%>


<%--    <div class="container">
      <!-- Example row of columns -->
      <div class="row">
        <div class="col-md-4">
          <h2>Heading</h2>
          <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
          <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
        </div>
        <div class="col-md-4">
          <h2>Heading</h2>
          <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
          <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
       </div>
        <div class="col-md-4">
          <h2>Heading</h2>
          <p>Donec sed odio dui. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>
          <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
        </div>
      </div>--%>

      <hr>

      <footer>
        <p>&copy; Duly Noted 2015</p>
      </footer>
    <!-- /container -->        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.11.2.min.js"><\/script>')</script>

        <script src="js/vendor/bootstrap.min.js"></script>

        <script src="js/main.js"></script>

    
    </body>
</html>

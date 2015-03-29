﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

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
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="Default.aspx">Duly Noted</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
        <form id="form1" class="navbar-form navbar-right" role="form" runat="server">

            <asp:LinkButton ID="LinkButton2" runat="server" OnClick ="lnkMember_Click" Text="Members Profile" CssClass="btn btn-primary"/>
            <asp:LinkButton ID="LinkButton1" runat="server" OnClick ="btnSignUp_Click" Text="Register" CssClass="btn btn-primary"/>
            <asp:LinkButton ID="lnkLogin" runat="server" OnClick="lnkLogin_Click" Text="Login" CssClass="btn btn-primary" />
            <asp:LinkButton ID="lnkLogout" runat="server" OnClick="lnkLogout_Click" Visible="False" Text= "Logout" CssClass="btn btn-primary" />
        </form>
        </div><!--/.navbar-collapse -->
      </div>
    </nav>

    <!-- Main jumbotron for a primary marketing message or call to action -->
    <div class="jumbotron">
      <div class="container">
        <h1>Missed a class?</h1>
        <p>Duly Noted is a tool where you can find and share notes for classes to make studying that much easier.</p>
        <p><a class="btn btn-primary btn-lg" href="About.aspx" role="button">Learn more &raquo;</a></p>

        <asp:Label ID="lblWelcome" runat="server"></asp:Label>
      </div>
    </div>


    <div class="container">
      <!-- Example row of columns -->
      <div class="row">
        <div class="col-md-4">
          <h2>Find Notes</h2>
          <p>See if your class is on Duly Noted.</p>
         <p><a class="btn btn-default" href="Search.aspx" role="button">Search &raquo;</a></p>
        </div>
        <div class="col-md-4">
          <h2>Post Notes</h2>
          <p>Share notes with your classmates. </p>
          <p><a class="btn btn-default" href="Upload.aspx" role="button">Upload &raquo;</a></p>
       </div>
        <div class="col-md-4">
          <h2>Download Notes</h2>
          <p>Download notes for your class.</p>
          <p><a class="btn btn-default" href="#" role="button">Download &raquo;</a></p>
        </div>
      </div>

      <hr>

      <footer>
        <p>&copy; Duly Noted 2015</p>
      </footer>
    </div> <!-- /container -->        
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.11.2.min.js"><\/script>')</script>
        <script src="js/vendor/bootstrap.min.js"></script>
        <script src="js/main.js"></script>

    </body>
</html>

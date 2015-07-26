<%@ Page Language="C#" AutoEventWireup="true" CodeFile="About.aspx.cs" Inherits="About" %>


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
    <form id="form1" role="form" runat="server">
        <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
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
                <ul class="nav navbar-nav navbar-right">
                <li><asp:LinkButton ID="lnkMember" runat="server" OnClick="lnkMember_Click">Your Profile</asp:LinkButton></li>
                <li><asp:LinkButton ID="lnkRegister" runat="server" OnClick="btnSignUp_Click">Register</asp:LinkButton></li>
                <li><asp:LinkButton ID="lnkLogin" runat="server" OnClick="lnkLogin_Click">Login</asp:LinkButton></li>
                <li><asp:LinkButton ID="lnkLogout" runat="server" OnClick="lnkLogout_Click" Visible="False">Logout</asp:LinkButton></li>
              </ul>

            
            </div><!--/.navbar-collapse -->
          </div>
        </div>

    <div class="container">
        <div class="bs-docs-header" id="content">
          <div class="container">
            <h1>What is Duly Noted?</h1>
            <h3>Nearly everyone has either missed class, lost their notes, fallen asleep during class, etc. and when that happens, Duly Noted is their to help.<br />
                Duly Noted is a website through which the students of UCF can share their class notes; furthering their education and creating a more connected community.<br />
                Users can upload and download notes; helping themselves and the student body. </h3>
          </div>
        </div>
    </div>

      <hr>

      <footer>
        <p>&copy; <asp:LinkButton ID="lnkAdmin" runat="server" Text="Duly Noted 2015" EnableTheming="True" EnableViewState="False" ForeColor="Black" OnClick="lnkAdmin_Click"/></p>
      </footer>
      <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
      <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.11.2.min.js"><\/script>')</script>
      <script src="js/vendor/bootstrap.min.js"></script>
      <script src="js/main.js"></script>
    </form>
    </body>
</html>


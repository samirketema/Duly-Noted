<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

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
    <form id="form1" runat="server">
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

      </div>
    </nav>
        <!-- Docs page layout -->

    <div class="container">
        <div class="bs-docs-header" id="content">
          <div class="container">
            <h1>Login</h1>
            <p>Login to study-resource wonderland!</p>
                <div class="form-group col-lg-4">
				    <label>Email</label>
                    <asp:TextBox  runat="server" id="txtEmail" CssClass="form-control" value="" />


                    <br/>
                    <label>Password</label>
                    <asp:TextBox  runat="server" type="password" id="txtPassword" CssClass="form-control" TextMode="Password" />
                    <br />
                    <asp:Button runat="server" ID="btnLogin" Text="Login" OnClick="btnLogin_Click" CssClass="btn btn-primary"/>
                    <asp:LinkButton ID="lnkRegister" runat="server" OnClick="lnkRegister_Click" Text="Register" CssClass="btn btn-primary" />
                    

				</div>
                  

                 
                 <br /> <br />
                 <asp:Label runat="server" ID="lblError"></asp:Label>
                 <br /> <br />
                 <asp:LinkButton ID="lnkForgotPass" runat="server" OnClick="lnkForgotPass_Click" Visible="False">Forgot Password?</asp:LinkButton>
                   
          </div>
        </div>
    </div>


      <hr>

      <footer>
        <p>&copy; Duly Noted 2015</p>
      </footer>
          
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.11.2.min.js"><\/script>')</script>
        <script src="js/vendor/bootstrap.min.js"></script>
        <script src="js/main.js"></script>
    </form>
    </body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Member.aspx.cs" Inherits="Member" %>

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
            <h1>Member Portal</h1>
                <form id="form1" runat="server">
                  <div id="div_Notlogin" runat ="server" visible ="True">
                    <div class="container">
                        <h1>You are not logged in!</h1>
                        <p>You should be redirected to the Duly Noted Login page shortly.</p>
                        <p>If not, click the link below.</p>
                        <p><a class="btn btn-primary btn-sm" href="Login.aspx?ReturnURL=Member.aspx" role="button">Login &raquo;</a></p>
                    </div>
                  </div>


                    <div id="div1" runat="server" visible="False">
                        <table>
                            <tr>
                                <td>Welcome:</td>
                                <td><asp:Label ID="lblDisplayname" runat="server"/></td>
                            </tr>
                            <tr>
                                <td></td>
                            </tr>

                        </table>
                        <br />
                        <br />
                        <asp:LinkButton ID="lnkDel" runat="server" OnClientClick="return confirm('Are you sure? This will also delete all your notes.');" OnClick="lnkDel_Click" Text="Delete Account" CssClass="btn btn-primary"/>
                        <br />
                        <br />
                        <asp:LinkButton ID="lnkChangePass" runat="server" OnClick="lnkChangePass_Click" Text="Change Password" CssClass="btn btn-primary" />
                        <br />
                        <br />
                        <asp:LinkButton ID="lnkLogOut" runat="server" OnClick="lnkLogOut_Click" Text="Logout" CssClass="btn btn-primary"/>
    
                    </div>
                 </form>
          </div>
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

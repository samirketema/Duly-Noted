<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Search.aspx.cs" Inherits="Search" %>


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
        <!-- Docs page layout -->

    <div class="container">
        <div class="bs-docs-header" id="content">
          <div class="container">
              <h1>Search for Notes</h1>
              <asp:Label ID="lblError" runat="server" ForeColor="Red"/>
              <br />
                <div class="form-group col-md-2">
                    <label>Subject </label>
                    <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" placeholder="Example: COP"/>
                    <asp:Button ID="btnCheckSubject" runat="server" OnClick="btnCheckSubject_Click" Text="Check" CssClass="btn btn-default btn-sm"/>
                    <br />

                    <label>Course Number </label>
                    <asp:DropDownList ID="ddlCourseNumber" runat="server" Enabled="False" OnSelectedIndexChanged="course_select" AutoPostBack="True" CssClass="form-control">
                        <asp:ListItem Value="">Course Number</asp:ListItem>
                    </asp:DropDownList>           

                    <label>Section </label>
                    <asp:DropDownList ID="ddlSection" runat="server" Enabled="False" OnSelectedIndexChanged="section_select" AutoPostBack="True" CssClass="form-control">
                            <asp:ListItem Value="">Section Number</asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search" Enabled="false" CssClass="btn btn-default btn-sm"/>

                  </div>



              <div id ="divResult" runat="server">

                    <!-- SEARCH RESULT TABLE HERE-->
              </div>
          </div>
        </div>
    </div>

      <hr>

      <footer>
        <p>&copy; Duly Noted 2015</p>
      </footer>
    <!-- /container -->        
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.11.2.min.js"><\/script>')</script>
        <script src="js/vendor/bootstrap.min.js"></script>
        <script src="js/main.js"></script>

    </form>
    </body>
</html>

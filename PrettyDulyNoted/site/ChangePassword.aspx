<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="ChangePassword" %>

<!DOCTYPE html>




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

    <div class="container-fluid">
        <div class="bs-docs-header" id="content">
          <div class="container">
            <h1>Change Password</h1>
                <div class="col-md-6">
                <form id="form1" runat="server">
                    <div class="form-group col-lg-6">
                        <label>Temporary Password</label>
                        <asp:TextBox ID="txtCurrentPass" runat="server" TextMode="Password" CssClass="form-control" value=""/>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Enter Current Password" ForeColor="Red" ControlToValidate="txtCurrentPass" ValidationGroup="grpSubmit" Display="Dynamic"/>
                        <br />
                    </div>

                    <div class="form-group col-lg-6">
                        <label>New Password</label>
                        <asp:TextBox ID="txtNewPass" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Enter New Password" ForeColor="Red" ControlToValidate="txtNewPass" ValidationGroup="grpSubmit" Display="Dynamic"/>
                    </div>
                    <div class="form-group col-lg-6">
                        <label>Repeat New Password</label>
                        <asp:TextBox ID="txtConfirmPass" runat="server" TextMode="Password" CssClass="form-control"/>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please Enter Confirm Password" ForeColor="Red" ControlToValidate="txtConfirmPass" ValidationGroup="grpSubmit" Display="Dynamic"/>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Confirm Password does not match" ControlToCompare="txtNewPass" ControlToValidate="txtConfirmPass" ForeColor="Red" ValidationGroup="grpSubmit" Display="Dynamic"/>
                    
                    </div>
                    <asp:label ID="lblError" runat="server" ForeColor="Red" />
     
                  <asp:Button ID="btnChangePass" runat="server" ValidationGroup="grpSubmit" OnClick="btnChangePass_Click" Text="Submit" CssClass="btn btn-primary"/>

                </form>
                </div>

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
    </body>
</html>

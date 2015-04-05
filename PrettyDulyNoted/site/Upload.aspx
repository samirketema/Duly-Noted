﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Upload.aspx.cs" Inherits="Upload" %>

<!DOCTYPE html>

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
        <link rel="stylesheet" href="css/bootstrap-select.css"/>
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
                <form id="form1" runat="server">
                  <div id="div1" runat="server" visible="False">
                    <br />
                    <h1>Upload Notes</h1>
                    <asp:HyperLink id="hyperlink" runat="server" Target="_blank" NavigateUrl="~Default.aspx" Visible="false">TestLink</asp:HyperLink>
                    <div class="row">
                        <div class="col-sm-5">
                            <div class="alert alert-info alert-dismissible" role="alert">
                              <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                              <span aria-hidden="true">&times;</span></button>
                              <strong>Sharing is caring!</strong> Find your course below and upload! :)
                            </div>
                        </div>
                    </div>
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

                   </div>
                   <div class="container-fluid">         
                    <div class="form-group col-md-4">
                        <label>File Upload:</label>
                        <br />
                        <asp:FileUpload ID="FileUpload1" runat="server" Enabled="False" data-filename-placement="inside"/><br />
                        <br />
                        <label>Title </label>
                        <asp:TextBox ID="NoteTitle" runat="server" Enabled ="False" CssClass="form-control"></asp:TextBox>
                        <br />
                        <label>Description: </label>
                        <asp:TextBox ID="NoteDescription" runat="server" Enabled ="False" CssClass="form-control"></asp:TextBox>
                        <br />
                        <asp:Button ID="UploadButton" runat="server" OnClick="UploadButton_Click" 
                         Text="Upload File" Enabled="False"  CssClass="btn btn-primary" />&nbsp;<br />
                        <br />
                        <asp:Label ID="UploadLabel1" runat="server"></asp:Label>
                        <asp:Label ID="UploadLabel2" runat="server"></asp:Label>
                    </div>
                   </div>   

                  </div>
                 </form>


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
        <script src="js/vendor/bootstrap.file-input.js"></script>
        <script>$(document).ready(function () { $('input[type=file]').bootstrapFileInput(); });</script>
        <script src="js/main.js"></script>>
        <script type="text/javascript">
            $(document).ready(function () {

                $(".selectpicker").selectpicker();

            });
        </script>

    </body>
</html>
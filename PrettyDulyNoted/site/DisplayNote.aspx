﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DisplayNote.aspx.cs" Inherits="DisplayNote" %>


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
            .auto-style2 {
                height: 57px;
            }
            .auto-style3 {
                height: 83px;
            }
            .auto-style4 {
                height: 94px;
            }
            .auto-style5 {
                height: 61px;
            }
            .auto-style6 {
                width: 506px;
            }
            .auto-style7 {
                height: 94px;
                width: 506px;
            }
            .auto-style8 {
                height: 83px;
                width: 506px;
            }
            .auto-style9 {
                height: 57px;
                width: 506px;
            }
            .auto-style10 {
                height: 61px;
                width: 506px;
            }
            .auto-style11 {
                width: 153px;
            }
            .auto-style12 {
                height: 94px;
                width: 153px;
            }
            .auto-style13 {
                height: 83px;
                width: 153px;
            }
            .auto-style14 {
                height: 57px;
                width: 153px;
            }
            .auto-style15 {
                height: 61px;
                width: 153px;
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
                <!-- THIS IS THE BODY OF THE WEBPAGE-->
                <!-- THIS IS THE NOTE INFO -->
                <div id="divNote" runat="server">
                    <h1><asp:Label ID ="lblTitle" runat="server" /></h1>
                    <table>
                        <tr>
                            <td class="auto-style11">Uploader:</td>
                            <td class="auto-style6"> <asp:Label ID="lblUploader" runat="server" /></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="auto-style12">Description:</td>
                            <td class="auto-style7"> <asp:Label ID="lblDescription" runat="server" /></td>
                            <td class="auto-style4"></td>
                        </tr>
                        <tr>
                            <td class="auto-style13">Preview:</td>
                            <td class="auto-style8"> "PREVIEW / THUMBNAIL /&nbsp; sample here"</td>
                            <td class="auto-style3"></td>
                        </tr>
                        <tr>
                            <td class="auto-style14"></td>
                            <td class="auto-style9">
                                <br />
                                <br />
                                <br />
                                Rating:</td>
                            <td class="auto-style2">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style15"></td>
                            <td class="auto-style10">
                                <asp:Button ID="btnUpVote" runat="server" text="Good" Width="146px" OnClick="btnUpVote_Click"/>
                                <asp:Button ID="btnDownVote" runat="server" text="Meh" Width="141px" OnClick="btnDownVote_Click"/>
                                <asp:Button ID="btnFlag" runat="server" text="Inappropriate" Width="194px" OnClick="btnFlag_Click"/></td>
                            <td class="auto-style5">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style11"> 
                                <br />
                                <br />
                            </td>
                            <td class="auto-style6"><asp:Button ID="btnDownload" runat="server" OnClick="btnDownload_Click" Text="View Online" /></td>
                            <td> </td>
                        </tr>
                    </table>
                </div>

                <!-- THIS IS THE COMMENT PART -->
                <div id="divComment" runat="server">

                    <h3>Comments:</h3>
                    <!-- COMMENT COMMENT COMMENT HEREEEEEEEEE -->

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
        <script src="js/main.js"></script>

    </body>
</html>

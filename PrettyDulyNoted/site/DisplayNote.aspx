<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DisplayNote.aspx.cs" Inherits="DisplayNote" %>


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
     <div class="navbar navbar-inverse navbar-fixed-top" role="navigation" runat="server">
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
            <div id="navbar" class="navbar-collapse collapse" runat="server">
                <ul class="nav navbar-nav navbar-right">
                <li><asp:LinkButton ID="lnkMember" runat="server" OnClick="lnkMember_Click">Your Profile</asp:LinkButton></li>
                <li><asp:LinkButton ID="lnkRegister" runat="server" OnClick="btnSignUp_Click">Register</asp:LinkButton></li>
                <li><asp:LinkButton ID="lnkLogin" runat="server" OnClick="lnkLogin_Click">Login</asp:LinkButton></li>
                <li><asp:LinkButton ID="lnkLogout" runat="server" OnClick="lnkLogout_Click" Visible="False">Logout</asp:LinkButton></li>
              </ul>
            </div><!--/.navbar-collapse -->
          </div>
    </div><!-- Docs page layout -->

    <div class="container" runat ="server">
        <div class="bs-docs-header" id="content" runat="server">
          <div class="container" runat="server">            
                <!-- THIS IS THE BODY OF THE WEBPAGE-->
                <!-- THIS IS THE NOTE INFO -->
                <br>
                <div id="divNote" runat="server" class="well">
                    <h1><asp:Label ID ="lblTitle" runat="server" /></h1>
                    <h5><asp:Label ID="lblNoteDate" runat="server" /></h5>
                    <table>
                        <tr>
                            <td ><h6>Uploaded by:</h6></td>
                            <td> <asp:Label ID="lblUploader" runat="server" /></td>
                            
                        </tr>
                        <tr>
                            <td><asp:Button ID ="btnDel" runat="server" Text="Delete Note" OnClientClick="return confirm('Do you want to delete this Note?');" OnClick="btnDel_Click" Visible="False" CssClass="btn btn-default btn-sm"/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td ><h6>Uploaded On:</h6></td>
                            <td > <asp:Label ID="lblUploadedDate" runat="server" /></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <br />
                            </td>
                        </tr>
                        <hr style="width: 100%; color: black; height: 1px; background-color:black;" />
                        <tr>
                            
                            <td >Description:</td>
                            <td > <asp:Label ID="lblDescription" runat="server" /></td>
                            <td ></td>
                        </tr>
                        <tr>
                            <td>
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td >Preview:</td>
                            <td > 
                                <asp:ImageButton runat="server" ID="ibtnPreview" OnClick="ibtnPreview_Click" OnClientClick="target=&quot;_blank&quot;" Height="320px" ImageAlign="Left" Width="320px" />
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td>Rating:</td>
                            <td><br />
                                <asp:LinkButton ID="btnUpVote" runat="server" Text="<span class='glyphicon glyphicon-thumbs-up'></span> Upvote" CssClass="btn btn-primary btn-sm" OnClick="btnUpVote_Click" Enabled="false"></asp:LinkButton>
                                <asp:LinkButton ID="btnDownVote" runat="server" Text="<span class='glyphicon glyphicon-thumbs-down'></span> Downvote" CssClass="btn btn-primary btn-sm" OnClick="btnDownVote_Click" Enabled="false"></asp:LinkButton>
                                <asp:LinkButton ID="btnFlag" runat="server" Text="<span class='glyphicon glyphicon-flag'></span> Flag" CssClass="btn btn-primary btn-sm" OnClick="btnFlag_Click" Enabled="false"></asp:LinkButton>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <br /><br />
                            </td>
                        </tr>
                        <tr>
                            <td ></td>
                            <td>
                                <asp:Button ID="btnView" runat="server" Text="View Online" OnClientClick="target=&quot;_blank&quot;" CssClass="btn btn-default btn-sm" OnClick="btnView_Click" />
                                <asp:Button ID="btnDown" runat="server" OnClick="btnDownload_Click" Text="Download" CssClass="btn btn-default btn-sm" />
                            </td>
                        </tr>
                    </table>
                </div>

                <!-- THIS IS THE COMMENT PART -->
                <div id="divComment" runat="server">
                    <h3>Comments:</h3>                    
                    <asp:Label ID="lblComment" runat="server" Width="500px"></asp:Label>
                    <br />
                    <br />
                    <p> Leave a comment:</p>
                    <p>
                        <asp:TextBox ID="txtCommentTextBox" runat="server" Height="100px"
                            TextMode="MultiLine" Width="500px"></asp:TextBox>
                    </p>
                    <p>
                        <asp:Button ID="PostCommentButton" runat="server" Text="Post Comment"
                            onclick="PostCommentButton_Click" />
                    </p>
                    <!-- COMMENT COMMENT COMMENT HEREEEEEEEEE -->

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

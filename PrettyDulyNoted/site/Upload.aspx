<%@ Page Language="C#" AutoEventWireup="true" runat="server" CodeFile="Upload.aspx.cs" Inherits="Upload" %>

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
                <li><asp:LinkButton ID="lnkMember" runat="server" OnClick="lnkMember_Click" Visible="false">Your Profile</asp:LinkButton></li>
                <li><asp:LinkButton ID="lnkLogout" runat="server" OnClick="lnkLogout_Click" Visible="False">Logout</asp:LinkButton></li>
              </ul>
            </div><!--/.navbar-collapse -->
          </div>
        </div>
        <!-- Docs page layout -->

    <div class="container">
        <div class="bs-docs-header" id="content">
          <div class="container">            
                  
                  <div id="div_Notlogin" runat ="server" visible ="True">
                    <div class="container">
                        <h1>You are not logged in!</h1>
                        <p>You should be redirected to the Duly Noted Login page shortly.</p>
                        <p>If not, click the link below.</p>
                        <p><a class="btn btn-primary btn-sm" href="Login.aspx?ReturnURL=Upload.aspx" role="button">Login &raquo;</a></p>

                    </div>
                  </div>

                  <div id="div1" runat="server" visible="False">
                    <br />
                    <h1>Upload Notes</h1>
                    <asp:HyperLink id="hyperlink" runat="server" Target="_blank" NavigateUrl="~Default.aspx" Visible="false">Your File has been uploaded!</asp:HyperLink>
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
                    <div class="form-group col-md-3">
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
                        <label>Date Notes Taken: </label>
                        <br />

                        <!--- HERE IS THE CALENDAR -->
                        <asp:Calendar ID="Calendar_NoteDate" runat="server" Enabled="False" OnSelectionChanged="Calendar_Change" CssClass="datepicker" WeekendDayStyle-Wrap="True" BackColor="White" BorderColor="Blue" BorderStyle="Solid" DayHeaderStyle-BackColor="#33CC33" BorderWidth="1px" Font-Names="Arial" >

                        
                        
<DayHeaderStyle BackColor="Blue" ForeColor="White"></DayHeaderStyle>

                            <TitleStyle BackColor="#0000CC" ForeColor="White" />

<WeekendDayStyle Wrap="True"></WeekendDayStyle>
                            </asp:Calendar>

                        
                        
                   </div>
                   <div class="container-fluid">         
                    <div class="form-group col-md-4">
                        <label>File Upload:</label>
                        <br />
                        <asp:FileUpload ID="FileUpload1" runat="server" Enabled="False" data-filename-placement="inside"/>
                        <asp:RegularExpressionValidator ID="uplValidator" runat="server" ControlToValidate="FileUpload1" ErrorMessage="only .pdf format is allowed" 
                            ValidationExpression="(.+\.([Pp][Dd][Ff]))" ForeColor="Red" />
                        <br />
                        <label>Title: </label>
                        <asp:TextBox ID="NoteTitle" runat="server" Enabled ="False" CssClass="form-control"/>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter Note Title" ControlToValidate="NoteTitle" ForeColor="Red" ValidationGroup="grpUpload"/>
                        <br />
                        <label>Description: </label>
                        <asp:TextBox ID="NoteDescription" runat="server" Enabled ="False" CssClass="form-control"/>
                        <br />
                        <asp:Button ID="UploadButton" runat="server" OnClick="UploadButton_Click" 
                         Text="Upload File" Enabled="False"  CssClass="btn btn-primary" ValidationGroup="grpUpload"/>&nbsp;<br />
                        <br />
                        <asp:Label ID="UploadLabel1" runat="server"></asp:Label>
                        <asp:Label ID="UploadLabel2" runat="server"></asp:Label>
                    </div>
                   </div>   

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
        <script src="js/vendor/bootstrap.file-input.js"></script>
        <script>$(document).ready(function () { $('input[type=file]').bootstrapFileInput(); });</script>
        <script src="js/main.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {

                $(".selectpicker").selectpicker();

            });
        </script>


    </form>
    </body>
</html>
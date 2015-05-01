<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminPage.aspx.cs" Inherits="Template" %>


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
        <!--[if lt IE 8]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
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
              <div id="div1" runat="server" visible="True" style="width: 100%; overflow: hidden;">

              <h1>Search for Notes</h1>
              <asp:Label ID="lblError" runat="server" ForeColor="Red"/>
                <div class="form-group col-md-2">
                    <label>Subject: </label>
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
                    <asp:Button ID="btnSearch" runat="server" OnClick="btnNoteSearch_Click" Text="Search" Enabled="false" CssClass="btn btn-default btn-sm"/>

                  </div>
              </div>

              <div id="div2" runat="server" visible="True" style="width: 100%; overflow: hidden;">

              <h1>Search for User</h1>
              <asp:Label ID="lblUserError" runat="server" ForeColor="Red"/>
                <div class="form-group col-md-2">
                <label>User ID: </label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"/>
                    <asp:Button ID="btnCheckUsername" runat="server" OnClick="btnCheckUsername_Click" Text="Check" CssClass="btn btn-default btn-sm"/>
                    <br />
                    <br />
                    <asp:Button ID="btnSearchUser" runat="server" OnClick="btnUserSearch_Click" Text="Search" Enabled="false" CssClass="btn btn-default btn-sm"/>
                    <br />
                    <br />

                    <div id ="divUser" runat="server" visible ="false">
                        <asp:Label ID="lblUserName" runat="server" Font-Size="Large" Font-Bold="True" Font-Underline="True" />

                        <br />
                        <asp:Label ID="NoNotesError" runat="server" ForeColor="Red"/>
                        <asp:GridView ID="GridView1" runat="server"
                            AllowSorting ="true" AllowPaging="true" PageSize="20"
                            AutoGenerateColumns="false" DataKeyNames="Title"
                            OnPageIndexChanged="GridView1_PageIndexChanged" 
                            OnPageIndexChanging="GridView1_PageIndexChanging"
                            OnSelectedIndexChanged ="OnSelectedIndexChanged"
                            OnSorted ="GridView1_Sorted"
                            OnSorting="GridView1_Sorting" Width="699px">

                    <Columns>
                        <asp:BoundField DataField ="Title" HeaderText="Note Title"
                            SortExpression="Title" ReadOnly="true" />
                        <asp:BoundField DataField ="nID" HeaderText="Note ID"
                            SortExpression="nID" ReadOnly="true" />                      
                        <asp:BoundField DataField="Flag" HeaderText="Flag"
                            SortExpression="Flag" /> 
                        <asp:HyperLinkField DataNavigateUrlFields="nId" 
                                            DataNavigateUrlFormatString="~/DisplayNote.aspx?Note={0}"
                                            Text="View Note"/>
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="DeleteButton" runat="server" CommandName="Select"
                                    Text="Delete" Enabled="True"  CssClass="btn btn-primary" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                    </Columns>
                    
                </asp:GridView>
                        <br />
                        <asp:Button ID="banBtn" runat="server"  OnClick ="banUser" 
                                    CommandName="Select" Text="Ban User" Visible="True"  CssClass="btn btn-primary" />
                        <asp:Button ID="unbanBtn" runat="server" OnClick ="unbanUser"
                            CommandName="Select" Text="Unban User" Visible="False"  CssClass="btn btn-primary" />

                    </div>
                </div>
               </div>
          </form>
          </div>
        </div>
    </div>

      <footer>
        <p>&copy; Duly Noted 2015</p>
      </footer>
    <!-- /container -->        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.11.2.min.js"><\/script>')</script>

        <script src="js/vendor/bootstrap.min.js"></script>

        <script src="js/main.js"></script>

    
    </body>
</html>

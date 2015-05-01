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
                <li><asp:LinkButton ID="LinkButton1" runat="server" OnClick="lnkLogout_Click" Visible="True">Logout</asp:LinkButton></li>
              </ul>

            
            </div><!--/.navbar-collapse -->
          </div>
        </div>
        <!-- Docs page layout -->

    <div class="container">
        <div class="bs-docs-header" id="content">
          <div class="container">
            <h1>Member Portal</h1>
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
                        <td> <br /></td>
                        <td> </td>
                    </tr>
                    <tr>


                    </tr>
                </table>

                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                    
                    
                </div>

                <div class="col-sm-2">
                    <div class="btn-group btn-group-justified" role="group" aria-label="...">
                      <div class="btn-group" role="group">
                        <asp:Button ID="btnProfile" runat="server" text="Profile" OnClick="btnProfile_Click" CssClass="btn btn-primary"/>
                      </div>
                      <div class="btn-group" role="group">
                        <asp:Button ID="btnNotes" runat="server" text="Notes" OnClick="btnNotes_Click" CssClass="btn btn-primary"/>
                      </div>
                    </div>
                </div>

<%--                        <ul class="nav nav-tabs">
                            <li role="presentation" class="active"><asp:Button ID="btnProfile" runat="server" text="Profile" OnClick="btnProfile_Click" CssClass="tab-content"/>&nbsp;</li>
                            <li role="presentation"><asp:Button ID="btnNotes" runat="server" text="Notes" OnClick="btnNotes_Click" CssClass="btn btn-primary"/></li>
                        </ul>--%>
                <br />
                <br />
                <!-- profile part -->
                <div runat="server" id="divProfile">
                    <div class="well">
                        <h4>Password Management</h4>
                        <div class="panel-body">
                        <asp:label ID="lblError" runat="server" ForeColor="Red" />
                        <label>Current Password</label>
                        <asp:TextBox ID="txtCurrentPass" runat="server" TextMode="Password" CssClass="form-control"/>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Enter Current Password" ForeColor="Red" ControlToValidate="txtCurrentPass" ValidationGroup="grpSubmit" Display="Dynamic"/>
                        <br />
                        <label>New Password</label>
                        <asp:TextBox ID="txtNewPass" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Enter New Password" ForeColor="Red" ControlToValidate="txtNewPass" ValidationGroup="grpSubmit" Display="Dynamic"/>
                        <br />
                        <label>Repeat New Password</label>
                        <asp:TextBox ID="txtConfirmPass" runat="server" TextMode="Password" CssClass="form-control"/>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please Enter Confirm Password" ForeColor="Red" ControlToValidate="txtConfirmPass" ValidationGroup="grpSubmit" Display="Dynamic"/>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Confirm Password does not match" ControlToCompare="txtNewPass" ControlToValidate="txtConfirmPass" ForeColor="Red" ValidationGroup="grpSubmit" Display="Dynamic"/>
                        <br />
                        <asp:Button ID="btnChangePass" runat="server" ValidationGroup="grpSubmit" OnClick="btnChangePass_Click" Text="Change Password" CssClass="btn btn-primary"/>
                        <br />

                        <br />
                        <br />
                        </div>
                        <h4>Account Management</h4> <br />
                        <asp:LinkButton ID="lnkDel" runat="server" OnClientClick="return confirm('Are you sure? This will also delete all your notes.');" OnClick="lnkDel_Click" Text="Delete Account" CssClass="btn btn-primary"/>
                        <br />
                    </div>
                                            
                   
                     
                   <!-- <asp:LinkButton ID="lnkChangePass" runat="server" OnClick="lnkChangePass_Click" Text="Change Password" CssClass="btn btn-primary" />
                    <br />
                    -->                    
                </div>
                <!--Note part -->
                <div runat="server" id="divNotes" class="well">
                    <h4>Note Management</h4>
                    <asp:Label ID="lblResult" runat="server" />
                    <br />
                    <br />
                    <asp:GridView ID="GridView1" runat="server"
                    AllowSorting ="True" AllowPaging="True" PageSize ="10"
                    AutoGenerateColumns="False" DataKeyNames="nId"
                    OnPageIndexChanged="GridView1_PageIndexChanged" 
                    OnPageIndexChanging="GridView1_PageIndexChanging" 
                    OnRowDeleting="GridView1_RowDeleting"
                    OnSorted ="GridView1_Sorted"
                    OnSorting="GridView1_Sorting"  CssClass="table table-hover table-striped" GridLines="None">

                    <Columns>
                        <asp:BoundField DataField ="Subject" HeaderText="Subject"
                            SortExpression="Subject" ReadOnly="true" />
                        <asp:BoundField DataField ="CourseNumber" HeaderText="Course Number"
                            SortExpression="CourseNumber" ReadOnly="true" />
                        <asp:BoundField DataField ="Section" HeaderText="Section"
                             ReadOnly="true" />
                        <asp:BoundField DataField ="Title" HeaderText="Note Title"
                            SortExpression="Title" ReadOnly="true" />
                        <asp:BoundField DataField="UpVote" HeaderText="Up Vote"
                            SortExpression="UpVote" />
                        <asp:BoundField DataField="DownVote" HeaderText="Down Vote"
                            SortExpression="DownVote" />
                        <asp:BoundField DataField="Flag" HeaderText="Flag"
                            SortExpression="Flag" /> 
                        <asp:BoundField DataField="prettyNoteDate" HeaderText="Note Date"
                            SortExpression="NoteDate" />
                        <asp:BoundField DataField="prettyUploadDate" HeaderText="Upload Date"
                            SortExpression="UploadDate" />
                        <asp:HyperLinkField DataNavigateUrlFields="nId" 
                                            DataNavigateUrlFormatString="~/DisplayNote.aspx?Note={0}"
                                            Text="View Note"/> 
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this event?');"/>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                </div>                        
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

    </form>
    </body>
</html>

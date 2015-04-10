<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SearchResult.aspx.cs" Inherits="SearchResult" %>

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
                  <div id="div1" runat="server">
                    <br />
                    <h1>Results</h1>                  
                      <asp:Label ID="lblResult" runat="server" />

                      <asp:ListView runat="server"></asp:ListView>
                      <!-- Body here -->
                      <!-- Body here -->
                      <!-- Body here -->

                       <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="LinqDataSource1">
                           <Columns>
                               <asp:BoundField DataField="title" HeaderText="title" ReadOnly="True" SortExpression="title" />
                               <asp:BoundField DataField="description" HeaderText="description" ReadOnly="True" SortExpression="description" />
                               <asp:BoundField DataField="upVoteCounter" HeaderText="upVoteCounter" ReadOnly="True" SortExpression="upVoteCounter" />
                               <asp:BoundField DataField="downVoteCounter" HeaderText="downVoteCounter" ReadOnly="True" SortExpression="downVoteCounter" />
                               <asp:BoundField DataField="numberTimesFlagged" HeaderText="numberTimesFlagged" ReadOnly="True" SortExpression="numberTimesFlagged" />
                           </Columns>
                      </asp:GridView>
                      <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="DulyDBDataContext" EntityTypeName="" OrderBy="upVoteCounter desc" Select="new (title, description, upVoteCounter, downVoteCounter, numberTimesFlagged)" TableName="Notes" Where="sId == @sId">
                          <WhereParameters>
                              <asp:QueryStringParameter DefaultValue="1" Name="sId" QueryStringField="sId" Type="Int32" />
                          </WhereParameters>
                      </asp:LinqDataSource>



                      <!-- test button -->
                      <asp:Button ID="btnTest" runat="server" Text="TestNote" OnClick="btnTest_Click"/>


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
        <script src="js/main.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {

                $(".selectpicker").selectpicker();

            });
        </script>

    </body>
</html>
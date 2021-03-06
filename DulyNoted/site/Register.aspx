﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>

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
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="Default.aspx">Duly Noted</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">

        </div><!--/.navbar-collapse -->
      </div>
    </nav>



    <div class="container">


    <form id="form1" runat="server" class="form-group">
    <div class="container-fluid">
        <section class="container">
		    <div class="container-page">				
			    <div class="col-md-6">
				    <h3 class="dark-grey">Registration</h3>
				
				    <div class="form-group col-lg-12">
					    <label>Display Name (Username)</label>

                        <asp:TextBox ID="txtDisplayName" runat="server" CssClass="form-control"/>

                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Display Name" ControlToValidate="txtDisplayName" ForeColor="Red" Display="Dynamic" ValidationGroup="grpSubmit"></asp:RequiredFieldValidator>

				    </div>
				
				    <div class="form-group col-lg-6">
					    <label>Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"  CssClass="form-control" />

                  &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPassword" ErrorMessage="Enter a password." ForeColor="Red" Display="Dynamic" ValidationGroup="grpSubmit"></asp:RequiredFieldValidator>

				    </div>
				
				    <div class="form-group col-lg-6">
					    <label>Repeat Password</label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" class="form-control" TextMode="Password" type="password"  CssClass="form-control" />
                        <asp:CompareValidator ErrorMessage="Passwords do not match." ForeColor="Red" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword" runat="server" ID="CompareValidator1" Display="Dynamic" ValidationGroup="grpSubmit"/>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtConfirmPassword" ErrorMessage="Enter your password again." ForeColor="Red" Display="Dynamic" ValidationGroup="grpSubmit"/>

                        <br/>
				    </div>	
                    <div class="form-group col-lg-6">
                        <label>First Name</label>

                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"/>
                                      

                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter your first name." ControlToValidate="txtFirstName" ForeColor="Red" Display="Dynamic" ValidationGroup="grpSubmit"></asp:RequiredFieldValidator>
                   

                    </div>

                    <div class="form-group col-lg-6">
                        <label>Last Name</label>

                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"/>
 
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Enter your last name." ControlToValidate="txtLastName" ForeColor="Red" Display="Dynamic" ValidationGroup="grpSubmit"></asp:RequiredFieldValidator>
                        <br/>
                    </div>

                    
				    <div class="form-group col-lg-12">
					    <label>Email Address</label>
					    <asp:TextBox ID="txtEmail" runat="server" class="form-control" CssClass="form-control" />

                    &nbsp;<asp:RequiredFieldValidator ErrorMessage="Enter Email" Display="Dynamic" ForeColor="Red"
                        ControlToValidate="txtEmail" runat="server" ID="RequiredFieldValidator3" ValidationGroup="grpSubmit" />
                    &nbsp;<asp:RegularExpressionValidator runat="server" Display="Dynamic" 
                        ValidationExpression="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|ucf.edu)\b"
                        ControlToValidate="txtEmail" ForeColor="Red" ErrorMessage="Invalid email address." ID="RegularExpressionValidator1" ValidationGroup="grpSubmit" />
				    
                   </div>
                   <asp:Button Text="Register" runat="server" OnClick="RegisterUser" Width="160px" ValidationGroup="grpSubmit" CssClass="btn btn-primary"/>
			    </div>
		
			    <div class="col-md-6">
				    <h3 class="dark-grey">Terms and Conditions</h3>
				    <p>
                        <p>
				    	1. a) Duly Noted is not associated with the University of Central Florida. <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;b) Duly Noted is for educational purposes only.  
				    </p>
                    <p>
                        2.&nbsp;a) Duly Noted is not responsible for any innaproriate content loaded by users.<br /> 
                        &nbsp;&nbsp;&nbsp;&nbsp;b) Duly Noted reserves the right to delete users who do upload inappropriate<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; materials. <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;c) If the material in question involves illegal or unethical activites (i.e. plagarism)<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the proper authorities will be contacted and all possible charges may be pursued.  
                    </p>
                    <p>
                        3.&nbsp;Bernie Sanders twenty sixteen.
                    </p>
                    <p>
				    	4. a) Do not feed the bears.  <br />                
				    	&nbsp;&nbsp;&nbsp; b) Bears do not want to hug. 
                    </p>
                     <p> 
                        5. Restroom is for customers only.  
                     <p>
                			6. Duly Noted reserves the right to remove any content from the site without<br />
&nbsp;&nbsp;&nbsp; explanation. 
                     </p>
                     <p> 
                			7. Violation of these terms and conditions will result in nothing really but the 
                            <br />
&nbsp;&nbsp;&nbsp; beginning of this sounded good and ominous.
                    </p>
                    <p>
                         &nbsp;&nbsp;&nbsp;&nbsp;
                         By clicking Register, you agree to the Terms and Conditions.
                    </p>
				
			    </div>
		    </div>
	    </section>
    </div>


    </form>

    </div> <!-- /container -->        
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.11.2.min.js"><\/script>')</script>
        <script src="js/vendor/bootstrap.min.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>

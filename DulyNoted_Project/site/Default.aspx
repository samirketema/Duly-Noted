﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h1>DulyNoted</h1>
        <p>This is Homepage</p>
        <div>
        Welcome
        <asp:LoginName ID="LoginName1" runat="server" Font-Bold="true" />
        <br />
    </div>
        <p>
         <asp:LinkButton ID="LinkButton1" runat="server" OnClick ="btnSignUp_Click">Register</asp:LinkButton>
            &nbsp;&nbsp;&nbsp;&nbsp;
        <asp:LoginStatus ID="LoginStatus1" runat="server" />
        </p>
    
    </div>
        <p>
            &nbsp;</p>
        <asp:LinkButton ID="lnkMember" runat="server" OnClick="lnkMember_Click">Member Only Page</asp:LinkButton>
    </form>
</body>
</html>

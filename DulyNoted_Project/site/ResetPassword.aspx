<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ResetPassword.aspx.cs" Inherits="ResetPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        Please Enter your:<br />
        <br />
        Email:<br />
        <asp:TextBox ID="txtEmail" runat="server" Width="202px"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="lblError" runat="server"></asp:Label>
        <br />
        <br />
        <br />
        <asp:Button ID="btnReset" runat="server" OnClick="btnReset_Click" Text="Reset Password" />
    
    </div>
    </form>
</body>
</html>

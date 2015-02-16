<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
        <asp:Login ID="Login1" runat="server" OnAuthenticate= "ValidateUser" Height="271px" Width="621px" />
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" style="margin-left: 4px" ValidationGroup="Login1" Width="618px" />
    </form>
</body>
</html>

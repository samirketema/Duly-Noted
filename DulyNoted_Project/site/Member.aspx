<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Member.aspx.cs" Inherits="Member" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <h1>Member Page</h1>
    <div id="div1" runat="server">
        If you see this text, you are logged in       
    
        <br />
        It means the authentication was successful.<br /><br />
        <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">Return Home</asp:LinkButton>
    
    </div>
    </form>
</body>
</html>

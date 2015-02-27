<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Member.aspx.cs" Inherits="Member" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <h1>Member Page</h1>
    <div id="div1" runat="server" visible="False">
        If you see this text, you are logged in       
    
        <br />
        It means the authentication was successful.<br />
        Want more evident?
        <br />
        Your displayname is:
        <asp:Label ID="lblDisplayname" runat="server"></asp:Label>
        <br />
        <br />
        <asp:LinkButton ID="lnkDel" runat="server" OnClientClick="return confirm('Are you sure?');" OnClick="lnkDel_Click">Delete Account</asp:LinkButton>
        <br />
        <br />
        <asp:LinkButton ID="lnkReturn" runat="server" >Return Home</asp:LinkButton>
    
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:LinkButton ID="lnkLogOut" runat="server" OnClick="lnkLogOut_Click">Logout</asp:LinkButton>
    
    </div>
    </form>
</body>
</html>

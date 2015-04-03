<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Registration_Success.aspx.cs" Inherits="Registration_Success" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Successful Registration</title>
</head>
<body>
    <form id="form1" runat="server">
        <h1>Activation Required</h1>
        <div>
            <asp:Literal ID="ltMessage" runat="server"></asp:Literal>
        </div>
        <br />
        <asp:LinkButton ID="lnkReturn" runat="server" OnClick="lnkReturn_Click">Return Home</asp:LinkButton>
    </form>
</body>
</html>

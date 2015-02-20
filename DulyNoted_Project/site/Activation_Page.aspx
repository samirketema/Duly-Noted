<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Activation_Page.aspx.cs" Inherits="Activation_Page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Literal ID="ltMessage" runat="server" />
        
        <p>
            <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">Back To HomePage</asp:LinkButton>
        </p>
        
    </form>
</body>
</html>

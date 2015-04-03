<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <table align ="center" >
        <tr>
            <td></td>
            <td align="center"><h1>Login</h1></td>
            <td></td>
        </tr>
        <tr>
            <td>Email: </td>
            <td><asp:TextBox runat="server" id="txtEmail" Width="250px"/>  </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>Password: </td>
            <td><asp:TextBox runat="server" id="txtPassword" Width="250px" TextMode="Password"/>  </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td></td>
            <td align="center"> <asp:Label runat="server" ID="lblError">  </asp:Label>
                <asp:LinkButton ID="lnkForgotPass" runat="server" OnClick="lnkForgotPass_Click" Visible="False">Forgot Password?</asp:LinkButton>
            </td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td align="center"><asp:Button runat="server" ID="btnLogin" Text="Login" OnClick="btnLogin_Click" /></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td>
                <asp:LinkButton ID="lnkRegister" runat="server" OnClick="lnkRegister_Click">Click here</asp:LinkButton>
&nbsp;to register.</td>
            <td></td>
        </tr>
    </table>

    <asp:LinkButton ID="lnkReturn" runat="server" OnClick="lnkReturn_Click">Return Home</asp:LinkButton>
    </form>
</body>
</html>

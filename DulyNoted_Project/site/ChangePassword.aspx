<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="ChangePassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table align="center">
            <tr>
                <td></td>
                <td><h1>Change Password</h1></td>
                <td></td>
            </tr>
            <tr>
                <td>current Password:</td>
                <td><asp:TextBox ID="txtCurrentPass" runat="server" TextMode="Password"></asp:TextBox></td>
                <td><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Enter Current Password" ForeColor="Red" ControlToValidate="txtCurrentPass" ValidationGroup="grpSubmit" Display="Dynamic"/></td>
            </tr>
            <tr>
                <td>new Password:</td>
                <td><asp:TextBox ID="txtNewPass" runat="server" TextMode="Password"></asp:TextBox></td>
                <td><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Enter New Password" ForeColor="Red" ControlToValidate="txtNewPass" ValidationGroup="grpSubmit" Display="Dynamic"/></td>
            </tr>
            <tr>
                <td>confirm Password:</td>
                <td><asp:TextBox ID="txtConfirmPass" runat="server" TextMode="Password"/></td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please Enter Confirm Password" ForeColor="Red" ControlToValidate="txtConfirmPass" ValidationGroup="grpSubmit" Display="Dynamic"/>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Confirm Password does not match" ControlToCompare="txtNewPass" ControlToValidate="txtConfirmPass" ForeColor="Red" ValidationGroup="grpSubmit" Display="Dynamic"/>
                </td>
            </tr>
            <tr>
                <td></td>
                <td><asp:label ID="lblError" runat="server" ForeColor="Red" /></td>
                <td></td>

            </tr>
            <tr>
                <td></td>
                <td><asp:Button ID="btnChangePass" runat="server" ValidationGroup="grpSubmit" OnClick="btnChangePass_Click" Text="Submit" /></td>
                <td></td>

            </tr>
        </table>


        
    
    </div>
        <asp:LinkButton ID="lnkReturn" runat="server" OnClick="lnkReturn_Click">Return Home</asp:LinkButton>
    </form>
</body>
</html>

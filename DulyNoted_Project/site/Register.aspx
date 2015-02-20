<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register</title>
    <style type="text/css">
        .auto-style1 {
            width: 258px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <th colspan="3">
                Registration
            </th>
        </tr>
         <tr>
            <td class="auto-style1">
                Email
            </td>
            <td>
                <asp:TextBox ID="txtEmail" runat="server" Width="300px" />
            &nbsp;*</td>
            <td>
                &nbsp;<asp:RequiredFieldValidator ErrorMessage="Enter Email" Display="Dynamic" ForeColor="Red"
                    ControlToValidate="txtEmail" runat="server" ID="RequiredFieldValidator3" />
                &nbsp;<asp:RegularExpressionValidator runat="server" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                    ControlToValidate="txtEmail" ForeColor="Red" ErrorMessage="Invalid email address." ID="RegularExpressionValidator1" />
            </td>
        </tr>
        
        <tr>
            <td class="auto-style1">
                Password
            </td>
            <td>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Width="300px" />
            &nbsp;*</td>
            <td>
                &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPassword" ErrorMessage="Enter Password" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style1">
                Confirm Password
            </td>
            <td>
                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" Width="300px" />
            &nbsp;*</td>
            <td>
                &nbsp;<asp:CompareValidator ErrorMessage="Passwords do not match." ForeColor="Red" ControlToCompare="txtPassword"
                    ControlToValidate="txtConfirmPassword" runat="server" ID="CompareValidator1" />
            </td>
        </tr>
        <tr>
            <td class="auto-style1">
                Display Name</td>
            <td>
                <asp:TextBox ID="txtDisplayName" runat="server" Width="300px" />
            &nbsp;*</td>
            <td>
                &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Display Name" ControlToValidate="txtDisplayName" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style1">
                First Name</td>
            <td>
                <asp:TextBox ID="txtFirstName" runat="server" Width="300px" />
            &nbsp;*</td>
            <td>
                &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter First Name" ControlToValidate="txtFirstName" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style1">
                Last Name</td>
            <td>
                <asp:TextBox ID="txtLastName" runat="server" Width="300px" />
            &nbsp;*</td>
            <td>
                &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Enter Last Name" ControlToValidate="txtLastName" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td class="auto-style1">
            </td>
            <td>
                <asp:Button Text="Submit" runat="server" OnClick="RegisterUser" Width="160px" />
            </td>
            <td>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>

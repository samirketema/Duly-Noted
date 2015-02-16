<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        body
        {
            font-family: Arial;
            font-size: 10pt;
        }
        input
        {
            width: 200px;
        }
        table
        {
            border: 1px solid #ccc;
        }
        table th
        {
            background-color: #F7F7F7;
            color: #333;
            font-weight: bold;
        }
        table th, table td
        {
            padding: 5px;
            border-color: #ccc;
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
            <td>
                Username
            </td>
            <td>
                <asp:TextBox ID="txtUsername" runat="server" />
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter UserName" ControlToValidate="txtUsername" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Password
            </td>
            <td>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" />
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPassword" ErrorMessage="Enter Password" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Confirm Password
            </td>
            <td>
                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" />
            </td>
            <td>
                <asp:CompareValidator ErrorMessage="Passwords do not match." ForeColor="Red" ControlToCompare="txtPassword"
                    ControlToValidate="txtConfirmPassword" runat="server" ID="CompareValidator1" />
            </td>
        </tr>
        <tr>
            <td>
                Email
            </td>
            <td>
                <asp:TextBox ID="txtEmail" runat="server" />
            </td>
            <td>
                <asp:RequiredFieldValidator ErrorMessage="Enter Email" Display="Dynamic" ForeColor="Red"
                    ControlToValidate="txtEmail" runat="server" ID="RequiredFieldValidator3" />
                <asp:RegularExpressionValidator runat="server" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                    ControlToValidate="txtEmail" ForeColor="Red" ErrorMessage="Invalid email address." ID="RegularExpressionValidator1" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Button Text="Submit" runat="server" OnClick="RegisterUser" />
            </td>
            <td>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>

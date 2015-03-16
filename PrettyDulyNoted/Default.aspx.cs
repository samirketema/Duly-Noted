using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["dulyNoted"] != null)
        {
            lblWelcome.Text = "Welcome, your UserId is: " + Session["dulyNoted"].ToString();
            lnkLogin.Visible = false;
            lnkLogout.Visible = true;   
        }
    }

    protected void btnSignUp_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Register.aspx");
    }
    protected void lnkMember_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Member.aspx");
    }
    protected void lnkLogin_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Login.aspx");     

    }
    protected void lnkLogout_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("~/LogoutConfirm.aspx");
    }
}
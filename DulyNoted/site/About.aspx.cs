﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class About : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["dulyNoted"] != null)
        {
            lnkLogin.Visible = false;
            lnkLogout.Visible = true;
            lnkRegister.Visible = false;
            lnkMember.Visible = true;
        }
        else
        {
            lnkLogin.Visible = true;
            lnkLogout.Visible = false;
            lnkRegister.Visible = true;
            lnkMember.Visible = false;
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
        Response.Redirect("Login.aspx?ReturnURL=About.aspx");

    }
    protected void lnkLogout_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("~/LogoutConfirm.aspx");
    }



    protected void lnkAdmin_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/ACPLogin.aspx");
    }
}
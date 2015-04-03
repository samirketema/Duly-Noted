using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class Member : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["dulyNoted"] == null)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                "alert('You are not logged in');window.location ='Login.aspx';", true);
        }
        else      //logged in
        {
            if (!IsPostBack)
            {
                div1.Visible = true;

                //get the information
                DulyDBDataContext dc = new DulyDBDataContext();
                var query = (from u in dc.Users
                             where u.userId == int.Parse(Session["dulyNoted"].ToString())
                             select u).First();

                // display info for fun -- replace by actual features later
                lblDisplayname.Text = query.displayName + " last login: " +  query.lastLoginDate.Value.ToShortDateString() ;
            }

        }
      

    }

    protected void lnkLogOut_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("~/LogoutConfirm.aspx");
    }

    protected void lnkDel_Click(object sender, EventArgs e)
    {
        DulyDBDataContext dc = new DulyDBDataContext();
        var query = (from u in dc.Users
                     where u.userId == int.Parse(Session["dulyNoted"].ToString())
                     select u).First();

        //delete account
        dc.Users.DeleteOnSubmit(query);
        dc.SubmitChanges();

        //abandon session
        Session.Abandon();
        Response.Redirect("~/LogoutConfirm.aspx");

    }

    protected void lnkReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Default.aspx");
    }
    protected void lnkChangePass_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/ChangePassword.aspx");
    }
}
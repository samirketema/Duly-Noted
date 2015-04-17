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
        Page.Header.DataBind();
        if (Session["dulyNoted"] == null)
        {
            div1.Visible = false;
            div_Notlogin.Visible = true;
            //modify this to the current page name
            var returnUrl = "Member.aspx";

            //let the login page know which page to return
            string LoginPageUrl = "Login.aspx?ReturnURL=" + returnUrl;
            Page.Header.Controls.Add(new LiteralControl(string.Format("<META http-equiv=\"REFRESH\" content=\"3;url={0}\" > ", LoginPageUrl)));
        }
        else      //logged in
        {
            if (!IsPostBack)
            {
                div1.Visible = true;
                div_Notlogin.Visible = false;

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

        //get all the note
        var note = from n in dc.Notes
                   where n.userId == query.userId
                   select n;

        //delete note
        dc.Notes.DeleteAllOnSubmit(note);

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
    protected void lnkMember_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Member.aspx");
    }
    protected void lnkLogout_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("~/LogoutConfirm.aspx");
    }
}
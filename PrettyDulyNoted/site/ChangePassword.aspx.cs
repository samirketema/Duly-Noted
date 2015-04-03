using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ChangePassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["dulyNoted"] == null)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                "alert('You are not logged in');window.location ='Login.aspx';", true);
        }
    }
    protected void btnChangePass_Click(object sender, EventArgs e)
    {
        DulyDBDataContext dc = new DulyDBDataContext();

        var query = from u in dc.Users
                     where u.userId == int.Parse(Session["dulyNoted"].ToString()) && u.password == txtCurrentPass.Text
                     select u;
        if (query.Count() > 0)
        {
            var user = query.First();
            user.password = txtNewPass.Text;
            dc.SubmitChanges();
            lblError.Text = "successfully change Password";
        }
        else //no match
        {
            lblError.Text = "Please Check your current password again!";
        }

    }
    protected void lnkReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/default.aspx");
    }
}
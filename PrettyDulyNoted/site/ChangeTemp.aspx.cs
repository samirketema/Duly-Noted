using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ChangeTemp: System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["dulyNoted"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }
        else
        {
            int flag = int.Parse(Request.QueryString["Reset"]);
            if (flag != 0)
                Response.Redirect("~/Member.aspx");
        }
    }

    protected void btnChangePass_Click(object sender, EventArgs e)
    {
        DulyDBDataContext dc = new DulyDBDataContext();

        int userId = int.Parse(Session["dulyNoted"].ToString());
        var query = from r in dc.PasswordRecoveries
                    where r.userId == userId && r.validCode == txtTempPass.Text
                    select r;

        if (query.Count() > 0)
        {
            var user = (from u in dc.Users
                        where u.userId == userId
                        select u).First();

            user.password = txtNewPass.Text;            

            //delete the temp pass
            dc.PasswordRecoveries.DeleteOnSubmit(query.First());

            dc.SubmitChanges();
            lblError.Text = "successfully change Password. You will be redirect to member page shortly";

            //redirect to member
            string PageUrl = "Member.aspx";
            Page.Header.Controls.Add(new LiteralControl(string.Format("<META http-equiv=\"REFRESH\" content=\"3;url={0}\" > ", PageUrl)));

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
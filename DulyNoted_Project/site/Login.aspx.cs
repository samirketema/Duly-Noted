using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//sql and security
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Security;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    
    protected void lnkReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Default.aspx");
    }

    protected void lnkRegister_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Register.aspx");
    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        DulyDBDataContext dc = new DulyDBDataContext();

        //check if user leave blank fields
        if (txtEmail.Text.Trim() != "" && txtPassword.Text.Trim() != "")
        {
            //check if correct email and pass
            var query = from u in dc.Users
                        where u.email == txtEmail.Text && u.password == txtPassword.Text
                        select u;
            if (query.Count() > 0)
            {
                //get the user record (row) from Users table
                var user = query.First();

                //using userId to check if there is any record in UserActivations table
                if (dc.UserActivations.Any(a => a.userId == user.userId))
                    lblError.Text = "Your account has not been activated";
                else //already activate
                {
                    //using session for secured page 
                    Session["dulyNoted"] = user.displayName;

                    //update last login date
                    user.lastLoginDate = DateTime.Now;
                    dc.SubmitChanges();

                    //redirect to member page
                    Response.Redirect("~/Member.aspx");
                }
            }
            else
                lblError.Text = "Please check your Email / password";
        }
        else
        {
            if (txtEmail.Text.Trim() == "")
                lblEmailReq.Text = "Please Enter Your Email";
            if (txtPassword.Text.Trim() != "")
                lblPassReq.Text = "Please Enter Your Password";
        }
    }
}
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
        if (txtAdminId.Text.Trim() != "" && txtPassword.Text.Trim() != "")
        {
            //check if correct email and pass
            var query = from u in dc.Admins
                        where u.adminId == txtAdminId.Text && u.password == txtPassword.Text
                        select u;
            if (query.Count() > 0)
            {
                //get the user record (row) from Users table
                var admin = query.First();               
                
                //using session for secured page 
                Session["Admin"] = admin.adminId;                   

                    //redirect to admin page
                    Response.Redirect("~/AdminPage.aspx");
            }
            else
            {
                lblError.Text = "Please check your Id / password";

            }
        }
    }

    protected void lnkForgotPass_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/ResetPassword.aspx");
    }
}
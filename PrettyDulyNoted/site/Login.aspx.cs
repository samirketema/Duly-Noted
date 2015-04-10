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
            //update 04-06-2015
            //check if the email is banned
            if (dc.BannedEmails.Any(b => b.email == txtEmail.Text))
                lblError.Text = "Your accout has been banned. Please contact customer service!";


            else //not banned
            {
                //query the user table
                var query = from u in dc.Users
                            where u.email == txtEmail.Text && u.password == txtPassword.Text
                            select u;

                //query the temp password table
                var fquery = from f in dc.PasswordRecoveries
                             where f.email == txtEmail.Text && f.validCode == txtPassword.Text
                             select f;

                //check if correct email and pass "Normal login"
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
                        Session["dulyNoted"] = user.userId;

                        //update last login date
                        user.lastLoginDate = DateTime.Now;
                        dc.SubmitChanges();

                        //redirect to previous page
                        string returnUrl = Request.QueryString["ReturnURL"];
                        Response.Redirect("~/"+returnUrl);
                    }
                }
                //if this user has request a forgot password
                else  if (fquery.Count() > 0)
                {
                    var user = fquery.First();
                    //using session for secured page 
                    Session["dulyNoted"] = user.userId;

                    //ask user to change his password
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                    "alert('You Should change your temporary password');window.location ='ChangeTemp.aspx';", true);
                }
                else // this user really has no clue about his account ;)
                {
                        lblError.Text = "Please check your Email / password";
                        lnkForgotPass.Visible = true;
                }
            }            
        }
    }

    protected void lnkForgotPass_Click(object sender, EventArgs e)
    {
        
        Response.Redirect("~/ResetPassword.aspx");
    }
}
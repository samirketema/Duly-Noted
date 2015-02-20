using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

//sql namespace
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

//email verification
using System.Net.Mail;
using System.Net;

public partial class Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    //register button 
    protected void RegisterUser(object sender, EventArgs e)
    {
        int userId = 0;
        string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString; //use str from the web.config
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("Insert_User"))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@password", txtPassword.Text.Trim());
                    cmd.Parameters.AddWithValue("@firstName", txtFirstName.Text.Trim());
                    cmd.Parameters.AddWithValue("@lastName", txtLastName.Text.Trim());
                    cmd.Parameters.AddWithValue("@displayName", txtDisplayName.Text.Trim());
                    cmd.Connection = con;
                    con.Open();
                    userId = Convert.ToInt32(cmd.ExecuteScalar()); //get user ID to check for existed user
                    con.Close();
                }
            }
            string message = string.Empty;
            switch (userId)
            {
                case -1:
                    message = "Display name already exists.\\nPlease choose a different Display name.";
                    break;
                case -2:
                    message = "This email address has already been used.";
                    break;
                default:
                    message = "Registration successful.\\n UserName:" + txtDisplayName.Text + "\\nCHECK YOUR EMAIL HAHAHAH!!";
                    //send activation email
                    SendActivationEmail(userId);

                    //redirect to confirm page
                    string url = "~/Registration_Success.aspx?Email=" + txtEmail.Text.Trim();
                    Response.Redirect(url);
                    break;
            }
            ClientScript.RegisterStartupScript(GetType(), "alert", "alert('" + message + "');", true);
        }
    }


    //activation
    private void SendActivationEmail(int userId)
    {
        string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        string activationCode = Guid.NewGuid().ToString(); //generate the code using Guid
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("INSERT INTO UserActivations VALUES(@userId, @activationCode)"))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = CommandType.Text;
                    //populate data to sql table : UserActivation
                    cmd.Parameters.AddWithValue("@userId", userId);
                    cmd.Parameters.AddWithValue("@activationCode", activationCode);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
        }
        //sending email
        using (MailMessage mm = new MailMessage("dulynoteddeveloperteam@gmail.com", txtEmail.Text))
        {
            mm.Subject = "DulyNoted Account Activation";
            string body = "Hi " + txtDisplayName.Text.Trim() + ",";
            body += "<br /><br />You're one step away from becoming a DulyNoted member.";
            body += "<br/> <br/> Below is your account login information:";
            body += "<br/> email: " + txtEmail.Text.Trim();
            body += "<br/> First Name: " + txtFirstName.Text.Trim();
            body += "<br/> Last Name: " + txtLastName.Text.Trim();
            body += "<br /><br />Please click the following link to activate your account";
            body += "<br /><a href = '" + Request.Url.AbsoluteUri.Replace("Register.aspx", "Activation_Page.aspx?activationCode=" + activationCode) + "'>Click here to activate</a>";
            body += "<br /><br />If you have any problems verifying your account please reply to this email";
            body += "<br /><br />Welcome to DulyNoted";
            body += "<br /> DulyNoted Development Team";
            mm.Body = body;
            mm.IsBodyHtml = true;
            SmtpClient smtp = new SmtpClient();
            //SMTP , using gmail... will switch to our own if if we have time to create our SMTP host.
            smtp.Host = "smtp.gmail.com";
            smtp.EnableSsl = true;
            //lol it the username and password (I know it's not encrypted) for gmail account.
            NetworkCredential NetworkCred = new NetworkCredential("dulynoteddeveloperteam@gmail.com", "DulyPassword");
            smtp.UseDefaultCredentials = true;
            smtp.Credentials = NetworkCred;
            smtp.Port = 587;
            smtp.Send(mm);
        }
    }
}
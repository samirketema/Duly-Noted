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
                    cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
                    cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
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
                    message = "Username already exists.\\nPlease choose a different username.";
                    break;
                case -2:
                    message = "Supplied email address has already been used.";
                    break;
                default:
                    message = "Registration successful.\\n UserName:" + txtUsername.Text + "\\nCHECK YOUR EMAIL HAHAHAH!!";
                    //send activation email
                    SendActivationEmail(userId);
                    Response.Redirect("~/Default.aspx");
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
            using (SqlCommand cmd = new SqlCommand("INSERT INTO UserActivation VALUES(@UserId, @ActivationCode)"))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = CommandType.Text;
                    //populate data to sql table : UserActivation
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@ActivationCode", activationCode);
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
            string body = "Hey" + txtUsername.Text.Trim() + ",";
            body += "<br /><br />Welcome to DulyNoted!";
            body += "<br /><br />Please click the following link to activate your account";
            body += "<br /><a href = '" + Request.Url.AbsoluteUri.Replace("Register.aspx", "Activation_Page.aspx?ActivationCode=" + activationCode) + "'>Click here to go to hell</a>";
            body += "<br /><br />Thanks";
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
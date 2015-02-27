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
        DulyDBDataContext dc = new DulyDBDataContext();
        bool nameCheck = dc.Users.Any(u => u.displayName == txtDisplayName.Text.Trim());
        bool emailCheck = dc.Users.Any(u => u.email == txtEmail.Text.Trim());
       
        string message = string.Empty;

        //check for exist user
        if (nameCheck ) 
                    message = "Display name already exists.\\nPlease choose a different Display name.";
        else if (emailCheck)
                    message = "This email address has already been used.";
        else
        {
            var newUser = new User
            {
                email = txtEmail.Text.Trim(),
                password = txtPassword.Text.Trim(),
                displayName = txtDisplayName.Text.Trim(),
                firstName = txtFirstName.Text.Trim(),
                lastName = txtLastName.Text.Trim(),
                createdDate = DateTime.Now
            };
            dc.Users.InsertOnSubmit(newUser);
            dc.SubmitChanges();

            //send activation email
            SendActivationEmail(newUser.userId);

            //redirect to confirm page
            string url = "~/Registration_Success.aspx?Email=" + txtEmail.Text.Trim();
            Response.Redirect(url);
        }
        ClientScript.RegisterStartupScript(GetType(), "alert", "alert('" + message + "');", true);
        
    }


    //activation
    private void SendActivationEmail(int Id)
    {
        DulyDBDataContext dc = new DulyDBDataContext();
        string nActivationCode = Guid.NewGuid().ToString();//generate the code using Guid
        var activation = new UserActivation
        {
            userId = Id,
            activationCode = nActivationCode
        };
        dc.UserActivations.InsertOnSubmit(activation);
        dc.SubmitChanges();

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
            body += "<br /><a href = '" + Request.Url.AbsoluteUri.Replace("Register.aspx", "Activation_Page.aspx?activationCode=" + nActivationCode + "'>Click here to activate</a>");
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
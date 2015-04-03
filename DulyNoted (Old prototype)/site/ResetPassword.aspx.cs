using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Net.Mail;
using System.Net;

using System.Web.Security;

public partial class ResetPassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        DulyDBDataContext dc = new DulyDBDataContext();

        if (txtEmail.Text.Trim() != "")
        {
            var query = from u in dc.Users
                        where u.email == txtEmail.Text
                        select u;
            if (query.Count() > 0)
            {
                var user = query.First();
                string temp = Membership.GeneratePassword(10, 5);
                //just change the pass ... will make a new table to handle temp pass later------------------------
                user.password = temp;
                dc.SubmitChanges();
                
                //send email
                forgotPass(user.userId, user.displayName, temp);
            }
            else
                lblError.Text = "This email has not been registered";
        }
    }
    protected void forgotPass(int nUserId, string name, string temp)
    {

        //sending email
        using (MailMessage mm = new MailMessage("dulynoteddeveloperteam@gmail.com", txtEmail.Text))
        {
            mm.Subject = "DulyNoted Password Reset";
            string body = "Hi " + name + ",";
            body += "<br /><br />You have requested to reset your password";
            body += "<br/> <br/> This is your temporary pass:";
            body += "<br/> temporary pass:" + temp;
            body += "<br /><br />Please log in and change your password immediately";
            body += "<br /> DulyNoted Development Team";
            mm.Body = body;
            mm.IsBodyHtml = true;
            SmtpClient smtp = new SmtpClient();
            smtp.Host = "smtp.gmail.com";
            smtp.EnableSsl = true;
            NetworkCredential NetworkCred = new NetworkCredential("dulynoteddeveloperteam@gmail.com", "DulyPassword");
            smtp.UseDefaultCredentials = true;
            smtp.Credentials = NetworkCred;
            smtp.Port = 587;
            smtp.Send(mm);
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Net.Mail;
using System.Net;

using System.Web.Security;
using System.Text;
using System.Security.Cryptography;

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

                
                string hashedTemp = hashPassword(temp, user.salt);

                //using userId to check if there is any record in UserActivations table
                if (dc.UserActivations.Any(a => a.userId == user.userId))
                    lblError.Text = "Your account has not been activated";
                else
                {
                    // check the password recoveries table for existed record
                    var recover = from r in dc.PasswordRecoveries
                                  where r.userId == user.userId
                                  select r;

                    //if the user already asked for a temp pass, renew the temp pass
                    if (recover.Count() > 0)
                    {
                        var recoverEdit = recover.First();
                        recoverEdit.validCode = hashedTemp; //assign new pass
                    }
                    else //if this is the first attempt, create a new record
                    {
                        var recoverNew = new PasswordRecovery
                        {
                            userId = user.userId,
                            validCode = hashedTemp,
                            email = user.email
                        };
                        dc.PasswordRecoveries.InsertOnSubmit(recoverNew);
                    }

                    //yep submit the changes.
                    dc.SubmitChanges();

                    //send email
                    forgotPass(user.userId, user.displayName, temp);

                    Response.Redirect("~/Reset_Success.aspx?Email=" + txtEmail.Text);
                }
               
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
            body += "<br/> <br/> This is your temporary password:";
            body += "<br/> temporary password: " + temp;
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




    // hash the password with the salt
    public static string hashPassword(string passWordText, string saltText)
    {
        
        byte[] passwordInBytes = Encoding.UTF8.GetBytes(passWordText);
        byte[] saltInBytes = Convert.FromBase64String(saltText);

        byte[] saltedPasswordInBytes = saltInBytes.Concat(passwordInBytes).ToArray();


        byte[] hash = new SHA256Managed().ComputeHash(saltedPasswordInBytes);

        return Convert.ToBase64String(hash);
    }

}
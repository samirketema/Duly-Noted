using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

//email comments
using System.Net.Mail;
using System.Net;

public partial class Contact : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // check to see if the user is logged in. 
        if (Session["dulyNoted"] != null)
        {
            //get the logged in user's information information
            DulyDBDataContext dc = new DulyDBDataContext();
            var query = (from u in dc.Users
                         where u.userId == int.Parse(Session["dulyNoted"].ToString())
                         select u).First();


            txtName.Text = query.firstName.Trim() +" "+query.lastName.Trim();
            txtEmail.Text = query.email.Trim();

        }
    }


    protected void submitComments(object sender, EventArgs e)
    {
        String email = txtEmail.Text.Trim();

        // put email validation here!!

        sendCommentsEmail(email);

        Response.Redirect("~/ContactSuccess.aspx");
    }


    private void sendCommentsEmail(String email)
    {
        //sending email
        // change the too in this after testing !!!!!!
        using (MailMessage mm = new MailMessage("dulynoteddeveloperteam@gmail.com", "dulynoteddeveloperteam@gmail.com"))
        {
            mm.Subject = "DulyNoted Comments Form";
            string body = "To Duly Noted Admin Group: ";
            body += "<br /><br />"+txtName.Text.Trim() + " has submitted the following comment:";
            body += "<br /><br />"+txtComments.Text.Trim();
            body += "<br/> <br/>";
            body += "<br/>This person can be reached at the following email: " + txtEmail.Text.Trim();
           
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
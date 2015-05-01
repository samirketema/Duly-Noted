using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Security.Cryptography;


public partial class ChangeTemp: System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["dulyNoted"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }
        // This part was giving me an error, so I commented it out.  Not sure what it was for though.
        /*
        else
        {
            int flag = int.Parse(Request.QueryString["Reset"]);
            if (flag != 0)
                Response.Redirect("~/Member.aspx");
        }*/
    }

    protected void btnChangePass_Click(object sender, EventArgs e)
    {
        DulyDBDataContext dc = new DulyDBDataContext();

        int userId = int.Parse(Session["dulyNoted"].ToString());

        // retrieve the salt for the given username
        //query the user table
        var saltQuery = from u in dc.Users
                        where u.userId == userId
                        select u.salt;

        string userSalt = saltQuery.First();



        var query = from r in dc.PasswordRecoveries
                    where r.userId == userId && r.validCode == hashPassword(txtTempPass.Text.Trim(), userSalt)
                    select r;

        if (query.Count() > 0)
        {
            var user = (from u in dc.Users
                        where u.userId == userId
                        select u).First();

            // create a new salt for the new password
            string newSalt = createSalt(24);

            // update password and salt in database
            user.password = hashPassword( txtNewPass.Text.Trim(), newSalt);
            user.salt = newSalt;

            //delete the temp pass
            dc.PasswordRecoveries.DeleteOnSubmit(query.First());

            dc.SubmitChanges();
            lblError.Text = "Successfully changed Password. You will be redirected to member page shortly";

            //redirect to member
            string PageUrl = "Member.aspx";
            Page.Header.Controls.Add(new LiteralControl(string.Format("<META http-equiv=\"REFRESH\" content=\"3;url={0}\" > ", PageUrl)));

        }
        else //no match
        {
            lblError.Text = "Please Check your Temporary password again!";
        }

    }
    protected void lnkReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/default.aspx");
    }



    // create the salt for the password
    private static string createSalt(int size)
    {
        RNGCryptoServiceProvider ranNum = new RNGCryptoServiceProvider();
        byte[] salt = new byte[size];
        ranNum.GetBytes(salt);

        return Convert.ToBase64String(salt);
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
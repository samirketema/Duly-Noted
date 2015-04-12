using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Security.Cryptography;

public partial class ChangePassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["dulyNoted"] == null)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                "alert('You are not logged in');window.location ='Login.aspx';", true);
        }
    }
    protected void btnChangePass_Click(object sender, EventArgs e)
    {
        DulyDBDataContext dc = new DulyDBDataContext();

        // query db using the userID for the password salt
        var saltQuery = from u in dc.Users
                        where u.userId == int.Parse(Session["dulyNoted"].ToString())
                        select u.salt;

        string userSalt = saltQuery.First();

        string hashedPassword = "no";

        // make sure the user was found
        if (saltQuery.Count() > 0)
        {
            // makes sure there was a valid salt
            if (userSalt != null)
                hashedPassword = hashPassword(txtCurrentPass.Text, userSalt);
        }


        var query = from u in dc.Users
                     where u.userId == int.Parse(Session["dulyNoted"].ToString()) && u.password == hashedPassword
                     select u;
        if (query.Count() > 0)
        {
            var user = query.First();

            userSalt = createSalt(24);
            hashedPassword = hashPassword(txtNewPass.Text, userSalt);
            user.password = hashedPassword;
            user.salt = userSalt;
            dc.SubmitChanges();
            lblError.Text = "Successfully changed Password. You will be redirected to member page shortly";

            //redirect to member
            string PageUrl = "Member.aspx";
            Page.Header.Controls.Add(new LiteralControl(string.Format("<META http-equiv=\"REFRESH\" content=\"3;url={0}\" > ", PageUrl)));
        }
        else //no match
        {
            lblError.Text = "Please Check your current password again!";
        }

    }
    protected void lnkReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/default.aspx");
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


    // create the salt for the password
    private static string createSalt(int size)
    {
        RNGCryptoServiceProvider ranNum = new RNGCryptoServiceProvider();
        byte[] salt = new byte[size];
        ranNum.GetBytes(salt);

        return Convert.ToBase64String(salt);
    }

}
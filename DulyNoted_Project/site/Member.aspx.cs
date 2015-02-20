using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class Member : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.Page.User.Identity.IsAuthenticated)
        {
            div1.Visible = false;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                "alert('You are not logged in');window.location ='Login.aspx';", true);
        }

        //logged in
      

    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Default.aspx");
    }
}
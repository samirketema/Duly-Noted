using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Reset_Success : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!this.IsPostBack)
        {
            string email = Request.QueryString["Email"];
            string msg = "You have successfully reset your password.<br/><br/>"+
                "In the next few minutes, you should receive an e-mail with your temporary password.<br/><br/>"+
                "The e-mail will be send to the following address: " + email + "<br/><br/>";
            ltMessage.Text = msg;
        }

    }
    protected void lnkReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Default.aspx");
    }
}
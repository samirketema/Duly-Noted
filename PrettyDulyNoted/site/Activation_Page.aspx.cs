using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class Activation_Page : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            string nActivationCode = !string.IsNullOrEmpty(Request.QueryString["activationCode"]) ? Request.QueryString["activationCode"] : Guid.Empty.ToString();
            DulyDBDataContext dc = new DulyDBDataContext();
            if (dc.UserActivations.Any(a=> a.activationCode == nActivationCode))
            {
                dc.UserActivations.DeleteOnSubmit(dc.UserActivations.Single(d => d.activationCode == nActivationCode));
                dc.SubmitChanges();
                ltMessage.Text = "Activation successful. Welcome to DulyNoted";
            }
            else
                ltMessage.Text = "Invalid Activation code.";
        }
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Default.aspx");
    }
}
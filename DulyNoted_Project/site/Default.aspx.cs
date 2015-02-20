using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace User_Login_CS
{
    public partial class Default
    {
        protected global::System.Web.UI.HtmlControls.HtmlForm form1;
        protected global::System.Web.UI.WebControls.LoginName LoginName1;
        protected global::System.Web.UI.WebControls.Label lblLastLoginDate;
        protected global::System.Web.UI.WebControls.LoginStatus LoginStatus1;
    }
}

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSignUp_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Register.aspx");
    }
    protected void lnkMember_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Member.aspx");
    }
}
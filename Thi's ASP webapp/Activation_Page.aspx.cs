using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

//sql
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

public partial class Activation_Page : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            string activationCode = !string.IsNullOrEmpty(Request.QueryString["ActivationCode"]) ? Request.QueryString["ActivationCode"] : Guid.Empty.ToString();
            using (SqlConnection con = new SqlConnection(constr))
            {
                //SQL query to delete the record from the UserActivation table
                using (SqlCommand cmd = new SqlCommand("DELETE FROM UserActivation WHERE ActivationCode = @ActivationCode"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.Parameters.AddWithValue("@ActivationCode", activationCode);
                        cmd.Connection = con;
                        con.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();
                        con.Close();
                        if (rowsAffected == 1)
                        {
                            ltMessage.Text = "Activation successful. Welcome to DulyNoted";
                        }
                        else
                        {
                            ltMessage.Text = "Invalid Activation code.";
                        }
                    }
                }
            }
        }
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Default.aspx");
    }
}
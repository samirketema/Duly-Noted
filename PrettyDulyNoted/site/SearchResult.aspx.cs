using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SearchResult : System.Web.UI.Page
{

   

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            int sId = (string.IsNullOrEmpty(Request.QueryString["sId"]))? (int)-1 : int.Parse(Request.QueryString["sId"]);

            if (sId != -1)
            {
                var dc = new DulyDBDataContext();
                var query = from n in dc.Notes
                            where n.sId == sId
                            select n;

                if (query.Count() > 0)
                {
                    lblResult.Text = "There are: " + query.Count() + " results found!";
                    foreach (var r in query)
                    {

                    }

                }
                else
                {
                        lblResult.Text = "NO RESULT FOUND!.";
                }
            }
            else
                Response.Redirect("~/Search.aspx");


            
        }
        
    }


    protected void btnTest_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/DisplayNote.aspx?Note=" + 27);
    }
}

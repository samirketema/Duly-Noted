using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Net;
public partial class DisplayNote : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {           
            //use the getNote function to query to get the currentNote
            var currentNote = getNote();

            //get the uploader of the currentNote
            var dc = new DulyDBDataContext();
            var uploader = (from u in dc.Users
                            where u.userId == currentNote.userId
                            select u).First();

            //display
            lblTitle.Text = currentNote.title;
            lblUploader.Text = uploader.displayName;
            lblDescription.Text = currentNote.description;            

        }
    }

    protected Note getNote()
    {
        int nId = int.Parse(Request.QueryString["Note"]);
        var dc = new DulyDBDataContext();
        var query = (from n in dc.Notes
                     where n.noteId == nId
                     select n).First();
        return query;
    }

    protected void btnDownload_Click( object sender, EventArgs e)
    {
        if (Session["dulyNoted"] != null)
        {
            var query = getNote();

            //download
            string uriPath =query.source;
            string localPath = new Uri(uriPath).LocalPath;
            // Create New instance of FileInfo class to get the properties of the file being downloaded
            FileInfo file = new FileInfo(localPath);
            Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name);
            Response.End();
        }
        else
        {
            //modify this to the current page name
            string returnUrl ="DisplayNote.aspx?Note="+ Request.QueryString["Note"];
            Response.Redirect("~/Login.aspx?ReturnURL="+ returnUrl);
        }
    }
}
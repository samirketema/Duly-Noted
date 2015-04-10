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
        return (from n in dc.Notes
                where n.noteId == nId
                select n).First();
    }

    protected void btnDownload_Click( object sender, EventArgs e)
    {
        if (Session["dulyNoted"] != null)
        {
            var query = getNote();

            //download
            Response.Redirect(query.source);
        }
        else
        {
            //modify this to the current page name
            string returnUrl ="DisplayNote.aspx?Note="+ Request.QueryString["Note"];
            Response.Redirect("~/Login.aspx?ReturnURL="+ returnUrl);
        }
    }

    protected void rating (string action)
    {
        //check for logged in
        if (Session["dulyNoted"] == null)
        {
            //modify this to the current page name
            string returnUrl = "DisplayNote.aspx?Note=" + Request.QueryString["Note"];
            Response.Redirect("~/Login.aspx?ReturnURL=" + returnUrl);
        }
        else
        {
            int nId = int.Parse(Request.QueryString["Note"]);
            var dc = new DulyDBDataContext();
            var query = (from n in dc.Notes
                         where n.noteId == nId
                         select n).First();

            switch (action)
            {
                case "Up":
                    query.upVoteCounter += 1;
                    break;
                case "Down":
                    query.downVoteCounter += 1;
                    break;
                case "Flag":
                    query.numberTimesFlagged += 1;
                    break;
            }

            dc.SubmitChanges();
        }        
    }

    protected void btnUpVote_Click(object sender, EventArgs e)
    {
        rating("Up");
    }
    protected void btnDownVote_Click(object sender, EventArgs e)
    {
        rating("Down");
    }
    protected void btnFlag_Click(object sender, EventArgs e)
    {
        rating("Flag");
    }
}
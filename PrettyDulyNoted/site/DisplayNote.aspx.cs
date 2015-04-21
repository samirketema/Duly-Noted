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

        if (Session["dulyNoted"] != null)
        {
            lnkLogin.Visible = false;
            lnkLogout.Visible = true;
            lnkRegister.Visible = false;
            lnkMember.Visible = true;
        }
        else
        {
            lnkLogin.Visible = true;
            lnkLogout.Visible = false;
            lnkRegister.Visible = true;
            lnkMember.Visible = false;
        }

        if (!IsPostBack)
        {           
            //use the getNote function to query to get the currentNote
            var currentNote = getNote();

            //get the uploader of the currentNote
            if (currentNote != null)
            {
                var dc = new DulyDBDataContext();
                var uploader = (from u in dc.Users
                                where u.userId == currentNote.userId
                                select u).First();

                //display
                lblTitle.Text = currentNote.title;
                lblNoteDate.Text = "Noted on: " +currentNote.noteDate.Value.ToShortDateString();
                lblUploadedDate.Text = currentNote.uploadDate.Value.ToShortDateString();
                
                lblUploader.Text = uploader.displayName;
                lblDescription.Text = currentNote.description;

                //handle voting buttons
                if (Session["dulyNoted"] != null)
                {
                    //case your own note
                    int userId = int.Parse(Session["dulyNoted"].ToString());
                    if (userId == currentNote.userId)
                    {
                        btnUpVote.Enabled = false;
                        btnDownVote.Enabled = false;
                        btnFlag.Enabled = false;
                    }
                    else //others
                        handlingVotingButtons(int.Parse(Session["dulyNoted"].ToString()));
                }
            }
        }
    }

    //this function return the voting record
    protected VotingCheck doVotingCheck (int userId)
    {
        int nId = int.Parse(Request.QueryString["Note"]);
        var dc = new DulyDBDataContext();
        //pull the user voting check
        var qvote = from v in dc.VotingChecks
                    where v.userId == userId && v.noteId == nId
                    select v;
        if (qvote.Count() > 0)
            return qvote.First();
        else
            return null;
    }

    protected void handlingVotingButtons(int userId)
    {
        //get the voting status of the user
        VotingCheck votestatus = doVotingCheck(userId);

        //there is a record
        if (votestatus != null)
        {
            //check for up and down
            if (votestatus.voted)
            {
                btnUpVote.Enabled = false;
                btnDownVote.Enabled = false;
            }
            else
            {
                btnUpVote.Enabled = true;
                btnDownVote.Enabled = true;
            }

            //check the flag
            if (votestatus.flagged)
                btnFlag.Enabled = false;
            else
                btnFlag.Enabled = true;
        }
    }


    protected Note getNote()
    {

        int nId = (string.IsNullOrEmpty(Request.QueryString["Note"])) ? (int)-1 : int.Parse(Request.QueryString["Note"]);
        
        if (nId != -1)
        {
            var dc = new DulyDBDataContext();
            return (from n in dc.Notes
                    where n.noteId == nId
                    select n).First();
        }
        else
        {
            Response.Redirect("~/Search.aspx");
            return null;
        }
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

            //get user Id
            int userId = int.Parse(Session["dulyNoted"].ToString());

            //call the votingRecord
            voteRecord(userId, nId);           

            //then just update the voting
            var qvote = (from v in dc.VotingChecks
                        where v.userId == userId && v.noteId == nId
                        select v).First();

            switch (action)
            {
                case "Up":
                    query.upVoteCounter += 1;
                    qvote.voted = true;
                    disableVoting();
                    break;
                case "Down":
                    query.downVoteCounter += 1;
                    qvote.voted = true;
                    disableVoting();
                    break;
                case "Flag":
                    query.numberTimesFlagged += 1;
                    qvote.flagged = true;
                    btnFlag.Enabled = false;
                    break;
            }

            dc.SubmitChanges();
        }        
    }

    //handle the button enable status
    protected void disableVoting()
    {
        btnUpVote.Enabled = false;
        btnDownVote.Enabled = false;
    }

    protected void voteRecord (int userId, int nId)
    {
        var dc = new DulyDBDataContext();
        VotingCheck votestatus = doVotingCheck(userId);

        //if there is no record, create new one
        if (votestatus == null)
        {
            var newVotingRec = new VotingCheck
            {
                userId = userId,
                noteId = nId,
                flagged = false,
                voted = false
            };

            dc.VotingChecks.InsertOnSubmit(newVotingRec);
            dc.SubmitChanges();
        }
    }
    protected void btnUpVote_Click(object sender, EventArgs e)
    {
        btnUpVote.CssClass = "btn btn-success btn-sm";
        rating("Up");
    }
    protected void btnDownVote_Click(object sender, EventArgs e)
    {
        btnDownVote.CssClass = "btn btn-warning btn-sm";
        rating("Down");
    }
    protected void btnFlag_Click(object sender, EventArgs e)
    {
        btnFlag.CssClass = "btn btn-danger btn-sm";
        rating("Flag");
    }

    protected void btnSignUp_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Register.aspx");
    }
    protected void lnkMember_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Member.aspx");
    }
    protected void lnkLogin_Click(object sender, EventArgs e)
    {
        Response.Redirect("Login.aspx?ReturnURL=DisplayNote.aspx");

    }
    protected void lnkLogout_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("~/LogoutConfirm.aspx");
    }

}
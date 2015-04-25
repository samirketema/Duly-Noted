using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;

using Persits.PDF;

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
            btnUpVote.Enabled = true;
            btnDownVote.Enabled = true;
            btnFlag.Enabled = true;
            
            //comment
            //registered users can comment
            txtCommentTextBox.Visible = true;
            PostCommentButton.Visible = true;
            lblNotLogin.Visible = false;


        }
        else
        {
            lnkLogin.Visible = true;
            lnkLogout.Visible = false;
            lnkRegister.Visible = true;
            lnkMember.Visible = false;
            DisableLinkButton(btnUpVote);
            DisableLinkButton(btnDownVote);
            DisableLinkButton(btnFlag);

            //comment
            lblNotLogin.Text = "Please log in to leave a comment!";
            lblNotLogin.Visible = true;
            txtCommentTextBox.Visible = false;
            PostCommentButton.Visible = false;
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
                lblNoteDate.Text = "Note taken on: " +currentNote.noteDate.Value.ToShortDateString();
                lblUploadedDate.Text = currentNote.uploadDate.Value.ToShortDateString();
                lblUploader.Text = uploader.displayName;
                lblDescription.Text = currentNote.description;

                //preview
                ibtnPreview.ImageUrl = currentNote.preview;

                //handle voting buttons
                if (Session["dulyNoted"] != null)
                {

                    //you cannot vote for yourself
                    int userId = int.Parse(Session["dulyNoted"].ToString());
                    if (userId == currentNote.userId)
                    {
                        DisableLinkButton(btnUpVote);
                        DisableLinkButton(btnDownVote);
                        DisableLinkButton(btnFlag);

                        //enable delete button
                        btnDel.Visible = true;
                    }
                    else //others
                        handlingVotingButtons(int.Parse(Session["dulyNoted"].ToString()));
                }
            }
        }
        showComments();
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

            //get the virtual path
            var path = VirtualPathUtility.ToAppRelative(new Uri(query.source).AbsolutePath);

            //download dialog
            Response.AppendHeader("Content-Disposition", "attachment; filename=\"" + query.title +".pdf\"");
            Response.TransmitFile(Server.MapPath(path));
            Response.End();
        }
        else
            doLogin();
    }

    protected void btnView_Click(object sender, EventArgs e)
    {
        if (Session["dulyNoted"] != null)
        {
            var query = getNote();

            //View
            Response.Redirect(query.source);
        }
        else
            doLogin();
    }
    protected void doLogin ()
    {
        //modify this to the current page name
        string returnUrl = "DisplayNote.aspx?Note=" + Request.QueryString["Note"];
        Response.Redirect("~/Login.aspx?ReturnURL=" + returnUrl);
    }

    protected void rating (string action)
    {
        //check for logged in
        if (Session["dulyNoted"] == null)
            doLogin();
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
        DisableLinkButton(btnDownVote);
        rating("Up");
    }
    protected void btnDownVote_Click(object sender, EventArgs e)
    {
        btnDownVote.CssClass = "btn btn-warning btn-sm";
        DisableLinkButton(btnUpVote);
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
        doLogin();
    }
    protected void lnkLogout_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("~/LogoutConfirm.aspx");
    }

    protected void btnDel_Click(object sender, EventArgs e)
    {
        int nId = int.Parse(Request.QueryString["Note"]);
        var dc = new DulyDBDataContext();

        //delete the note from the database
        dc.Notes.DeleteOnSubmit(dc.Notes.Single(n => n.noteId == nId));
        dc.SubmitChanges();

        //return to member page
        Response.Redirect("~/Member.aspx");
    }

    protected void ibtnPreview_Click(object sender, ImageClickEventArgs e)
    {
        var note = getNote();
        Response.Redirect(note.preview);
    }


    public static void DisableLinkButton(LinkButton linkButton)
    {
        linkButton.Attributes.Remove("href");
        linkButton.Attributes.CssStyle[HtmlTextWriterStyle.Color] = "gray";
        linkButton.Attributes.CssStyle[HtmlTextWriterStyle.Cursor] = "default";
        if (linkButton.Enabled != false)
        {
            linkButton.Enabled = false;
        }

        if (linkButton.OnClientClick != null)
        {
            linkButton.OnClientClick = null;
        }
    }


    //comment part
    protected void PostCommentButton_Click(object sender, EventArgs e)
    {
        if (Session["dulyNoted"] != null)
        {
            // no blank comments 
            if (txtCommentTextBox.Text.Trim() != "")
            { 
                DulyDBDataContext dc = new DulyDBDataContext();
                int uId = int.Parse(Session["dulyNoted"].ToString());
                int nId = int.Parse(Request.QueryString["Note"]);

                //create new comment
                var newComment = new Comment
                {
                    userId = uId,
                    noteId = nId,
                    comment1 = txtCommentTextBox.Text,
                    commentedTime = DateTime.Now
                };

                dc.Comments.InsertOnSubmit(newComment);
                dc.SubmitChanges();
                showComments();
                
                //reset the text box
                txtCommentTextBox.Text = "";
            }
        }
        else
            doLogin();
    }


    protected void showComments()
    {
        //just reset everything
        lblComment.Text = "";

        //original code
        var dc = new DulyDBDataContext();
        int nId = int.Parse(Request.QueryString["Note"]);
        var query = from c in dc.Comments
                    where c.noteId == nId
                    join u in dc.Users on c.userId equals u.userId
                    orderby c.commentedTime ascending
                    select new
                    {
                        cTime = c.commentedTime,
                        cMsg = c.comment1,
                        uName = u.displayName,
                        userId = c.userId
                    };

        foreach (var c in query)
        {
            

            //for fun
            //you will see your own messages on the right side
            if (Session["dulyNoted"] != null && (c.userId == int.Parse(Session["dulyNoted"].ToString())) )
            {
                lblComment.Text += "<br /><br /><font size=-2>";
                lblComment.Text += "<span style='float:right'>commented by " + "<font color='red'>You</font>";
                lblComment.Text += " | " + c.cTime.ToShortDateString();
                lblComment.Text += " @ " + c.cTime.ToShortTimeString();
                lblComment.Text += "</span></font><br /><br />";
                lblComment.Text += "<span style='float:right'><p class='triangle-right right'>" + c.cMsg + " </p></span> <br /><br /><br /><br />";
            }
                
            else
            {
                lblComment.Text += "<br /><br /><font size=-2>";
                lblComment.Text += "<span style='float:left'>commented by " + "<font color='red'>" + c.uName + "</font>";
                lblComment.Text += " | " + c.cTime.ToShortDateString();
                lblComment.Text += " @ " + c.cTime.ToShortTimeString();
                lblComment.Text += "</span></font><br /><br />";
                lblComment.Text += "<span style='float:left'><p class='triangle-right left'>" + c.cMsg + "</p></span> <br /><br /><br /><br /><br />";
            }

        }
    }
}

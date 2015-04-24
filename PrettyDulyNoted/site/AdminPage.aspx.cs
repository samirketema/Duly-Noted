using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Template : System.Web.UI.Page
{
    protected void binddata (int userId)
    {
        var dc = new DulyDBDataContext();
        var qNote = from n in dc.Notes
                    where n.userId == userId
                    select new
                    {
                        nId = n.noteId,
                        Title = n.title,
                        Flag = n.numberTimesFlagged
                    };


        if (qNote.Count() > 0)
        {
            bool sortAsc = this.SortDirection == SortDirection.Ascending ? true : false;
            switch (SortExpression)
            {
                case "Title":
                    qNote = sortAsc ? qNote.OrderBy(q => q.Title) : qNote.OrderByDescending(q => q.Title);
                    break;
                case "nID":
                    qNote = sortAsc ? qNote.OrderBy(q => q.nId) : qNote.OrderByDescending(q => q.Title);
                    break;
                case "Flag":
                    qNote = sortAsc ? qNote.OrderBy(q => q.Flag) : qNote.OrderByDescending(q => q.Flag);
                    break;
                default:
                    qNote = sortAsc ? qNote.OrderBy(q => q.Title) : qNote.OrderByDescending(q => q.Title);
                    break;
            }
        }
        if (qNote.Count() < 0)
        {
            NoNotesError.Text = "No notes found.";
        }

        //bind.
        GridView1.DataSource = qNote.ToList();
        GridView1.DataBind();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Admin"] == null)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                "alert('You are not logged in');window.location ='ACPLogin.aspx';", true);
        }
        else //logged in
        {
            if (!IsPostBack)
            {
                div1.Visible = true;
            }
        }

    }
    protected void btnNoteSearch_Click(object sender, EventArgs e)
    {
        if (ddlSection.SelectedIndex != -1)
        {
            int sId = int.Parse(ddlSection.SelectedValue);
            Response.Redirect("~/AdminNoteSearchResult.aspx?sId=" + sId);
        }
    }
    protected void btnUserSearch_Click(object sender, EventArgs e)
    {
        var dc = new DulyDBDataContext();
        var qUser = (from u in dc.Users
                     where u.displayName == txtUsername.Text
                     select u).First();
        divUser.Visible = true;
        lblUserName.Text = qUser.firstName;

        var banStatus = from n in dc.BannedEmails
                        where n.email == qUser.email
                        select n;

        if (banStatus.Count() > 0)
        {
            banBtn.Visible = false;
            unbanBtn.Visible = true;
        }
        else
        {
            banBtn.Visible = true;
            unbanBtn.Visible = false;
        }

        binddata(qUser.userId);
   }

    /////////COPY FROM SEARCH 

     //sorting handler
       
    //sorting.. basically toggle between ASC and DES
    protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
    {
        if (this.SortExpression == e.SortExpression)
        {
            this.SortDirection = this.SortDirection == SortDirection.Ascending ?
                SortDirection.Descending : SortDirection.Ascending;
        }
        else
        {
            this.SortDirection = SortDirection.Ascending;
        }
        this.SortExpression = e.SortExpression;

        GridView1.EditIndex = -1;
        GridView1.SelectedIndex = -1;
    }

    protected void GridView1_Sorted(object sender, EventArgs e)
    {
        var dc = new DulyDBDataContext();
        var qUser = (from u in dc.Users
                     where u.displayName == txtUsername.Text
                     select u).First();

        binddata(qUser.userId);   
    }

    protected string SortExpression
    {
        get
        {
            return ViewState["SortExpression"] as string;
        }
        set
        {
            ViewState["SortExpression"] = value;
        }
    }


    protected SortDirection SortDirection
    {
        get
        {
            object obj = ViewState["SortDirection"];
            if (obj == null)
                return SortDirection.Ascending;
            else
                return (SortDirection) obj;
        }
        set
        {
            ViewState["SortDirection"] = value;
        }
    }

    //paging
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        GridView1.EditIndex = -1;
        GridView1.SelectedIndex = -1;
    }

    protected void GridView1_PageIndexChanged(object sender, EventArgs e)
    {
        var dc = new DulyDBDataContext();
        var qUser = (from u in dc.Users
                     where u.displayName == txtUsername.Text
                     select u).First();
        binddata(qUser.userId);         
 
    }

    ////////END OF COPY FROM SEARCH

    protected void OnSelectedIndexChanged(object sender, EventArgs e)
    {
        int NoteID = int.Parse(GridView1.SelectedRow.Cells[1].Text);

        var dc = new DulyDBDataContext();
        var qNote = from n in dc.Notes
                    where n.noteId == NoteID
                    select n;

        foreach(var nId in qNote)
        {
            dc.Notes.DeleteOnSubmit(nId);
        }

        dc.SubmitChanges();

        var qUser = (from u in dc.Users
                     where u.displayName == txtUsername.Text
                     select u).First();
        binddata(qUser.userId); 
    }

    protected void unbanUser(object sender, EventArgs e)
    {
        var dc = new DulyDBDataContext();
        var qUser = (from u in dc.Users
                     where u.displayName == txtUsername.Text
                     select u).First();

        var banStatus = from n in dc.BannedEmails
                        where n.email == qUser.email
                        select n;

        foreach (var email in banStatus)
            dc.BannedEmails.DeleteOnSubmit(email);
        dc.SubmitChanges();
    }
    
    protected void banUser(object sender, EventArgs e)
    {
        var dc = new DulyDBDataContext();
        var qUser =  (from u in dc.Users
                     where u.displayName == txtUsername.Text
                     select u).First();

        var banStatus = from n in dc.BannedEmails
                  where n.email == qUser.email
                  select n;

        var banUser = new BannedEmail
        {
            email = qUser.email
        };

        dc.BannedEmails.InsertOnSubmit(banUser);
        dc.SubmitChanges();
        
    }
    

    protected void btnCheckSubject_Click(object sender, EventArgs e)
    {

        var dc = new DulyDBDataContext();
        var query = from s in dc.Courses
                    where s.subject == txtSubject.Text
                    select new { cID = s.courseId, cNumber = s.courseNumber };
        if (query.Count() > 0)
        {
            lblError.Text = "";

            //enable the Course Number
            ddlCourseNumber.Enabled = true;

            //populate data to the course List
            ddlCourseNumber.DataSource = query;
            ddlCourseNumber.DataTextField = "cNumber";
            ddlCourseNumber.DataValueField = "cID";
            ddlCourseNumber.DataBind();

            //insert the top line default value
            ddlCourseNumber.Items.Insert(0, new ListItem("Please Select...", "-1"));
        }
        else
            lblError.Text = "the Subject you entered does not exist";

    }

    protected void btnCheckUsername_Click(object sender, EventArgs e)
    {

        var dc = new DulyDBDataContext();
        var query = from u in dc.Users
                    where u.displayName == txtUsername.Text
                    select u;
        if (query.Count() > 0)
        {
            lblUserError.Text = "";
            btnSearchUser.Enabled = true;
        }
        else
            lblUserError.Text = "the User you entered does not exist";

    }

    protected void course_select(object sender, EventArgs e)
    {
        //get the course id from the dropdown list
        int cId = int.Parse(ddlCourseNumber.SelectedValue);



        var dc = new DulyDBDataContext();
        var query = from c in dc.Sections
                    where c.courseId == cId
                    select new { sID = c.sId, sNumber = c.sectionNumber };

        if (query.Count() > 0)
        {
            lblError.Text = "";

            //enable the section number
            ddlSection.Enabled = true;

            ddlSection.DataSource = query;
            ddlSection.DataTextField = "sNumber";
            ddlSection.DataValueField = "sId";
            ddlSection.DataBind();

            //insert top line default value
            ddlSection.Items.Insert(0, new ListItem("Please Select...", "-1"));
        }
        else
            lblError.Text = "no Section for the selected Course Number";
    }

    protected void section_select(object sender, EventArgs e)
    {
        //enable the search button
        btnSearch.Enabled = true;
    }
}
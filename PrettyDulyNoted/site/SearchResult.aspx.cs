using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SearchResult : System.Web.UI.Page
{
    protected int getSid()
    {
        return (string.IsNullOrEmpty(Request.QueryString["sId"])) ? (int)-1 : int.Parse(Request.QueryString["sId"]);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            int sId = getSid();
            if (sId != -1)
                BindData(sId);
            else //case the querystring is null
                Response.Redirect("~/Search.aspx");            
        }        
    }

    //bind data to the gridview
    protected void BindData(int sId)
    {

        var dc = new DulyDBDataContext();

        //join 2 tables: Notes and Users
        var query = from n in dc.Notes
                    where n.sId == sId
                    join u in dc.Users on n.userId equals u.userId
                    select new
                    {
                        nId= n.noteId,  
                        Title = n.title,
                        Uploader = u.displayName,
                        UpVote = n.upVoteCounter,
                        DownVote = n.downVoteCounter,
                        Flag = n.numberTimesFlagged,
                        noteDate = n.noteDate,
                        UploadDate = n.uploadDate,
                        prettyNoteDate = n.noteDate.Value.ToShortDateString(),
                        prettyUploadDate = n.uploadDate.Value.ToShortDateString()
                    };

        //get the course and section description
        var qcourse = from s in dc.Sections
                      where s.sId == sId
                      join c in dc.Courses on s.courseId equals c.courseId
                      join p in dc.Professors on s.professorEmail equals p.email
                      select new
                      {
                          cName = c.coursename,
                          cNumber = c.courseNumber,
                          sNumber = s.sectionNumber,
                          cSubject = c.subject,
                          pEmail = p.email,
                          pFirst = p.firstName,
                          pLast = p.lastName
                      };
        var course = qcourse.ToList().First();
        string resultText = course.cSubject +" " + course.cNumber +"- "+ course.sNumber+
                            "<br/> Description: "+ course.cName + "<br/> Professor Name: "+course.pFirst+" "+course.pLast+
                            "<br/> Professor Email: " + course.pEmail + "<br/><br/>There are: " + query.Count() + " notes that match your search criteria.<br/>";
        lblResult.Text = resultText;

        //sorting handler
        bool sortAsc = this.SortDirection == SortDirection.Ascending ? true : false;
        switch (SortExpression)
        {
            case "Title":
                query = sortAsc ? query.OrderBy(q => q.Title) : query.OrderByDescending(q => q.Title);
                break;
            case "Uploader":
                query = sortAsc ? query.OrderBy(q => q.Uploader) : query.OrderByDescending(q => q.Uploader);
                break;
            case "UpVote":
                query = sortAsc ? query.OrderBy(q => q.UpVote) : query.OrderByDescending(q => q.UpVote);
                break;
            case "DownVote":
                query = sortAsc ? query.OrderBy(q => q.DownVote) : query.OrderByDescending(q => q.DownVote);
                break;
            case "Flag":
                query = sortAsc ? query.OrderBy(q => q.Flag) : query.OrderByDescending(q => q.Flag);
                break;
            case "NoteDate":
                query = sortAsc ? query.OrderBy(q => q.noteDate) : query.OrderByDescending(q => q.noteDate);
                break;
            case "UploadDate":
                query = sortAsc ? query.OrderBy(q => q.UploadDate) : query.OrderByDescending(q => q.UploadDate);
                break; 
            default:
                query = sortAsc ? query.OrderBy(q => q.Title) : query.OrderByDescending(q => q.Title);
                break;       
        }

        //bind.
        GridView1.DataSource = query.ToList();
        GridView1.DataBind();
    }

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
        int sId = getSid();
        if (sId != -1)
            BindData(sId);
        else
            Response.Redirect("~/Search.aspx");
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
        int sId = getSid();
        if (sId != -1)
            BindData(sId);
        else
            Response.Redirect("~/Search.aspx");
 
    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Search.aspx");
    }
}

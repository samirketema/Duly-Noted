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
                        Flag = n.numberTimesFlagged
                    };

        lblResult.Text = string.Format("{0} notes match your search criteria.", query.Count());

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

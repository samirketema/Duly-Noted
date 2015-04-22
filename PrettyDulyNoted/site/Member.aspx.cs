using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Security.Cryptography;

public partial class Member : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Header.DataBind();
        if (Session["dulyNoted"] == null)
        {
            div1.Visible = false;
            div_Notlogin.Visible = true;
            //modify this to the current page name
            var returnUrl = "Member.aspx";

            //let the login page know which page to return
            string LoginPageUrl = "Login.aspx?ReturnURL=" + returnUrl;
            Page.Header.Controls.Add(new LiteralControl(string.Format("<META http-equiv=\"REFRESH\" content=\"3;url={0}\" > ", LoginPageUrl)));
        }
        else      //logged in
        {
            if (!IsPostBack)
            {
                div1.Visible = true;
                div_Notlogin.Visible = false;
                divProfile.Visible = true;
                divNotes.Visible = false;
                btnProfile.Enabled = false;

                //get the information
                DulyDBDataContext dc = new DulyDBDataContext();
                var query = (from u in dc.Users
                             where u.userId == int.Parse(Session["dulyNoted"].ToString())
                             select u).First();

                // display info for fun -- replace by actual features later
                lblDisplayname.Text = query.displayName + " last login: " +  query.lastLoginDate.Value.ToShortDateString() ;
            }

        }
      

    }

    protected void lnkLogOut_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("~/LogoutConfirm.aspx");
    }

    protected void lnkDel_Click(object sender, EventArgs e)
    {
        DulyDBDataContext dc = new DulyDBDataContext();
        
        var query = (from u in dc.Users
                     where u.userId == int.Parse(Session["dulyNoted"].ToString())
                     select u).First();

        //get all the note
        var note = from n in dc.Notes
                   where n.userId == query.userId
                   select n;

        //delete note
        dc.Notes.DeleteAllOnSubmit(note);

        //delete account
        dc.Users.DeleteOnSubmit(query);
        dc.SubmitChanges();

        //abandon session
        Session.Abandon();
        Response.Redirect("~/LogoutConfirm.aspx");

    }

    protected void lnkReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Default.aspx");
    }
    protected void lnkChangePass_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/ChangePassword.aspx");
    }
    protected void lnkMember_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Member.aspx");
    }
    protected void lnkLogout_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("~/LogoutConfirm.aspx");
    }
    protected void btnProfile_Click(object sender, EventArgs e)
    {
        btnProfile.Enabled = false;
        divNotes.Visible = false;
        btnNotes.Enabled = true;
        divProfile.Visible = true;

    }
    protected void btnNotes_Click(object sender, EventArgs e)
    {
        btnNotes.Enabled = false;
        divProfile.Visible = false;
        btnProfile.Enabled = true;
        divNotes.Visible = true;

        //bind data
        BindData();
    }

    
    //--------------------change pass part --------------------------------------------
    protected void btnChangePass_Click(object sender, EventArgs e)
    {
        DulyDBDataContext dc = new DulyDBDataContext();

        // query db using the userID for the password salt
        var saltQuery = from u in dc.Users
                        where u.userId == int.Parse(Session["dulyNoted"].ToString())
                        select u.salt;

        string userSalt = saltQuery.First();

        string hashedPassword = "no";

        // make sure the user was found
        if (saltQuery.Count() > 0)
        {
            // makes sure there was a valid salt
            if (userSalt != null)
                hashedPassword = hashPassword(txtCurrentPass.Text, userSalt);
        }


        var query = from u in dc.Users
                    where u.userId == int.Parse(Session["dulyNoted"].ToString()) && u.password == hashedPassword
                    select u;
        if (query.Count() > 0)
        {
            var user = query.First();

            userSalt = createSalt(24);
            hashedPassword = hashPassword(txtNewPass.Text, userSalt);
            user.password = hashedPassword;
            user.salt = userSalt;
            dc.SubmitChanges();
            lblError.Text = "Password successfully changed";
            lblError.ForeColor = System.Drawing.Color.Blue;
        }
        else //no match
        {
            lblError.ForeColor = System.Drawing.Color.Red;
            lblError.Text = "Please Check your current password again!";
        }

    }

    // hash the password with the salt
    public static string hashPassword(string passWordText, string saltText)
    {

        byte[] passwordInBytes = Encoding.UTF8.GetBytes(passWordText);
        byte[] saltInBytes = Convert.FromBase64String(saltText);

        byte[] saltedPasswordInBytes = saltInBytes.Concat(passwordInBytes).ToArray();


        byte[] hash = new SHA256Managed().ComputeHash(saltedPasswordInBytes);

        return Convert.ToBase64String(hash);
    }

    // create the salt for the password
    private static string createSalt(int size)
    {
        RNGCryptoServiceProvider ranNum = new RNGCryptoServiceProvider();
        byte[] salt = new byte[size];
        ranNum.GetBytes(salt);

        return Convert.ToBase64String(salt);
    }



    //---------------------- Note part--------------------------------------------

    //bind data to the gridview
    protected void BindData()
    {

        var dc = new DulyDBDataContext();
        int userId = int.Parse(Session["dulyNoted"].ToString());

        //join 2 tables: Notes and Users
        var query = from n in dc.Notes
                    where n.userId ==  userId
                    join s in dc.Sections on n.sId equals s.sId
                    join c in dc.Courses on s.courseId equals c.courseId
                    select new
                    {
                        nId = n.noteId,
                        Title = n.title,
                        UpVote = n.upVoteCounter,
                        DownVote = n.downVoteCounter,
                        Flag = n.numberTimesFlagged,
                        noteDate = n.noteDate,
                        Section = s.sectionNumber,
                        CourseNumber = c.courseNumber,
                        Subject = c.subject,
                        UploadDate = n.uploadDate,
                        prettyNoteDate = n.noteDate.Value.ToShortDateString(),
                        prettyUploadDate = n.uploadDate.Value.ToShortDateString()
                    };

        //sorting handler
        bool sortAsc = this.SortDirection == SortDirection.Ascending ? true : false;
        switch (SortExpression)
        {

            case "Subject":
                query = sortAsc ? query.OrderBy(q => q.Subject) : query.OrderByDescending(q => q.Subject);
                break;
            case "CourseNumber":
                query = sortAsc ? query.OrderBy(q => q.CourseNumber) : query.OrderByDescending(q => q.CourseNumber);
                break;
            case "Title":
                query = sortAsc ? query.OrderBy(q => q.Title) : query.OrderByDescending(q => q.Title);
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

        //display label
        if (query.Count() == 0)
            lblResult.Text = "You have not uploaded any note.";
        else
            lblResult.Text = "You have uploaded " + query.Count() + ((query.Count() == 1)? " Note." : " Notes.");
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
        BindData();
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
                return (SortDirection)obj;
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
        BindData();
    }

}
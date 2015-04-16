 using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Upload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Header.DataBind();

        if (Session["dulyNoted"] == null)
        {
            div1.Visible = false;
            div_Notlogin.Visible = true;
            //modify this to the current page name
            var returnUrl ="Upload.aspx";

            //let the login page know which page to return
            string LoginPageUrl = "Login.aspx?ReturnURL=" + returnUrl;
            Page.Header.Controls.Add(new LiteralControl(string.Format("<META http-equiv=\"REFRESH\" content=\"3;url={0}\" > ", LoginPageUrl)));
        }
        else      //logged in
        {
            if (!IsPostBack)
            {
                div1.Visible = true;
                NoteTitle.Text = "";
                NoteDescription.Text = "";
                div_Notlogin.Visible = false;
            }
        }

    }

    protected string randomName ()
    {
        string res="";

        for (int i = 0; i < 5; i++)
        {
            //random number
            Random rand = new Random((int)DateTime.Now.Ticks);
            int RandomNumber;
            RandomNumber = rand.Next(100000, 999999);

            //random char
            int CharCode = rand.Next(Convert.ToInt32('a'), Convert.ToInt32('z'));
            char RandomChar = Convert.ToChar(CharCode);

            res = res + RandomChar + RandomNumber;
        }

        return res;
    }


    protected void UploadButton_Click(object sender, EventArgs e)
    {
        if (FileUpload1.HasFile)
            try
            {
                if (ddlSection.SelectedIndex != -1)
                {
                    DulyDBDataContext dc = new DulyDBDataContext();

                    string extension = System.IO.Path.GetExtension(FileUpload1.FileName);
                    
                    //generate RandomName
                    string newFileName = randomName() + extension;

                    FileUpload1.SaveAs(HttpContext.Current.Server.MapPath("~") + "/Uploads/" +
                         newFileName);
                    //test link
                    hyperlink.NavigateUrl = "http://dulynoted-001-site1.smarterasp.net/Uploads/" + newFileName;
                    hyperlink.Visible = true;
                 
                    var newNote = new Note
                    {

                        sId = int.Parse(ddlSection.SelectedValue),
                        userId = int.Parse(Session["dulyNoted"].ToString()),
                        numberTimesFlagged = 0,
                        upVoteCounter = 0,
                        downVoteCounter = 0,
                        source = "http://dulynoted-001-site1.smarterasp.net/Uploads/" + newFileName,
                        title = NoteTitle.Text,
                        description = NoteDescription.Text,
                        noteDate = Calendar_NoteDate.SelectedDate,
                        uploadDate = DateTime.Now

                    };
                    dc.Notes.InsertOnSubmit(newNote);
                    dc.SubmitChanges();
                    
                    //AFTER THE FILE IS UPLOADED HERE
                    
                }
                else
                {
                    UploadLabel1.Text = "You must select a section.";
                }
            }
            catch (Exception ex)
            {
                UploadLabel1.Text = "ERROR: " + ex.Message.ToString();
            }
        else
        {
            UploadLabel1.Text = "You have not specified a file.";
        }
    }


    protected void btnCheckSubject_Click(object sender, EventArgs e)
    {

        var dc = new DulyDBDataContext();
        var query = from s in dc.Courses
                       where s.subject == txtSubject.Text
                       select new {cID = s.courseId, cNumber = s.courseNumber};
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

    protected void course_select(object sender, EventArgs e)
    {
        //get the course id from the dropdown list
        int cId = int.Parse(ddlCourseNumber.SelectedValue);

        
        
        var dc = new DulyDBDataContext();
        var query = from c in dc.Sections
                    where c.courseId == cId
                    select new {sID = c.sId, sNumber = c.sectionNumber};

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
        Calendar_NoteDate.Enabled = true;
    }

    protected void Calendar_Change(object sender, EventArgs e)
    {
        //File Upload enabled.    
        FileUpload1.Enabled = true;
        NoteTitle.Enabled = true;
        NoteDescription.Enabled = true;
        UploadButton.Enabled = true;
    }

}

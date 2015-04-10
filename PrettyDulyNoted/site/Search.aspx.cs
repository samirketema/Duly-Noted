using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Search : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (ddlSection.SelectedIndex != -1)
        {
            int sId = int.Parse(ddlSection.SelectedValue);
            Response.Redirect("~/SearchResult.aspx?sId=" + sId);
            
            //TODO: query the note table using the sectionId
            //TODO: populate the data from db to a grid view !? that supports clickable on each record
            //TODO: pass the noteID from the clicked link to new page Note.aspx using queryString
           
                        
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
        //enable the search button
        btnSearch.Enabled = true;
    }

}
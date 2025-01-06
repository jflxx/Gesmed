using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GesmedWA.Views
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            char rol = (char)Session["rol"];
            string cadena="";
            switch (rol)
            {
                case 'A':
                    cadena = " administrador ";
                    break;
                case 'S':
                    cadena = " supervisor ";
                    break;
                case 'R':
                    cadena = " representante medico ";
                    break;
            }
            lblRol.Text = cadena;
            lblTexto.Text =  cadena + Session["username"].ToString() + " ";
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}
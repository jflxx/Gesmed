using GesmedWA.GesmedWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.ConstrainedExecution;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GesmedWA
{
    public partial class admin : System.Web.UI.MasterPage
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            if (Session["username"] != null) {
                lblNombreUsuario.Text = Session["username"].ToString();
                lblNombreUsuario1.Text = lblNombreUsuario.Text;
            }
            else Response.Redirect("/Views/Login/Login.aspx");
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            char rol = (char)Session["rol"];
            switch (rol)
            {
                case 'A':
                    break;
                case 'S':
                    ModoSupervisor();
                    break;
                case 'R':
                    ModoRepresentantes();
                    break;
            }
        }

        private void ModoSupervisor()
        {
            btnSupervisores.Visible = false;
        }

        private void ModoRepresentantes()
        {
            btnSupervisores.Visible = false;
            btnRepresentantes.Visible = false;
        }
        /*
        private void lnkReporteVisitas_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Views/Reportes/GestionReporte.aspx?accion=representante");
            

        }
        private void lnkReporteRepresentantes_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Views/Reportes/GestionReporte.aspx?accion=visita");
             
          
         
        }
        */
    }








}
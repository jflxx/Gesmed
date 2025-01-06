using GesmedWA.GesmedWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GesmedWA.Views.Reportes
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        private ReporteWSClient reporte = new ReporteWSClient();

        private string op;
        private string id;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Page_Init(object sender, EventArgs e)
        {
            char rol = (char)Session["rol"];
            op = Request.QueryString["accion"];
            id = Request.QueryString["id"];
            switch (rol)
            {
                case 'S':
                    //TIENE TODOS LOS 
                    break;
                case 'A':
                    break;
                default:
                    //Administrador o Supervisor
                     Response.Redirect("../Inicio/Home.aspx");
                    break;
            }

            if (op != null)
            {
              ///  ObtenerDatosVisita();
                switch (op)
                {
                    case "visita":
                        lblTitulo.Text = "Reporte de visitas";
                     //   dtpFechaVisita.Text = 
                      //  DeshabilitarComponentes();
                        break;
                    case "representante":
                        lblTitulo.Text = "Reporte de representantes";
                      //  HabilitarActualizacion();
                        break;
                }
            }
        }
        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            Response.Redirect("../Inicio/Home.aspx");
        }
        protected void btnGenerarReporte_Click(object sender, EventArgs e)
        {
            string fechaInicio = dtpFechaInicio.Text;
            string fechaFin = dtpFechaFin.Text;

            // Convertir las fechas de "yyyy-MM-dd" a "dd-MM-yyyy"
            DateTime startDate = DateTime.Parse(fechaInicio);
            DateTime endDate = DateTime.Parse(fechaFin);

            // Formatearlas como "dd-MM-yyyy" para enviarlas al Web Service
            string formattedStartDate = startDate.ToString("dd-MM-yyyy");
            string formattedEndDate = endDate.ToString("dd-MM-yyyy");

            Byte[] FileBuffer;
            if (op != null)
            {
                ///  ObtenerDatosVisita();
                switch (op)
                {
                    case "visita":
                        FileBuffer = reporte.reportePDF_ListaVisitas(DateTime.Parse(formattedStartDate), DateTime.Parse(formattedEndDate));
                        if (FileBuffer != null)
                        {
                            Response.ContentType = "application/pdf";
                            Response.AddHeader("content-length", FileBuffer.Length.ToString());
                            Response.BinaryWrite(FileBuffer);
                        }
                        break;
                    case "representante":
                         FileBuffer = reporte.reportePDF_representantesKPIS(DateTime.Parse(formattedStartDate), DateTime.Parse(formattedEndDate));
                        if (FileBuffer != null)
                        {
                            Response.ContentType = "application/pdf";
                            Response.AddHeader("content-length", FileBuffer.Length.ToString());
                            Response.BinaryWrite(FileBuffer);
                        }
                        break;
                }
            }
        }
    }
}
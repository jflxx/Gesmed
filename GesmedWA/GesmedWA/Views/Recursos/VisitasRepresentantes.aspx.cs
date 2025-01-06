using GesmedWA.GesmedWS;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GesmedWA.Views.Recursos
{
    public partial class VisitasRepresentantes : System.Web.UI.Page
    {
        protected RepresentanteMedicoWSClient representanteDAO = new RepresentanteMedicoWSClient();
        protected VisitaWSClient visitaDAO = new VisitaWSClient();
        private representanteMedico representante;
        //private ReporteWSClient reporte = new ReporteWSClient();
        private string id;
        private visita[] listaVisita;
        private int total = 0;
        private int finalizados = 0;
        private int cancelado = 0;
        private int enProgreso = 0;
        private int programado = 0;
        protected void Page_Init(object sender, EventArgs e)
        {
            id = Request.QueryString["id"];
            representante = representanteDAO.ObtenerRepresentanteMedicoXID(int.Parse(id));
            TxtRepresentanteId.Text = representante.idRepresentanteMedico.ToString();
            TxtRepresentante.Text = representante.nombre + " " + representante.apellidoPaterno + " " + representante.apellidoMaterno;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            char rol = (char)Session["rol"];
            representanteDAO = new RepresentanteMedicoWSClient();
            representante = new representanteMedico();
            id = Request.QueryString["id"];
            if (rol == 'R')
                Response.Redirect("../Inicio/Home.aspx");
            listaVisita = visitaDAO.listarPorIDRepresentante(int.Parse(id));
            GvVisitas.DataSource = listaVisita;
            GvVisitas.DataBind();
            generarContadores(listaVisita);

            lblTotalVisitas.Text = total.ToString();
            lblFinalizados.Text = finalizados.ToString();
            lblCancelados.Text = cancelado.ToString();
            lblEnProgreso.Text = enProgreso.ToString();
        }

        private void generarContadores(visita[] listaVisita)
        {
            foreach (var visita in listaVisita)
            {
                if (visita != null)
                {
                    total++; // Contar el total de visitas

                    switch (visita.estado)
                    {
                        case estadoVisita.FINALIZADO:
                            finalizados++;
                            break;
                        case estadoVisita.CANCELADO:
                            cancelado++;
                            break;
                        case estadoVisita.EN_PROGRESO:
                            enProgreso++;
                            break;
                        case estadoVisita.PROGRAMADA:
                            programado++;
                            break;
                    }
                }
            }
                

        }
        protected void BtnRegresar_Click(object sender, EventArgs e)
        {
            Response.Redirect("./ListaRepresentantes.aspx");
        }

        protected void GvVisitas_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[2].Text =
                    Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "fecha")).ToString("dd-MM-yyyy");
                e.Row.Cells[3].Text =
                    Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "hora")).ToString("HH:mm:ss");
            }
                
        }

        protected void BtnResumenRepresentante_Click(object sender, EventArgs e)
        {
            id = Request.QueryString["id"];
            //Byte[] FileBuffer = reporte.reportePDF_MostrarRepresentanteKPIS(Int32.Parse(id));
            //if (FileBuffer != null)
            //{
             //   Response.ContentType = "application/pdf";
               // Response.AddHeader("content-length", FileBuffer.Length.ToString());
                //Response.BinaryWrite(FileBuffer);
            //}
        }
    }
}
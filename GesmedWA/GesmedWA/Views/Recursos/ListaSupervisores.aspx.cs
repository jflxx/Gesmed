using GesmedWA.GesmedWS;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GesmedWA.Views
{
    public partial class ListaSupervisores : System.Web.UI.Page
    {
        private SupervisorWSClient daoSupervisor;
        private BindingList<supervisor> supervisores;
        supervisor supervisorE;
        //     private static int idSupE;
        protected void Page_Init(object sender, EventArgs e)
        {
            char rol = (char)Session["rol"];
            switch (rol)
            {
                case 'A':
                    break;
                default:
                    Response.Redirect("../Inicio/Home.aspx");
                    break;
            }
            daoSupervisor = new SupervisorWSClient();
            txtBuscar.Text = "";
            supervisor[] supervisoresArray = daoSupervisor.listarSupervisorPorNombreOApellido(txtBuscar.Text);
            if(supervisoresArray != null)
                supervisores = new BindingList<supervisor>(supervisoresArray.ToList());
            else
                supervisores = new BindingList<supervisor>();
            gvSupervisores.DataSource = supervisores.Where(v => v.fidAdministrador == (int)Session["id"]).ToList();
            Session["supervisores"] = supervisores;
            gvSupervisores.DataBind();

        }
        //   string idSupervisor;
        protected void Page_Load(object sender, EventArgs e)
        {
            gvSupervisores.DataSource = daoSupervisor.listarSupervisorPorNombreOApellido(txtBuscar.Text);
            gvSupervisores.DataBind();
        }

        protected void btnInsertar_Click(object sender, EventArgs e)
        {
            Response.Redirect("./GestionSupervisores.aspx?accion=insertar");
        }

        protected void gvSupervisores_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvSupervisores.PageIndex = e.NewPageIndex;
            gvSupervisores.DataBind();
        }
        protected void lbSeleccionarSupervisor_Click(object sender, EventArgs e)
        {
            string idSupervisor = ((LinkButton)sender).CommandArgument;
            Response.Redirect("GestionSupervisores.aspx?accion=ver&idSupervisor=" + idSupervisor);
        }
        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            supervisor[] supervisoresArray = daoSupervisor.listarSupervisorPorNombreOApellido(txtBuscar.Text);
            supervisores = new BindingList<supervisor>(supervisoresArray.ToList());
            gvSupervisores.DataSource = supervisores.Where(v => v.fidAdministrador == (int)Session["id"]).ToList(); ;
            Session["supervisores"] = supervisores;
            gvSupervisores.DataBind();
        }
        protected void lbEditar_Click(object sender, EventArgs e)
        {
            string idSupervisor = ((LinkButton)sender).CommandArgument;
            Response.Redirect("GestionSupervisores.aspx?accion=editar&idSupervisor=" + idSupervisor);
        }

        protected void btnEliminarSupervisor_Click(object sender, EventArgs e)
        {
            if (Session["supervisorE"] != null)
            {
                supervisorE = (supervisor)Session["supervisorE"];
                daoSupervisor.eliminarSupervisor(supervisorE.idSupervisor);
                Response.Redirect("./ListaSupervisores.aspx");
            }
        }
        protected void lbSeleccionarSupervisorEliminar_Click(object sender, EventArgs e)
        {
            int idsupervisor = int.Parse(((LinkButton)sender).CommandArgument);
            supervisorE = ((BindingList<supervisor>)Session["supervisores"]).SingleOrDefault(x => x.idSupervisor == idsupervisor);
            btEliminarSupervisor.Visible = true;
            Session["supervisorE"] = supervisorE;
            string script = "showModalFormError('eliminarModal');";
            ScriptManager.RegisterStartupScript(this, GetType(), "", script, true);
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                bool activo = Convert.ToBoolean(DataBinder.Eval(e.Row.DataItem, "idTrabajador.activo"));
                Label lblActivo = (Label)e.Row.FindControl("lblActivo");
                if (lblActivo != null)
                {
                    lblActivo.Text = activo ? "Activo" : "Desactivo";
                    lblActivo.CssClass = activo ? "text-success" : "text-danger";
                }
            }
        }
        protected void btnOrdenarSupervisor_Click(object sender, EventArgs e)
        {
            char rol = (char)Session["rol"];
            //switch (rol)
            //{
            //    default:
            //        Session["supervisores"] = new BindingList<supervisor>(daoSupervisor.listarSupervisorPorNombreOApellido(txtBuscar.Text).Where(v => v.fidAdministrador == (int)Session["id"]).ToList());
            //        break;
            //}
            switch (ddlOrdenamiento.SelectedValue)
            {
                case "1":
                    gvSupervisores.DataSource = (BindingList<supervisor>)Session["supervisores"];
                    break;
                case "2":
                     supervisores = (BindingList<supervisor>)Session["supervisores"];
                    var supervisoresActivos = supervisores.Where(v => v.idTrabajador.activo == true).ToList();
                    gvSupervisores.DataSource = supervisoresActivos;
                    break;  
                case "3":
                     supervisores = (BindingList<supervisor>)Session["supervisores"];
                    var supervisoresDesactivos= supervisores.Where(v => v.idTrabajador.activo == false).ToList();
                    gvSupervisores.DataSource = supervisoresDesactivos;
                    break;
            }
            gvSupervisores.DataBind();
        }
    }
}
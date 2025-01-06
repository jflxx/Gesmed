using GesmedWA.GesmedWS;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GesmedWA.Views
{

    public partial class ListaRepresentantes : System.Web.UI.Page
    {
        private RepresentanteMedicoWSClient representanteDAO;
        protected void Page_Init(object sender, EventArgs e)
        {
            representanteDAO = new RepresentanteMedicoWSClient();
            char rol = (char)Session["rol"];
            switch (rol)
            {
                case 'A':
                    Session["RepresentantesMedicos"] = representanteDAO.ListarRepresentanteMedicoPorNombreOApellido(txtBuscar.Text);
                    gvRepresentantesMedicos.DataSource = (representanteMedico[])Session["RepresentantesMedicos"];
                    gvRepresentantesMedicos.DataBind();
                    break;
                case 'S':
                    ModoSupervisor();
                    break;
                default:
                    Response.Redirect("../Inicio/Home.aspx");
                    break;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (ViewState["OrdenSeleccionado"] != null)
                {
                    ddlBuscarPor.SelectedValue = ViewState["OrdenSeleccionado"].ToString();
                }
            }
        }

        private void ModoSupervisor()
        {
            ViewState["EsSupervisor"] = true;
            btnInsertar.Visible = false;
            gvRepresentantesMedicos.DataSource = representanteDAO.ListarRepresentantesMedico_Supervisor((int)Session["id"]);
            gvRepresentantesMedicos.DataBind();
        }
        protected void gvRepresentantesMedicos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvRepresentantesMedicos.PageIndex = e.NewPageIndex;
            actualizarGridView(); ;
        }

        protected void btnInsertar_Click(object sender, EventArgs e)
        {
            Session["guardar"] = false;
            Response.Redirect("./GestionRepresentantes.aspx");
        }


        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            representanteMedico[] representantesMedicos = representanteDAO.ListarRepresentanteMedicoPorNombreOApellido(txtBuscar.Text);
            Session["RepresentantesMedicos"] = representantesMedicos;
            ViewState["OrdenSeleccionado"] = ddlBuscarPor.SelectedValue;

            actualizarGridView();
        }

        void actualizarGridView()
        {
            representanteMedico[] representantesMedicos = (representanteMedico[])Session["RepresentantesMedicos"];
            if (representantesMedicos == null) return;

            BindingList<representanteMedico> temp = new BindingList<representanteMedico>(representantesMedicos);

            string ordenSeleccionado = ViewState["OrdenSeleccionado"]?.ToString() ?? "0";

            switch (ordenSeleccionado)
            {
                case "0": // Sin orden específico
                    gvRepresentantesMedicos.DataSource = temp;
                    break;
                case "1": // Ordenar por Nombre o Apellido
                    gvRepresentantesMedicos.DataSource = temp.OrderBy(v => v.nombre).ToList();
                    break;
                case "2": // KPI Ascendente
                    gvRepresentantesMedicos.DataSource = temp.OrderBy(v => v.KPI).ToList();
                    break;
                case "3": // KPI Descendente
                    gvRepresentantesMedicos.DataSource = temp.OrderByDescending(v => v.KPI).ToList();
                    break;
            }

            gvRepresentantesMedicos.DataBind();

        }

        protected void btMostrarDatos_Click(object sender, EventArgs e)
        {
            int idRepresentante = Int32.Parse(((LinkButton)sender).CommandArgument);
            Response.Redirect("./GestionRepresentantes.aspx?op=view&id=" + idRepresentante);
        }

        protected void btEliminarRepresentante_Click(object sender, EventArgs e)
        {
            btnAceptarError.Visible = true;
            Session["id"] = Int32.Parse(((LinkButton)sender).CommandArgument);
            ScriptManager.RegisterStartupScript(this, GetType(), "", "showModal('error-modal');", true);
        }

        protected void btActualizarRepresentante_Click(object sender, EventArgs e)
        {
            int idRepresentante = Int32.Parse(((LinkButton)sender).CommandArgument);
            Response.Redirect("./GestionRepresentantes.aspx?op=edit&id=" + idRepresentante);
        }

        protected void btnCerrarError_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "", "closeModal('error-modal');", true);
        }
        protected void btnAceptarError_Click(object sender, EventArgs e)
        {
            representanteDAO.eliminarRepresentante((int)Session["id"]);
            Response.Redirect("./ListaRepresentantes.aspx");
        }

        protected void gvRepresentantesMedicos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Verifica si el rol es de supervisor
                bool esSupervisor = ViewState["EsSupervisor"] != null && (bool)ViewState["EsSupervisor"];

                if (esSupervisor)
                {
                    // Encuentra los controles de LinkButton en la fila
                    LinkButton btActualizarRepresentante = (LinkButton)e.Row.FindControl("btActualizarRepresentante");
                    LinkButton btEliminarRepresentante = (LinkButton)e.Row.FindControl("btEliminarRepresentante");

                    // Ocultar los botones si el rol es de supervisor
                    if (btActualizarRepresentante != null) btActualizarRepresentante.Visible = false;
                    if (btEliminarRepresentante != null) btEliminarRepresentante.Visible = false;
                }
            }
        }

        protected void btnVisitas_Click(object sender, EventArgs e)
        {
            int idRepresentante = Int32.Parse(((LinkButton)sender).CommandArgument);
            Response.Redirect("./VisitasRepresentantes.aspx?id=" + idRepresentante);
        }


    }
    
}
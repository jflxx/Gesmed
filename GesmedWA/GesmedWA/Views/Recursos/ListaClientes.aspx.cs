using GesmedWA.GesmedWS;
using System;
using System.Collections.Generic;
using System.Drawing.Drawing2D;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GesmedWA.Views
{
    public partial class ListaClientes : System.Web.UI.Page
    {
        protected ClienteWSClient clienteWS;
        protected FarmaciaWSClient farmaciaWS;
        protected MedicoWSClient medicoWS;
        protected SupervisorWSClient supervisorWS;
        protected farmacia f;
        protected medico m;

        protected void Page_Init(object sender, EventArgs e)
        {
            clienteWS = new ClienteWSClient();
            farmaciaWS = new FarmaciaWSClient();
            medicoWS = new MedicoWSClient();

            char rol = (char)Session["rol"];
            int id_usuario = (int)Session["id"];
            switch (rol)
            {
                case 'R':
                    //Representante
                    btnInsertarFarmacia.Enabled = false;
                    btnInsertarDoctor.Enabled = false;
                    break;
                case 'S':
                    //Supervisor
                    lbBuscarSupervisor.Visible = false;
                    Session["id_supervisor"] = id_usuario;
                    break;
                default:
                    //TIENE TODOS LOS PERMISOS (Administrador)
                    supervisorWS = new SupervisorWSClient();
                    gvSupervisores.DataSource = supervisorWS.ListarSupervisorBriefXNombre(txtNombreSupervisor.Text);
                    gvSupervisores.DataBind();
                    break;
            }
        }
        protected void gvSupervisores_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Asignar el valor convertido al lblNombreSupervisor
                Label lblNombreSupervisor = (Label)e.Row.FindControl("lblNombreSupervisor");

                // Concatenar el nombre y el apellido paterno
                string nombre = DataBinder.Eval(e.Row.DataItem, "nombre").ToString();
                string apellidoPaterno = DataBinder.Eval(e.Row.DataItem, "apellidoPaterno").ToString();
                lblNombreSupervisor.Text = $"{nombre} {apellidoPaterno}";
            }
        }

        protected void lbSeleccionarSupervisor_Click(object sender, EventArgs e)
        {
            // Obtén la fila del GridView que contiene el botón que se hizo clic
            GridViewRow row = (GridViewRow)((LinkButton)sender).NamingContainer;

            // Obtén el ID del supervisor y el nombre directamente de los controles en esa fila
            Session["id_supervisor"] = Int32.Parse(((LinkButton)sender).CommandArgument);
            string nombreSupervisor = ((Label)row.FindControl("lblNombreSupervisor")).Text;

            // Mostrar el nombre del supervisor en un TextBox (asegúrate de tener un TextBox con el ID txtNombreSupervisor)
            txtNombreSupervisor.Text = nombreSupervisor;
            txtSupervisor.Text = nombreSupervisor;

            // Refrescar la página o la interfaz si es necesario
            CargarClientes();
            ScriptManager.RegisterStartupScript(this, GetType(), "", "__doPostBack('','');", true);
        }

        protected void lbBuscarSupervisorModal_Click(object sender, EventArgs e)
        {
            gvSupervisores.DataSource = supervisorWS.ListarSupervisorBriefXNombre(txtNombreSupervisor.Text);
            gvSupervisores.DataBind();
        }

        protected void gvSupervisores_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            // Establecer el nuevo índice de página
            gvSupervisores.PageIndex = e.NewPageIndex;

            // Volver a cargar los supervisores después de cambiar el índice de página
            gvSupervisores.DataSource = supervisorWS.ListarSupervisorBriefXNombre(txtNombreSupervisor.Text);
            gvSupervisores.DataBind();
        }

        private void CargarClientes()
        {
            int id_supervisor = Session["id_supervisor"] != null ? (int)Session["id_supervisor"] : 0;
            gvClientes.DataSource = clienteWS.ListarClientexSupervisorxNombre(txtBuscar.Text, id_supervisor);
            gvClientes.DataBind();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            CargarClientes();
        }
        protected void gvClientes_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Obtener el valor del tipo
                uint tipo = Convert.ToUInt32(DataBinder.Eval(e.Row.DataItem, "tipo"));
                // Convertir el valor a char
                char tipoChar = (char)tipo;  // Dependiendo del valor, esto debería ser un carácter válido

                // Asignar el valor convertido al lblTipo
                Label lblTipo = (Label)e.Row.FindControl("lblTipo");
                lblTipo.Text = tipoChar.ToString();

                int idCliente = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "idCliente"));
                Label lblNombre = (Label)e.Row.FindControl("lblNombre");
                Label lblDetalle = (Label)e.Row.FindControl("lblDetalle");
                if (tipoChar == 'M')
                {
                    m = medicoWS.obtenerMedicoXID(idCliente);
                    lblNombre.Text = m.nombre;
                    lblDetalle.Text = m.especialidad;
                }
                else if (tipoChar == 'F')
                {
                    f = farmaciaWS.obtenerFarmaciaXID(idCliente);
                    lblNombre.Text = f.nombreF;
                    lblDetalle.Text = f.tipoFarmacia.ToString();
                }
            }
        }
        protected void gvClientes_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            // Establecer el nuevo índice de página
            gvClientes.PageIndex = e.NewPageIndex;

            // Volver a cargar los clientes después de cambiar el índice de página
            CargarClientes();
        }

        protected void btnInsertarDoctor_Click(object sender, EventArgs e)
        {
            Response.Redirect("./GestionDoctores.aspx");
        }

        protected void btnInsertarFarmacia_Click(object sender, EventArgs e)
        {
            Response.Redirect("./GestionFarmacias.aspx");
        }

        protected void lbSeleccionarCliente_Click(object sender, EventArgs e)
        {
            int idCliente = Int32.Parse(((LinkButton)sender).CommandArgument);
            LinkButton lb = (LinkButton)sender;
            char tipoCliente = (char)Convert.ToUInt32(lb.Attributes["data-Tipo"]);

            if (tipoCliente == 'F')
                Response.Redirect($"./GestionFarmacias.aspx?op=view&idCliente={idCliente}");
            else if (tipoCliente == 'M')
                Response.Redirect($"./GestionDoctores.aspx?op=view&idCliente={idCliente}");
        }

        protected void btActualizarCliente_Click(object sender, EventArgs e)
        {
            int idCliente = Int32.Parse(((LinkButton)sender).CommandArgument);
            LinkButton lb = (LinkButton)sender;
            char tipoCliente = (char)Convert.ToUInt32(lb.Attributes["data-Tipo"]);

            if (tipoCliente == 'F')
                Response.Redirect($"./GestionFarmacias.aspx?op=edit&idCliente={idCliente}");
            else if (tipoCliente == 'M')
                Response.Redirect($"./GestionDoctores.aspx?op=edit&idCliente={idCliente}");
        }

        protected void btEliminarCliente_Click(object sender, EventArgs e)
        {
            char rol = (char)Session["rol"];
            if (rol != 'R')
            {
                btnAceptarError.Visible = true;
                int idCliente = Int32.Parse(((LinkButton)sender).CommandArgument);
                Session["idCliente"] = idCliente;

                LinkButton lb = (LinkButton)sender;
                char tipoCliente = (char)Convert.ToUInt32(lb.Attributes["data-Tipo"]);
                Session["tipoCliente"] = tipoCliente;

                ScriptManager.RegisterStartupScript(this, GetType(), "", "showModal('error-modal');", true);
            }
        }

        protected void btnCerrarError_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "", "closeModal('error-modal');", true);
        }
        protected void btnAceptarError_Click(object sender, EventArgs e)
        {
            if (Session["tipoCliente"].ToString() == "F") farmaciaWS.eliminarFarmacia((int)Session["idCliente"]);
            else if (Session["tipoCliente"].ToString() == "M") medicoWS.eliminarMedico((int)Session["idCliente"]);
            Response.Redirect("./ListaClientes.apsx");
        }
    }
}
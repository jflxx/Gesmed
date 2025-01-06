using GesmedWA.GesmedWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GesmedWA.Views
{
    public partial class GestionDoctores : System.Web.UI.Page
    {
        protected MedicoWSClient medicoWS;
        protected SupervisorWSClient supervisorWS;
        protected AdministradorWSClient administradorWS;
        private string op;
        private string idCliente;
        private medico medico;
        private administrador administrador;
        private supervisor supervisor;

        protected void Page_Init(object sender, EventArgs e)
        {
            administradorWS = new AdministradorWSClient();
            supervisorWS = new SupervisorWSClient();
            medicoWS = new MedicoWSClient();
            medico = new medico();

            op = Request.QueryString["op"];
            idCliente = Request.QueryString["idCliente"];

            gvSupervisores.DataSource = supervisorWS.ListarSupervisorBriefXNombre(txtSupervisor.Text);
            gvSupervisores.DataBind();

            gvAdministradores.DataSource = administradorWS.ListarAdministradorXNombre(txtAdministrador.Text);
            gvAdministradores.DataBind();

            operaciones();
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

        protected void gvAdministradores_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Asignar el valor convertido al lblNombreAdministrador
                Label lblNombreAdministrador = (Label)e.Row.FindControl("lblNombreAdministrador");

                // Concatenar el nombre y el apellido paterno
                string nombre = DataBinder.Eval(e.Row.DataItem, "nombre").ToString();
                string apellidoPaterno = DataBinder.Eval(e.Row.DataItem, "apellidoPaterno").ToString();
                lblNombreAdministrador.Text = $"{nombre} {apellidoPaterno}";
            }
        }

        void operaciones()
        {
            if (idCliente != null)
            {
                switch (op)
                {
                    case "view":
                        lblTitulo.Text = "Visulizar Medico";
                        break;
                    case "edit":
                        lblTitulo.Text = "Actualizar Medico";
                        break;
                }
                ObtenerDatosDoctor();
                DeshabilitarComponentes();
            }
            else
            {
                lblTitulo.Text = "Registrar Medico";
                ddlActivo.Enabled = false;
            }
        }

        void ObtenerDatosDoctor()
        {
            medico = medicoWS.obtenerMedicoXID(Int32.Parse(idCliente));
            txtDNI.Text = medico.DNI.ToString();
            txtNombre.Text = medico.nombre;
            txtApellidoPaterno.Text = medico.apellidoPaterno;
            txtApellidoMaterno.Text = medico.apellidoMaterno;
            ddlActivo.SelectedValue = medico.activo == 1 ? "1" : "2";
            txtCorreo.Text = medico.correo;
            txtNumeroTelefono.Text = medico.numero;
            txtLatitud.Text = medico.ubicacion.latitud.ToString();
            txtLongitud.Text = medico.ubicacion.longitud.ToString();
            txtAltitud.Text = medico.ubicacion.altitud.ToString();
            supervisor = supervisorWS.obtenerSupervisorXID(medico.idSupervisor);
            txtSupervisor.Text = supervisor.nombre + " " + supervisor.apellidoPaterno;
            //txtSupervisor.Text = farmacia.idSupervisor.ToString();
            txtAdministrador.Text = medico.idAdmin.ToString();
            txtEspecialidad.Text = medico.especialidad;
            txtNumColegiatura.Text = medico.numeroDeColegiatura.ToString();
        }

        void DeshabilitarComponentes()
        {
            txtDNI.Enabled = false;
            txtNombre.Enabled = false;
            txtApellidoPaterno.Enabled = false;
            txtApellidoMaterno.Enabled = false;
            ddlActivo.Enabled = false;
            txtCorreo.Enabled = false;
            txtNumeroTelefono.Enabled = false;
            txtLatitud.Enabled = false;
            txtLongitud.Enabled = false;
            txtAltitud.Enabled = false;
            txtSupervisor.Enabled = false;
            lbBuscarSupervisor.Visible = false;
            //lbBuscarSupervisorModal.Visible = false;
            //gvSupervisores.Enabled = false;
            txtAdministrador.Enabled = false;
            lbBuscarAdministrador.Visible = false;
            //lbBuscarAdministradorModal.Visible = false;
            //gvAdministradores.Enabled = false;
            if (op == "view")
            {
                txtEspecialidad.Enabled = false;
                txtNumColegiatura.Enabled = false;
                btnGuardar.Enabled = false;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            bool valido = false;
            valido = validarDatos(sender, e);
            string script;
            if (valido)
            {
                medico.DNI = Int32.Parse(txtDNI.Text);
                medico.nombre = txtNombre.Text;
                medico.apellidoPaterno = txtApellidoPaterno.Text;
                medico.apellidoMaterno = txtApellidoMaterno.Text;
                //medico.activo = ddlActivo.;
                medico.activo = 1;
                medico.correo = txtCorreo.Text;
                medico.numero = txtNumeroTelefono.Text;

                medico.ubicacion = new ubicacion();
                medico.ubicacion.latitud = Double.Parse(txtLatitud.Text);
                medico.ubicacion.longitud = Double.Parse(txtLongitud.Text);
                medico.ubicacion.altitud = Double.Parse(txtAltitud.Text);

                if (Session["idSupervisorSeleccionado"] != null && Session["idAdministradorSeleccionado"] != null)
                {
                    medico.idSupervisor = (int)Session["idSupervisorSeleccionado"];
                    medico.idAdmin = (int)Session["idAdministradorSeleccionado"];
                }
                //else modal de error XD

                medico.especialidad = txtEspecialidad.Text;
                medico.numeroDeColegiatura = Int32.Parse(txtNumColegiatura.Text);
                medico.tipo = 'M';

                if (op == "edit")
                {
                    medico.idMedico = Int32.Parse(idCliente);
                    medicoWS.actualizarMedico(medico);
                }
                else medicoWS.insertarMedico(medico);

                Response.Redirect("./ListaClientes.aspx");
            }
            else
            {
                script = "showModalFormError('error-modal');";
                ScriptManager.RegisterStartupScript(this, GetType(), "", script, true);
                return;
            }
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            string script = "showModal('confirmar-modal');";
            lblmodalconfirmar.Text = "Cancelar cambios";
            btnConfirmar.Text = "Si, cancelar";
            btnCerrarConfirm.Text = "No, conservar cambios";
            lblMensajeConfirmacion.Text = "¿Estas seguro que quieres cancelar los cambios?";
            ScriptManager.RegisterStartupScript(this, GetType(), "", script, true);
            Response.Redirect("./ListaClientes.aspx");
        }

        bool validarDatos(object sender, EventArgs e)
        {
            // Validar DNI
            if (string.IsNullOrWhiteSpace(txtDNI.Text) || !int.TryParse(txtDNI.Text, out int dni) || dni <= 0)
            {
                lblMensajeError.Text = "Error en el DNI: debe ser un número positivo.";
                return false;
            }

            // Validar Nombre de Contacto
            if (string.IsNullOrWhiteSpace(txtNombre.Text) || !txtNombre.Text.All(char.IsLetter))
            {
                lblMensajeError.Text = "Error en el Nombre: debe contener solo letras.";
                return false;
            }

            // Validar Apellido Paterno
            if (string.IsNullOrWhiteSpace(txtApellidoPaterno.Text) || !txtApellidoPaterno.Text.All(char.IsLetter))
            {
                lblMensajeError.Text = "Error en el Apellido Paterno: debe contener solo letras.";
                return false;
            }

            // Validar Apellido Materno
            if (string.IsNullOrWhiteSpace(txtApellidoMaterno.Text) || !txtApellidoMaterno.Text.All(char.IsLetter))
            {
                lblMensajeError.Text = "Error en el Apellido Materno: debe contener solo letras.";
                return false;
            }

            // Validar Correo
            if (string.IsNullOrWhiteSpace(txtCorreo.Text))
            {
                lblMensajeError.Text = "Error en el Correo: no puede estar vacío.";
                return false;
            }

            // Validar Número de Teléfono
            if (string.IsNullOrWhiteSpace(txtNumeroTelefono.Text) || !int.TryParse(txtNumeroTelefono.Text, out int numeroTelefono))
            {
                lblMensajeError.Text = "Error en el Número de Teléfono: debe ser un número válido.";
                return false;
            }

            // Validar Latitud
            if (string.IsNullOrWhiteSpace(txtLatitud.Text) || !double.TryParse(txtLatitud.Text, out double latitud))
            {
                lblMensajeError.Text = "Error en la Latitud: debe ser un número válido.";
                return false;
            }

            // Validar Longitud
            if (string.IsNullOrWhiteSpace(txtLongitud.Text) || !double.TryParse(txtLongitud.Text, out double longitud))
            {
                lblMensajeError.Text = "Error en la Longitud: debe ser un número válido.";
                return false;
            }

            // Validar Altitud
            if (string.IsNullOrWhiteSpace(txtAltitud.Text) || !double.TryParse(txtAltitud.Text, out double altitud))
            {
                lblMensajeError.Text = "Error en la Altitud: debe ser un número válido.";
                return false;
            }

            // Validar Sesiones
            if (Session["idSupervisorSeleccionado"] == null || Session["idAdministradorSeleccionado"] == null)
            {
                lblMensajeError.Text = "Error: Debe seleccionar un Supervisor y un Administrador.";
                return false;
            }

            // Validar Especialidad
            if (string.IsNullOrWhiteSpace(txtEspecialidad.Text) || !txtEspecialidad.Text.All(char.IsLetter))
            {
                lblMensajeError.Text = "Error en la especialidad: debe contener solo letras.";
                return false;
            }

            // Validar Número de Colegiatura
            if (string.IsNullOrWhiteSpace(txtNumColegiatura.Text) || !int.TryParse(txtNumColegiatura.Text, out int numeroLicencia))
            {
                lblMensajeError.Text = "Error en el Número de Colegiatura: debe ser un número válido.";
                return false;
            }

            // Si todas las validaciones pasan
            lblMensajeError.Text = ""; // Limpiar mensaje de error si todo es válido
            return true;
        }

        protected void lbBuscarAdministradorModal_Click(object sender, EventArgs e)
        {
            gvAdministradores.DataSource = administradorWS.ListarAdministradorXNombre(txtNombreAdministrador.Text);
            gvAdministradores.DataBind();
        }

        protected void lbSeleccionarAdministrador_Click(object sender, EventArgs e)
        {
            // Obtén la fila del GridView que contiene el botón que se hizo clic
            GridViewRow row = (GridViewRow)((LinkButton)sender).NamingContainer;

            // Obtén el ID del supervisor y el nombre directamente de los controles en esa fila
            int idAdministrador = Int32.Parse(((LinkButton)sender).CommandArgument);
            string nombreAdministrador = ((Label)row.FindControl("lblNombreAdministrador")).Text;

            // Guardar el supervisor seleccionado en la sesión
            Session["idAdministradorSeleccionado"] = idAdministrador;

            // Mostrar el nombre del supervisor en un TextBox (asegúrate de tener un TextBox con el ID txtNombreSupervisor)
            txtNombreAdministrador.Text = nombreAdministrador;
            txtAdministrador.Text = nombreAdministrador;

            // Refrescar la página o la interfaz si es necesario
            ScriptManager.RegisterStartupScript(this, GetType(), "", "__doPostBack('','');", true);
        }

        protected void gvAdministradores_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            // Establecer el nuevo índice de página
            gvSupervisores.PageIndex = e.NewPageIndex;

            // Volver a cargar los administradorees después de cambiar el índice de página
            gvAdministradores.DataSource = administradorWS.ListarAdministradorXNombre(txtNombreAdministrador.Text);
            gvAdministradores.DataBind();
        }

        protected void lbSeleccionarSupervisor_Click(object sender, EventArgs e)
        {
            // Obtén la fila del GridView que contiene el botón que se hizo clic
            GridViewRow row = (GridViewRow)((LinkButton)sender).NamingContainer;

            // Obtén el ID del supervisor y el nombre directamente de los controles en esa fila
            int idSupervisor = Int32.Parse(((LinkButton)sender).CommandArgument);
            string nombreSupervisor = ((Label)row.FindControl("lblNombreSupervisor")).Text;

            // Guardar el supervisor seleccionado en la sesión
            Session["idSupervisorSeleccionado"] = idSupervisor;

            // Mostrar el nombre del supervisor en un TextBox (asegúrate de tener un TextBox con el ID txtNombreSupervisor)
            txtNombreSupervisor.Text = nombreSupervisor;
            txtSupervisor.Text = nombreSupervisor;

            // Refrescar la página o la interfaz si es necesario
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
        protected void btnCerrarConfirm_Click(object sender, EventArgs e)
        {
            string script = "closeModal('confirmar-modal');";
            ScriptManager.RegisterStartupScript(this, GetType(), "", script, true);
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            medico.DNI = Int32.Parse(txtDNI.Text);
            medico.nombre = txtNombre.Text;
            medico.apellidoPaterno = txtApellidoPaterno.Text;
            medico.apellidoMaterno = txtApellidoMaterno.Text;
            //medico.activo = ddlActivo.;
            medico.activo = 1;
            medico.correo = txtCorreo.Text;
            medico.numero = txtNumeroTelefono.Text;

            medico.ubicacion = new ubicacion();
            medico.ubicacion.latitud = Double.Parse(txtLatitud.Text);
            medico.ubicacion.longitud = Double.Parse(txtLongitud.Text);
            medico.ubicacion.altitud = Double.Parse(txtAltitud.Text);

            if (Session["idSupervisorSeleccionado"] != null && Session["idAdministradorSeleccionado"] != null)
            {
                medico.idSupervisor = (int)Session["idSupervisorSeleccionado"];
                medico.idAdmin = (int)Session["idAdministradorSeleccionado"];
            }
            //else modal de error XD

            medico.especialidad = txtEspecialidad.Text;
            medico.numeroDeColegiatura = Int32.Parse(txtNumColegiatura.Text);
            medico.tipo = 'M';

            if (op == "edit")
            {
                medico.idMedico = Int32.Parse(idCliente);
                medicoWS.actualizarMedico(medico);
            }
            else medicoWS.insertarMedico(medico);

            Response.Redirect("./ListaClientes.aspx");
        }
    }
}
using GesmedWA.GesmedWS;
using System;
using System.Web.UI;

namespace GesmedWA.Views
{
    public partial class GestionSupervisores : System.Web.UI.Page
    {
        //   private AdministradorWSClient daoAdministrador = new AdministradorWSClient();
        //  string idAdministrador;
        private SupervisorWSClient daoSupervisor;
        supervisor supervisor;
        string script;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Page_Init(object sender, EventArgs e)
        {
            daoSupervisor = new SupervisorWSClient();


            string idSupervisor = Request.QueryString["idSupervisor"];
            string accion = Request.QueryString["accion"];

            if (accion != null && accion == "ver" && idSupervisor != null)
            {
                lblTitulo.Text = "Visualizar Supervisor";
                supervisor super = daoSupervisor.obtenerSupervisorXID(Int32.Parse(idSupervisor));
                txtDNI.Text = super.DNI.ToString();
                txtNombre.Text = super.nombre;
                txtApellidoPaterno.Text = super.apellidoPaterno;
                txtApellidoMaterno.Text = super.apellidoMaterno;
                if (super.idTrabajador.activo)
                {
                    ddlOpciones.Text = "1";
                }
                else
                {
                    ddlOpciones.Text = "0";
                }
                txtCorreo.Text = super.correo;
                txtNumeroTelefono.Text = super.numero;
                txtDistrito.Text = super.distrito;
                txtUsername.Text = super.idTrabajador.user;
                Deshabilitar_Componentes();
            }
            else if (accion != "editar")
            {
                lblTitulo.Text = "Registrar Supervisor";
            }
            else if (accion == "editar" && idSupervisor != null)
            {
                lblTitulo.Text = "Editar Supervisor";
                supervisor super = daoSupervisor.obtenerSupervisorXID(Int32.Parse(idSupervisor));
                txtDNI.Text = super.DNI.ToString();
                txtNombre.Text = super.nombre;
                txtApellidoPaterno.Text = super.apellidoPaterno;
                txtApellidoMaterno.Text = super.apellidoMaterno;
                if (super.idTrabajador.activo)
                {
                    ddlOpciones.Text = "1";
                }
                else
                {
                    ddlOpciones.Text = "0";
                }
                txtCorreo.Text = super.correo;
                txtNumeroTelefono.Text = super.numero;
                txtDistrito.Text = super.distrito;
                txtUsername.Text = super.idTrabajador.user;
                Deshabilitar_Componentes_Editar();
            }

        }
        public void Deshabilitar_Componentes()
        {
            txtDNI.Enabled = false;
            txtNombre.Enabled = false;
            txtApellidoPaterno.Enabled = false;
            txtApellidoMaterno.Enabled = false;
            ddlOpciones.Enabled = false; // Esto deshabilitará todo el RadioButton
            txtCorreo.Enabled = false;
            txtNumeroTelefono.Enabled = false;
            txtUsername.Enabled = false;
            txtPassword.Enabled = false;
            txtDistrito.Enabled = false;
        }
        public void Deshabilitar_Componentes_Editar()
        {
            txtDNI.Enabled = false;
            txtNombre.Enabled = false;
            txtApellidoPaterno.Enabled = false;
            txtApellidoMaterno.Enabled = false;
            txtPassword.Enabled = false;
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            Response.Redirect("./ListaSupervisores.aspx");
        }

        protected void btnConfirmarGuardar_click(object sender, EventArgs e)
        {
            int resultado=-1;
            int flag = 0;
            string accion = Request.QueryString["accion"];
            if (accion != "editar")
            {
                resultado = daoSupervisor.insertarSupervisor((supervisor)Session["supervisor"]);
                flag = 1;
            }
            else
            {
                resultado = daoSupervisor.actualizarSupervisor((supervisor)Session["supervisor"]);
                flag = 2;
            }
            if (resultado != 0)
                Response.Redirect("./ListaSupervisores.aspx");
            if (flag == 1)
            {
                script = "showModalFormError('error-modal');";
                lblMensajeError.Text = "No se logró editar exitosamente";
                ScriptManager.RegisterStartupScript(this, GetType(), "", script, true);
            }
            else
            {
                script = "showModalFormError('error-modal');";
                lblMensajeError.Text = "No se logró insertar exitosamente";
                ScriptManager.RegisterStartupScript(this, GetType(), "", script, true);
            }
            

        }
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            string idSupervisor = Request.QueryString["idSupervisor"];
            string accion = Request.QueryString["accion"];
            supervisor = new supervisor();
            if (accion == "editar")
            {
                supervisor.idSupervisor = Int32.Parse(idSupervisor);
            }
            supervisor.DNI = int.Parse(txtDNI.Text);
            supervisor.nombre = txtNombre.Text;
            supervisor.apellidoPaterno = txtApellidoPaterno.Text;
            supervisor.apellidoMaterno = txtApellidoMaterno.Text;
            supervisor.activo = int.Parse(ddlOpciones.Text);
            supervisor.correo = txtCorreo.Text;
            supervisor.numero = txtNumeroTelefono.Text;
            supervisor.idTrabajador = new usuario();
            supervisor.idTrabajador.user = txtUsername.Text;
            supervisor.idTrabajador.password = txtPassword.Text;
            if (ddlOpciones.Text == "1")
            {
                supervisor.idTrabajador.activo = true;
            }
            else
            {
                supervisor.idTrabajador.activo = false;
            }
            supervisor.distrito = txtDistrito.Text;
            supervisor.fidAdministrador = (int)Session["id"];
            supervisor.rol = 'S';
            Session["supervisor"]=supervisor;
            bool modalError = mostrarFaltaDatos(supervisor, accion);
            if (modalError)
            {
                script = "showModalFormError('error-modal');";
                ScriptManager.RegisterStartupScript(this, GetType(), "", script, true);
                return;
            }
            if (accion != "editar")
            {
                labelGuardar.Text = "¿Esta seguro de que desea insertar al supervisor " + supervisor.nombre+" "+supervisor.apellidoPaterno+" ?";
            }
            else
            {
                labelGuardar.Text = "¿Esta seguro de que desea modificar los datos?";
            }
            script = "showModalFormError('guardarModal');";
            ScriptManager.RegisterStartupScript(this, GetType(), "", script, true);
        }
        protected bool mostrarFaltaDatos(supervisor supervisorNuevo, string accion)
        {
            if (supervisor.DNI == 0)
            {
                lblMensajeError.Text = "Inserta el DNI";
                return true;
            }
            if (supervisor.nombre == "")
            {
                lblMensajeError.Text = "Inserta el nombre";
                return true;
            }
            if (supervisor.apellidoPaterno == "")
            {
                lblMensajeError.Text = "Inserta el apellido paterno";
                return true;
            }
            if (supervisor.apellidoMaterno == "")
            {
                lblMensajeError.Text = "Inserta el apellido materno";
                return true;
            }
            if (supervisor.correo == "")
            {
                lblMensajeError.Text = "Inserta el correo";
                return true;
            }
            if (supervisor.distrito == "")
            {
                lblMensajeError.Text = "Inserta el distrito";
                return true;
            }
            if (supervisor.numero == "")
            {
                lblMensajeError.Text = "Inserta el numero";
                return true;
            }
            if (supervisor.idTrabajador.password == "" && accion =="insertar")
            {
                lblMensajeError.Text = "Inserta el password";
                return true;
            }
            if (supervisor.idTrabajador.user == "")
            {
                lblMensajeError.Text = "Inserta el usuario";
                return true;
            }
            return false;
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GesmedWA.GesmedWS;
using System.ComponentModel;
namespace GesmedWA.Views
{
    public partial class GestionRepresentantes : System.Web.UI.Page
    {
        protected RepresentanteMedicoWSClient representanteDAO = new RepresentanteMedicoWSClient();
        private SupervisorWSClient supervisorDAO = new SupervisorWSClient();
        private string op;
        private string id;
        private representanteMedico representante;
        private supervisor sp;
        private usuario user;
        private bool guardar;
        protected void Page_Init(object sender, EventArgs e)
        {
            
            char rol = (char)Session["rol"];
            representanteDAO = new RepresentanteMedicoWSClient();
            representante = new representanteMedico();
            user = new usuario();
            switch (rol)
            {
                case 'A':
                    op = Request.QueryString["op"];
                    break;
                case 'S':
                    op = "view";
                    break;
                default:
                    Response.Redirect("../Inicio/Home.aspx");
                    break;
            }
            id = Request.QueryString["id"];
            if ((op == "edit" || op=="view") && id != null)
            {
                ObtenerDatosRepresentante();
                switch (op)
                {
                    case "view":
                        lblTitulo.Text = "Visulizar Representante Medico";
                        DeshabilitarComponentes();
                        break;
                    case "edit":
                        DeshabilitarParaEditar();
                        lblTitulo.Text = "Actualizar Representante Medico";
                        break;
                }
            }
            else lblTitulo.Text = "Registrar Representante Medico";
        }

        private void DeshabilitarParaEditar()
        {
            txtDNI.Enabled = false;
            txtNombre.Enabled = false;
            txtApellidoPaterno.Enabled = false;
            txtApellidoMaterno.Enabled = false;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Carga inicial
                if (op == "edit" && id != null)
                {
                    ObtenerDatosRepresentante();
                }
            }
            else
            {
                // Restaurar el valor de txtPassword desde el ViewState
                if (ViewState["Password"] != null)
                {
                    txtPassword.Attributes["value"] = ViewState["Password"].ToString();
                }
            }
            gvSupervisores.DataSource = supervisorDAO.listarSupervisorPorNombreOApellido(txtNombreCodigoSupervisor.Text);
            gvSupervisores.DataBind();
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
            txtPassword.Enabled = false;
            txtSupervisor.Enabled = false;
            txtUsername.Enabled = false;
            txtSubzona.Enabled = false;
            btnBuscarSupervisor.Visible = false;
            btnGuardar.Visible = false;
        }
        void ObtenerDatosRepresentante()
        {
            representanteMedico temp = representanteDAO.ObtenerRepresentanteMedicoXID(Int32.Parse(id));
            txtDNI.Text = temp.DNI.ToString();
            txtNombre.Text = temp.nombre;
            txtApellidoPaterno.Text = temp.apellidoPaterno;
            txtApellidoMaterno.Text = temp.apellidoMaterno;
            ddlActivo.SelectedValue = temp.activo == 1 ? "1" : "2";
            txtCorreo.Text = temp.correo;
            txtNumeroTelefono.Text = temp.numero;
            txtPassword.Text = temp.idTrabajador.password;
            txtUsername.Text = temp.idTrabajador.user;
            actualizarPanelSupervisor(temp.fidSupervisor);
            txtSubzona.Text = temp.subZona;
            Session["id"] = temp.idRepresentanteMedico;
            Session["idSup"] = temp.fidSupervisor;
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            guardar = false;
            Session["guardar"] = false;
            string script = "showModal('confirmar-modal');";
            lblmodalconfirmar.Text = "Cancelar cambios";
            btnConfirmar.Text = "Si, cancelar";
            btnCerrarConfirm.Text = "No, conservar cambios";
            lblMensajeConfirmacion.Text = "¿Estas seguro que quieres cancelar los cambios?";
            CallJavascript(script);
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            ViewState["Password"] = txtPassword.Text;
            Session["guardar"] = true; 
            string script = "showModal('confirmar-modal');";
            CallJavascript(script);
        }

        protected void lbBuscarSupervisorModal_Click(object sender, EventArgs e)
        {
            gvSupervisores.DataSource = supervisorDAO.listarSupervisorPorNombreOApellido(txtNombreCodigoSupervisor.Text);
            gvSupervisores.DataBind();
        }

        protected void lbSeleccionarSupervisor_Click(object sender, EventArgs e)
        {
            int idSupervisor = int.Parse(((LinkButton)sender).CommandArgument);
            actualizarPanelSupervisor(idSupervisor);
            Session["idSup"] = idSupervisor;
            ScriptManager.RegisterStartupScript(this, GetType(), "", "__doPostBack('', '');", true);
        }

        protected void actualizarPanelSupervisor(int idSupervisor)
        {
            sp = supervisorDAO.obtenerSupervisorXID(idSupervisor);
            Session["supervisor"] = sp;
            txtIdSupervisor.Text = sp.idSupervisor.ToString();
            txtNombreSupervisor.Text = sp.nombre + " " + sp.apellidoPaterno;
            txtSubzonaSupervisor.Text = sp.distrito;
            txtSupervisor.Text = sp.nombre + " " + sp.apellidoPaterno;
        }

        protected void gvSupervisores_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvSupervisores.PageIndex = e.NewPageIndex;
            gvSupervisores.DataBind();
        }

        protected void btnBuscarSupervisor_Click(object sender, EventArgs e)
        {
        }

        protected void btnCerrarConfirm_Click(object sender, EventArgs e)
        {
            string script = "closeModal('confirmar-modal');";
            CallJavascript(script);
        }
        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            guardar = (Boolean)Session["guardar"];
            if (guardar)
            {
                representante.DNI = int.Parse(txtDNI.Text);
                representante.nombre = txtNombre.Text;
                representante.apellidoPaterno = txtApellidoPaterno.Text;
                representante.apellidoMaterno = txtApellidoMaterno.Text;
                representante.activo = ddlActivo.SelectedValue == "1" ? 1 : 0;
                representante.correo = txtCorreo.Text;
                representante.numero = txtNumeroTelefono.Text;

                user.user = txtUsername.Text;
                user.password = ViewState["Password"]?.ToString();
                representante.idTrabajador = user;

                representante.subZona = txtSubzona.Text;
                sp = (supervisor)Session["supervisor"];
                representante.fidSupervisor = (int)Session["idSup"];

                if (op == "edit")
                {
                    representante.idRepresentanteMedico = (int)Session["id"];
                    representanteDAO.actualizarRepresentante(representante);
                }
                else
                {
                    representanteDAO.insertarRepresentante(representante);
                }
            }
            Response.Redirect("./ListaRepresentantes.aspx");
        }
        private void CallJavascript(string script)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "", script, true);
        }
    }
}
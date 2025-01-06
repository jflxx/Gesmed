using System;
using System.ComponentModel;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using GesmedWA.GesmedWS;

namespace GesmedWA.Views {
	public partial class GestionVisitas : System.Web.UI.Page {
		//ATRIBUTOS
		private VisitaWSClient visitaDAO;
		private RepresentanteMedicoWSClient representanteDAO;
		private FarmaciaWSClient farmaciaDAO;
		private MedicoWSClient medicoDAO;
		private ClienteWSClient clienteDAO;

		private string op;
		private string id;

		//METODOS
		protected void Page_Init(object sender, EventArgs e) {
			char rol = (char)Session["rol"];
			op = Request.QueryString["op"];
			id = Request.QueryString["id"];

			switch (rol) {
				case 'R':
					//TIENE TODOS LOS PERMISOS
					if (op == null || op == "edit") Response.Redirect("./ListaVisitas.aspx");
					break;
				default:
					//Administrador o Supervisor
					break;
			}

			visitaDAO = new VisitaWSClient();
			representanteDAO = new RepresentanteMedicoWSClient();
			farmaciaDAO = new FarmaciaWSClient();
			medicoDAO = new MedicoWSClient();
			clienteDAO = new ClienteWSClient();

			//Esto antes estaba en el Page_Load
			
			if (op != null && id != null) {
				ObtenerDatosVisita();
				switch (op) {
					case "view":
						lblTitulo.Text = "Visulizar Visita";
						DeshabilitarComponentes();
						break;
					case "edit":
						lblTitulo.Text = "Actualizar Visita";
						HabilitarActualizacion();
						break;
				}
			}
			else lblTitulo.Text = "Registrar Visita";
			
		}
		protected void Page_Load(object sender, EventArgs e) {
			gvRepresentantes.DataSource =
				representanteDAO.ListarRepresentanteMedicoPorNombreOApellido(txtNombreCodigoRepresentante.Text);
			gvRepresentantes.DataBind();
		}
		private void ObtenerDatosVisita() {
			//Aca obtenemos los datos por ID
			visita temp = visitaDAO.obtenerPorID(Int32.Parse(id));

			txtIdVisita.Text = temp.idVisita.ToString();
			txtNombreCliente.Text = temp.cliente.nombre;

			string ubiTemp = "" + temp.cliente.ubicacion.latitud + "; " + temp.cliente.ubicacion.longitud +
				"; " + temp.cliente.ubicacion.altitud;
			txtUbicacionCliente.Text = ubiTemp;

			txtIdCliente.Text = temp.cliente.idCliente.ToString();
			txtDetallesVisita.Text = temp.detallesVisita;

			txtIdRepresetante.Text = temp.representante.idRepresentanteMedico.ToString();
			txtNombreRepresentante.Text = temp.representante.nombre;
			txtSubzonaRepresentante.Text = temp.representante.subZona;

			dtpFechaVisita.Text = temp.fecha.ToString("yyyy-MM-dd");
			dtpHoraVisita.Text = temp.hora.ToShortTimeString();

			//Para el ddl
			switch (temp.tipoVisita) {
				case tipoVisita.GEORREFERENCIA:
					ddlTipoVisita.SelectedValue = "2";
					break;
				case tipoVisita.GEOLOCALIZACION:
					ddlTipoVisita.SelectedValue = "3";
					break;
			}

			//Para los rb
			switch (temp.estado) {
				case estadoVisita.PROGRAMADA:
					rbProgramada.Checked = true;
					break;
				case estadoVisita.EN_PROGRESO:
					rbEnProgreso.Checked = true;
					break;
				case estadoVisita.FINALIZADO:
					rbFinalizado.Checked = true;
					break;
				case estadoVisita.CANCELADO:
					rbCancelado.Checked = true;
					break;
			}

			//Para el tipo
			switch (temp.cliente.tipo) {
				case 'F':
					txtTipoCliente.Text = "FARMACIA";
					break;
				case 'M':
					txtTipoCliente.Text = "MEDICO";
					break;
			}
		}
		private void DeshabilitarComponentes() {
			txtIdCliente.Enabled = false;
			txtIdVisita.Enabled = false;
			txtNombreCliente.Enabled = false;
			txtTipoCliente.Enabled = false;
			txtIdCliente.Enabled = false;
			txtDetallesVisita.Enabled = false;

			btnGuardar.Enabled = false;
			btnBuscarCliente.Enabled = false;
			btnBuscarRepresentante.Enabled = false;

			dtpFechaVisita.Enabled = false;
			dtpHoraVisita.Enabled = false;

			rbEnProgreso.Disabled = true;
			rbFinalizado.Disabled = true;
			rbCancelado.Disabled = true;
			rbProgramada.Disabled = true;

			ddlTipoVisita.Enabled = false;
		}
		private void HabilitarActualizacion() {
			btnBuscarCliente.Enabled = false;

			rbProgramada.Disabled = false;
			rbCancelado.Disabled = false;
			rbEnProgreso.Disabled = false;
			rbFinalizado.Disabled = false;
			
			ddlTipoVisita.Enabled = false;
		}
		protected void btnBuscarCliente_Click(object sender, EventArgs e) {
			string script = "showModal('cliente-modal');";
			CallJavascript(script);
		}
		private void CallJavascript(string script) {
			ScriptManager.RegisterStartupScript(this, GetType(), "", script, true);
		}
		protected void lbBuscarClienteModal_Click(object sender, EventArgs e) {	
			if (ddlTipoCliente.SelectedValue == "2") {
				medico[] lis = medicoDAO.listarMedicos();
				gvClientes.DataSource = lis;
			}
			else if (ddlTipoCliente.SelectedValue == "3") {
				farmacia[] lis = farmaciaDAO.listarFarmacias();
				//Para actualizar datos
				foreach(farmacia farm in lis) {
					farm.nombre = farm.nombreF;
				}
				gvClientes.DataSource = lis;
			}
			gvClientes.DataBind();
		}
		protected void lbSeleccionarCliente_Click(object sender, EventArgs e) {
			//OJO: Aca podemos usar la variable Session para evitar missclick de parte del usuario
			int idCli = Int32.Parse(((LinkButton)sender).CommandArgument);
			switch (ddlTipoCliente.SelectedValue) {
				case "2":
					medico med = medicoDAO.obtenerMedicoXID(idCli);
					Session["CliSeleccionado"] = med;
					txtIdCliente.Text = med.idCliente.ToString();
					txtNombreCliente.Text = med.nombre.ToString();
					txtUbicacionCliente.Text = "" + med.ubicacion.latitud.ToString() + "; " + med.ubicacion.longitud.ToString()
						+ "; " + med.ubicacion.altitud.ToString();
					txtTipoCliente.Text = "Médico";
					break;
				case "3":
					farmacia farm = farmaciaDAO.obtenerFarmaciaXID(idCli);
					Session["CliSeleccionado"] = farm;
					txtIdCliente.Text = farm.idPersona.ToString();
					txtNombreCliente.Text = farm.nombreF.ToString();
					txtUbicacionCliente.Text = "" + farm.ubicacion.latitud.ToString() + "; " + farm.ubicacion.longitud.ToString()
						+ "; " + farm.ubicacion.altitud.ToString();
					txtTipoCliente.Text = "Farmacia";
					break;
			}
			ScriptManager.RegisterStartupScript(this, GetType(), "", "__doPostBack('', '');", true);
		}
		protected void gvClientes_PageIndexChanging(object sender, GridViewPageEventArgs e) {
			gvClientes.PageIndex = e.NewPageIndex;
			gvClientes.DataBind();
		}
		protected void btnRegresar_Click(object sender, EventArgs e) {
			Response.Redirect("./ListaVisitas.aspx");
		}
		protected void btnGuardar_Click(object sender, EventArgs e) {
			if (this.DetectarErroresEnDatosDeIngreso()) {
				CallJavascript("showModal('error-modal')");
				return;
			}
			//Creamos el elemento visita a insertar
			visita resultado = new visita {
				cliente = new cliente(),
				representante = new representanteMedico()
			};
			//Guardamos los datos desde el formulario
			resultado.cliente.idCliente = Int32.Parse(txtIdCliente.Text);
			resultado.representante.idRepresentanteMedico = Int32.Parse(txtIdRepresetante.Text);

			resultado.detallesVisita = txtDetallesVisita.Text;

			//Probando los 2 casos
			resultado.fecha = DateTime.Parse(dtpFechaVisita.Text);
			resultado.fechaSpecified = true;

			//El localTime no funciona
			resultado.hora = DateTime.Parse(dtpHoraVisita.Text);
			resultado.horaSpecified = true;

			//Probando los 2 casos
			resultado.tipoVisita = (tipoVisita)Enum.Parse(typeof(tipoVisita), ddlTipoVisita.SelectedItem.Text);
			resultado.tipoVisitaSpecified = true;

			//POR default SIEMPRE SE INSERTA CON PROGRAMADA, este es solo para actualizar
			if (rbProgramada.Checked) resultado.estado = estadoVisita.PROGRAMADA;
			else if (rbEnProgreso.Checked) resultado.estado = estadoVisita.EN_PROGRESO;
			else if (rbFinalizado.Checked) resultado.estado = estadoVisita.FINALIZADO;
			else if (rbCancelado.Checked) resultado.estado = estadoVisita.CANCELADO;
			resultado.estadoSpecified = true;

			if (resultado.estado == estadoVisita.FINALIZADO) resultado.visitado = true;
			else resultado.visitado = false;

			//Llamando al WS para insertar la visita en la Base de Datos
			if(op == "edit") {
				resultado.idVisita = Int32.Parse(txtIdVisita.Text);
				if(visitaDAO.actualizarVisita(resultado) != -1) Response.Redirect("./ListaVisitas.aspx");
				else {
					lblMensajeError.Text = "No se pudo actualizar la vista";
					CallJavascript("showModal('error-modal')");
				}
			}
			else {
				if (visitaDAO.insertarVisita(resultado) != -1) Response.Redirect("./ListaVisitas.aspx");
				else {
					lblMensajeError.Text = "No se pudo insertar la vista";
					CallJavascript("showModal('error-modal')");
				}
			}
		}
		private bool DetectarErroresEnDatosDeIngreso() {
			if (ddlTipoVisita.SelectedValue == "1") {
				lblMensajeError.Text = "Debe ingresar el tipo de visita";
				return true;
			}

			if (dtpHoraVisita.Text == "" || dtpFechaVisita.Text == "") {
				lblMensajeError.Text = "Debe ingresar la fecha y hora obligatoriamente";
				return true;
			}

			if (DateTime.Parse(dtpFechaVisita.Text + " " + dtpHoraVisita.Text + ":00") < DateTime.Now) {
				lblMensajeError.Text = "La fecha no puede ser inferior al día de hoy";
				return true;
			}

			if(txtIdCliente.Text == "" || txtIdRepresetante.Text == "") {
				lblMensajeError.Text = "Debe ingresar un cliente y supervisor obligatoriamente";
				return true;
			}
			return false;
		}
		protected void btnCerrarError_Click(object sender, EventArgs e) {
			string script = "closeModal('error-modal');";
			CallJavascript(script);
		}
		protected void btnBuscarRepresentante_Click(object sender, EventArgs e) {
			string script = "showModal('representante-modal');";
			CallJavascript(script);
		}
		protected void lbBuscarRepresentante_Click(object sender, EventArgs e) {
			gvRepresentantes.DataSource =
				representanteDAO.ListarRepresentanteMedicoPorNombreOApellido(txtNombreCodigoRepresentante.Text);
			gvRepresentantes.DataBind();
		}
		protected void gvRepresentantes_PageIndexChanging(object sender, GridViewPageEventArgs e) {
			gvRepresentantes.PageIndex = e.NewPageIndex;
			gvRepresentantes.DataBind();
		}
		protected void lbSeleccionarRepresentante_Click(object sender, EventArgs e) {
			int idRep = Int32.Parse(((LinkButton)sender).CommandArgument);
			representanteMedico representante = representanteDAO.ObtenerRepresentanteMedicoXID(idRep);
			Session["RepSelecciondo"] = representante;
			txtIdRepresetante.Text = representante.idRepresentanteMedico.ToString();
			txtNombreRepresentante.Text = representante.nombre + " " + representante.apellidoPaterno;
			txtSubzonaRepresentante.Text = representante.subZona;
			ScriptManager.RegisterStartupScript(this, GetType(), "", "__doPostBack('', '');", true);
		}
	}
}
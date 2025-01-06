using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GesmedWA.GesmedWS;

namespace GesmedWA.Views {
	public partial class ListaVisitas : System.Web.UI.Page {
		//ATRIBUTOS
		private VisitaWSClient visitaDAO;
		private char rol;
		//METODOS
		protected void Page_Init(object sender, EventArgs e) {
			rol = (char)Session["rol"];
			switch (rol) {
				case 'A':
					ViewState["EsRepresentante"] = false;
					break;
				case 'S':
					ModoSupervisor();
					break;
				default:
					ModoRepresentante();
					break;
			}
			visitaDAO = new VisitaWSClient();

			switch (rol) {
				case 'R':
					btnInsertar.Visible = false;
					gvVisitas.DataSource = visitaDAO.listarPorIDRepresentante((int)Session["id"]);
					//Aca deberia ser buscar por fecha
					break;
				default:
					gvVisitas.DataSource = visitaDAO.listarVisita();
					break;
			}
			gvVisitas.DataBind();
		}
		private void ModoRepresentante() {
			ViewState["EsRepresentante"] = true;
			btnInsertar.Enabled = false;
		}
		private void ModoSupervisor() {
			//EL SUPERVISOR PUEDE GESTIONAR TODA LA VISITA
			ViewState["EsRepresentante"] = false;
		}
		protected void Page_Load(object sender, EventArgs e) {
			if (!IsPostBack) {
				//Ver como arreglar lo del Page_Init
			}
		}
		protected void btnInsertar_Click(object sender, EventArgs e) {
			Response.Redirect("./GestionVisitas.aspx");
		}
		protected void gvVisitas_PageIndexChanging(object sender, GridViewPageEventArgs e) {
			gvVisitas.PageIndex = e.NewPageIndex;
			gvVisitas.DataBind();
		}
		protected void gvVisitas_RowDataBound(object sender, GridViewRowEventArgs e) {
			bool esRepresentante = ViewState["EsRepresentante"] != null && (bool)ViewState["EsRepresentante"];
			if (e.Row.RowType == DataControlRowType.DataRow) {
				if (esRepresentante) {
					LinkButton btEliminarVisita = (LinkButton)e.Row.FindControl("btEliminarVisita");
					LinkButton btActualizarVisita = (LinkButton)e.Row.FindControl("btActualizarVisita");
					if (btEliminarVisita != null) btEliminarVisita.Visible = false;
					if (btActualizarVisita != null) btActualizarVisita.Visible = false;
				}
				LinkButton btCompletarVisita = (LinkButton)e.Row.FindControl("btCompletarVisita");
				estadoVisita estado = (estadoVisita)Enum.Parse(typeof(estadoVisita), e.Row.Cells[6].Text);
				if (estado == estadoVisita.CANCELADO || estado == estadoVisita.FINALIZADO)
					if (btCompletarVisita != null) btCompletarVisita.Visible = false;

				e.Row.Cells[3].Text = 
					Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "fecha")).ToString("dd-MM-yyyy");
				e.Row.Cells[4].Text = 
					Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "hora")).ToString("HH:mm");
			}
		}
		protected void btMostrarDatos_Click(object sender, EventArgs e) {
			int idVisita = Int32.Parse(((LinkButton)sender).CommandArgument);
			Response.Redirect("./GestionVisitas.aspx?op=view&id=" + idVisita);
		}
		protected void btnBuscarVisita_Click(object sender, EventArgs e) {
			BindingList<visita> lis;
			switch (Int32.Parse(ddlBuscarPor.SelectedValue)) {
				case 1:
					//Deberia ser un listarPorClienteYRepresentante
					switch (rol) {
						case 'R':
							lis = new BindingList<visita>(visitaDAO.listarPorIDRepresentante((int)Session["id"]).ToList());
							//Aca deberia ser buscar por fecha
							break;
						default:
							lis = new BindingList<visita>(visitaDAO.listarVisita().ToList());
							break;
					}
					string txtB = txtBuscar.Text.ToUpper();
					gvVisitas.DataSource = lis.Where(x => x.cliente.nombre.ToUpper().Contains(txtB)).ToList();
					gvVisitas.DataBind();
					break;
				case 2:
					if (rol == 'R') return;
					gvVisitas.DataSource = visitaDAO.listarPorRepresentante(txtBuscar.Text);
					gvVisitas.DataBind();
					break;
				case 3:
					if (txtBuscar.Text.ToUpper() == "GEORREFERENCIA") {
						gvVisitas.DataSource = visitaDAO.listarPorTipo(tipoVisita.GEORREFERENCIA);
					}
					else if (txtBuscar.Text.ToUpper() == "GEOLOCALIZACION") {
						gvVisitas.DataSource = visitaDAO.listarPorTipo(tipoVisita.GEOLOCALIZACION);
					}
					else {
						lblMensajeError.Text = "Ingrese GEORREFERENCIA o GEOLOCALIZACION";
						btnAceptarError.Visible = false;
						CallJavascript("showModal('error-modal');");
					}
					gvVisitas.DataBind();
					break;
			}
		}
		private void CallJavascript(string script) {
			ScriptManager.RegisterStartupScript(this, GetType(), "", script, true);
		}

		protected void btEliminarVisita_Click(object sender, EventArgs e) {
			lblMensajeError.Text = "¿Está seguro que desea eliminar esta visita?";
			btnCerrarError.Text = "No, cancelar";

			btnAceptarError.Visible = true;
			btnAceptarError.Text = "Sí, eliminar";

			btnAceptarError.CommandArgument = ((((LinkButton)sender)).CommandArgument);

			CallJavascript("showModal('error-modal');");
		}

		protected void btActualizarVisita_Click(object sender, EventArgs e) {
			int idVisita = Int32.Parse(((LinkButton)sender).CommandArgument);
			Response.Redirect("./GestionVisitas.aspx?op=edit&id=" + idVisita);
		}

		protected void btnCerrarError_Click(object sender, EventArgs e) {
			//SOLO CIERRA EL MODAL
			CallJavascript("closeModal('error-modal');");
			btnAceptarError.Visible = true;
		}

		protected void btnAceptarError_Click(object sender, EventArgs e) {
			if (((Button)sender).CommandArgument != null) {
				if(visitaDAO.eliminarVisita(Int32.Parse(((Button)sender).CommandArgument)) == 1) 
					Response.Redirect("./ListaVisitas.aspx");
			}
		}
		protected void btnOrdenarVisita_Click(object sender, EventArgs e) {
			if (ddlTipoOrdenamiento.SelectedValue == "0") return;
			visita[] visitas;
			switch (rol) {
				case 'R':
					visitas = visitaDAO.listarPorIDRepresentante((int)Session["id"]);
					break;
				default:
					visitas = visitaDAO.listarVisita();
					break;
			}
			BindingList<visita> temp = new BindingList<visita>(visitas);
			switch (ddlTipoOrdenamiento.SelectedValue) {
				case "1":
					gvVisitas.DataSource = temp.OrderBy(v => v.fecha).ToList();
					break;
				case "2":
					gvVisitas.DataSource = temp.OrderBy(v => v.representante.nombre).ToList();
					break;
				case "3":
					gvVisitas.DataSource = temp.OrderBy(v => v.cliente.nombre).ToList();
					break;
				case "4":
					gvVisitas.DataSource = temp.OrderBy(v => v.estado.ToString()).ToList();
					break;
				case "5":
					gvVisitas.DataSource = temp.OrderBy(v => v.tipoVisita.ToString()).ToList();
					break;
			}
			gvVisitas.AllowPaging = true;
			gvVisitas.DataBind();
		}

		protected void btCompletarVisita_Click(object sender, EventArgs e) {
			//Un string para abrir el modal
			btnFinalizarVisita.CommandArgument = (((LinkButton)sender).CommandArgument);

			CallJavascript("showModal('aceptar-modal');");
		}

		protected void btnRegresarVisita_Click(object sender, EventArgs e) {
			CallJavascript("closeModal('aceptar-modal');");
		}

		protected void btnFinalizarVisita_Click(object sender, EventArgs e) {
			string[] commandArgs = ((Button)sender).CommandArgument.ToString().Split(new char[] { ',' });
			int idVisita = Int32.Parse(commandArgs[0]);
			int idRep = Int32.Parse(commandArgs[1]);
			DateTime fecha = DateTime.Parse(commandArgs[2]);

			if (fecha <= DateTime.Now) {
				visitaDAO.completarVisita(idVisita, idRep);
				return;
			}

			lblMensajeError.Text = "No puede finalizar una visita que aún no ha ocurrido";
			//CallJavascript("closeModal('aceptar-modal');");
			btnAceptarError.Visible = false;
			CallJavascript("showModal('error-modal');");
		}
	}
}
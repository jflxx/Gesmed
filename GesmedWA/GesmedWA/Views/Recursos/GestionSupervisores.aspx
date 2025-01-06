<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="GestionSupervisores.aspx.cs" Inherits="GesmedWA.Views.GestionSupervisores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="../../Scripts/gestionarSupervisores.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>

    <div class="container mt-4">
        <!-- Título principal -->
        <h2 class="text-center mb-4">
            <asp:Label ID="lblTitulo" runat="server" Text="Formulario de Registro"></asp:Label>
        </h2>

        <!-- Sección: Datos Personales -->
        <div class="card mb-4 shadow-sm">
            <div class="card-body">
                <h5 class="card-title mb-3">Datos Personales</h5>
                <div class="row g-3">
                    <div class="col-12 col-sm-6 col-lg-4">
                        <label for="dni" class="form-label fw-bold">DNI</label>
                        <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control" MaxLength="15"></asp:TextBox>
                    </div>
                    <div class="col-12 col-sm-6 col-lg-4">
                        <label for="nombre" class="form-label fw-bold">Nombre</label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" MaxLength="40"></asp:TextBox>
                    </div>
                    <div class="col-12 col-sm-6 col-lg-4">
                        <label for="apellidoPaterno" class="form-label fw-bold">Apellido Paterno</label>
                        <asp:TextBox ID="txtApellidoPaterno" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
                    </div>
                    <div class="col-12 col-sm-6 col-lg-4">
                        <label for="apellidoMaterno" class="form-label fw-bold">Apellido Materno</label>
                        <asp:TextBox ID="txtApellidoMaterno" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
                    </div>
                    <div class="col-12 col-sm-6 col-lg-4">
                        <label for="distrito" class="form-label fw-bold">Distrito</label>
                        <asp:TextBox ID="txtDistrito" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
                    </div>
                </div>
            </div>
        </div>

        <!-- Sección: Datos de Contacto -->
        <div class="card mb-4 shadow-sm">
            <div class="card-body">
                <h5 class="card-title mb-3">Datos de Contacto</h5>
                <div class="row g-3">
                    <div class="col-12 col-sm-6 col-lg-4">
                        <label for="correo" class="form-label fw-bold">Correo Electrónico</label>
                        <asp:TextBox ID="txtCorreo" runat="server" CssClass="form-control" MaxLength="50" TextMode="Email"></asp:TextBox>
                    </div>
                    <div class="col-12 col-sm-6 col-lg-4">
                        <label for="numeroDetelefono" class="form-label fw-bold">Número de Teléfono</label>
                        <asp:TextBox ID="txtNumeroTelefono" runat="server" CssClass="form-control" MaxLength="15"></asp:TextBox>
                    </div>
                </div>
            </div>
        </div>

        <!-- Sección: Cuenta de Usuario -->
        <div class="card mb-4 shadow-sm">
            <div class="card-body">
                <h5 class="card-title mb-3">Cuenta de Usuario</h5>
                <div class="row g-3">
                    <div class="col-12 col-sm-6 col-lg-4">
                        <label for="username" class="form-label fw-bold">Username</label>
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                    </div>
                    <div class="col-12 col-sm-6 col-lg-4">
                        <label for="password" class="form-label fw-bold">Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" MaxLength="50" TextMode="Password"></asp:TextBox>
                    </div>
                    <div class="col-12 col-sm-6 col-lg-4">
                        <label for="activo" class="form-label fw-bold">Activo</label>
                        <asp:DropDownList ID="ddlOpciones" runat="server" CssClass="form-select">
                            <asp:ListItem Value="1">Sí</asp:ListItem>
                            <asp:ListItem Value="0">No</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </div>
        </div>

        <!-- Botones -->
        <div class="d-flex justify-content-center mt-4 gap-2">
            <asp:Button ID="btnRegresar" runat="server" CssClass="btn btn-secondary" Text="Regresar" OnClick="btnRegresar_Click" />
            <asp:Button ID="btnGuardar" runat="server" CssClass="btn btn-primary" Text="Guardar" OnClick="btnGuardar_Click" />
        </div>
    </div>
    <!--Eliminar Modal-->
    <div id="guardarModal" class="modal" tabindex="-1" aria-labelledby="guardarModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="guardarModalLabel">Confirmación de Cambios</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="col-md-12 mb-2">
                            <asp:Label ID="labelGuardar" runat="server" CssClass="form-control" Text="Mensaje de error"></asp:Label>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <asp:Button runat="server" ID="btnConfirmarGuardar"
                            OnClick="btnConfirmarGuardar_click"
                            CssClass="btn btn-primary" data-bs-dismiss="modal"
                            Text="Guardar" />
                    </div>
                </div>
            </div>
    </div>
        <!--Error Modal-->
        <div id="error-modal" class="modal" tabindex="-1" aria-labelledby="error-modalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="error-modalLabel">Confirmación de Cambios</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <contenttemplate>
                            <div class="col-md-12 mb-2">
                                <asp:Label ID="lblMensajeError" CssClass="form-control" runat="server" Text="Mensaje de error"></asp:Label>
                            </div>
                            <div class="col-md-2"></div>
                            <!--para qué sirve esto ??-->
                        </contenttemplate>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>

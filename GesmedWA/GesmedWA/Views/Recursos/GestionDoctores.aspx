

<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="GestionDoctores.aspx.cs" Inherits="GesmedWA.Views.GestionDoctores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="../Scripts/Gesmed/gestionarModal.js"></script>
    <script src="../../Scripts/gestionarSupervisores.js" type="text/javascript"></script>
    <script src="../../Scripts/Visitas.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>
    <div class="container mt-3">
        <h2 class="text-center">
            <asp:Label ID="lblTitulo" runat="server"></asp:Label>
        </h2>
        <div class="row g-3">
            <div class="col-12 col-sm-6 col-lg-4">
                <label for="dni" class="form-label">DNI</label>
                <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control" MaxLength="15"></asp:TextBox>
            </div>

            <div class="col-12 col-sm-6 col-lg-4">
                <label for="nombre" class="form-label">Nombre</label>
                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" MaxLength="40"></asp:TextBox>
            </div>
            <div class="col-12 col-sm-6 col-lg-4">
                <label for="apellidoPaterno" class="form-label">Apellido Paterno</label>
                <asp:TextBox ID="txtApellidoPaterno" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
            </div>

            <div class="col-12 col-sm-6 col-lg-4">
                <label for="apellidoMaterno" class="form-label">Apellido Materno</label>
                <asp:TextBox ID="txtApellidoMaterno" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
            </div>

            <div class="col-12 col-sm-6 col-lg-4">
                <label for="activo" class="form-label">Activo</label>
                <asp:DropDownList ID="ddlActivo" runat="server" CssClass="form-select">
                    <asp:ListItem Value="1">Sí</asp:ListItem>
                    <asp:ListItem Value="0">No</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="col-12 col-sm-6 col-lg-4">
                <label for="correo" class="form-label">Correo Electrónico</label>
                <asp:TextBox ID="txtCorreo" runat="server" CssClass="form-control" MaxLength="50" TextMode="Email"></asp:TextBox>
            </div>

            <div class="col-12 col-sm-6 col-lg-4">
                <label for="numeroDetelefono" class="form-label">Número de Teléfono</label>
                <asp:TextBox ID="txtNumeroTelefono" runat="server" CssClass="form-control" MaxLength="15"></asp:TextBox>
            </div>

            <div class="col-12 col-sm-6 col-lg-4">
                <label for="latitud" class="form-label">Latitud</label>
                <asp:TextBox ID="txtLatitud" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="col-12 col-sm-6 col-lg-4">
                <label for="longitud" class="form-label">Longitud</label>
                <asp:TextBox ID="txtLongitud" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="col-12 col-sm-6 col-lg-4">
                <label for="altitud" class="form-label">Altitud</label>
                <asp:TextBox ID="txtAltitud" runat="server" CssClass="form-control"></asp:TextBox>
            </div>


            <div class="col-12 col-sm-6 col-lg-4">
                <label for="fSupervisor" class="form-label">Supervisor</label>
                <div class="input-group">
                    <asp:TextBox ID="txtSupervisor" runat="server" CssClass="form-control" ReadOnly="True" Placeholder="Seleccione un Supervisor"></asp:TextBox>
                    <asp:LinkButton ID="lbBuscarSupervisor" runat="server"
                        CssClass="btn btn-outline-secondary"
                        OnClientClick="$('#modalSupervisor').modal('show'); return false;"
                        Text="<i class='fas fa-search'></i>" />
                </div>
            </div>

            <div class="col-12 col-sm-6 col-lg-4">
                <label for="fAdministrador" class="form-label">Administrador</label>
                <div class="input-group">
                    <asp:TextBox ID="txtAdministrador" runat="server" CssClass="form-control" ReadOnly="True" Placeholder="Seleccione un Administrador"></asp:TextBox>
                    <asp:LinkButton ID="lbBuscarAdministrador" runat="server"
                        CssClass="btn btn-outline-secondary"
                        OnClientClick="$('#modalAdministrador').modal('show'); return false;"
                        Text="<i class='fas fa-search'></i>" />
                </div>
            </div>


            <div class="col-12 col-sm-6 col-lg-4">
                <label for="especialidad" class="form-label">Especialidad</label>
                <asp:TextBox ID="txtEspecialidad" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
            </div>

            <div class="col-12 col-sm-6 col-lg-4">
                <label for="numColegiatura" class="form-label">Número de Colegiatura</label>
                <asp:TextBox ID="txtNumColegiatura" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>

        <div class="d-flex justify-content-center mt-4 gap-2">
            <asp:Button ID="btnRegresar" runat="server" CssClass="btn btn-secondary" Text="Regresar" OnClick="btnRegresar_Click" />
            <asp:Button ID="btnGuardar" runat="server" CssClass="btn btn-primary" Text="Guardar" OnClick="btnGuardar_Click" />
        </div>
    </div>


    <div class="modal" id="modalSupervisor">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Búsqueda de Supervisor</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="container pb-3">
                                <div class="row align-items-center">
                                    <div class="col-auto">
                                        <asp:Label CssClass="col-form-label" runat="server" Text="Ingresar nombre o código del Supervisor:"></asp:Label>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:TextBox CssClass="form-control" ID="txtNombreSupervisor" runat="server"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-2">
                                        <asp:LinkButton ID="lbBuscarSupervisorModal" runat="server" CssClass="btn btn-info" Text="<i class='fa-solid fa-magnifying-glass pe-2'></i> Buscar"
                                            OnClick="lbBuscarSupervisorModal_Click" />
                                    </div>
                                </div>
                            </div>
                            <div class="container">
                                <asp:GridView ID="gvSupervisores" runat="server" OnRowDataBound="gvSupervisores_RowDataBound"
                                    AllowPaging="true" PageSize="5" AutoGenerateColumns="false"
                                    CssClass="table table-hover table-responsive table-striped"
                                    OnPageIndexChanging="gvSupervisores_PageIndexChanging">
                                    <Columns>
                                        <asp:BoundField HeaderText="ID" DataField="idSupervisor" />
                                        <asp:TemplateField HeaderText="Nombre">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNombreSupervisor" runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbSeleccionarSupervisor" CssClass="btn btn-success" runat="server"
                                                    Text="<i class='fa-solid fa-check'></i> Seleccionar" CommandArgument='<%# Eval("IdSupervisor") %>'
                                                    OnClick="lbSeleccionarSupervisor_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>

    <div class="modal" id="modalAdministrador">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Búsqueda de Administrador</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="container pb-3">
                                <div class="row align-items-center">
                                    <div class="col-auto">
                                        <asp:Label CssClass="col-form-label" runat="server" Text="Ingresar nombre o código del Administrador:"></asp:Label>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:TextBox CssClass="form-control" ID="txtNombreAdministrador" runat="server"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-2">
                                        <asp:LinkButton ID="lbBuscarAdministradorModal" runat="server" CssClass="btn btn-info" Text="<i class='fa-solid fa-magnifying-glass pe-2'></i> Buscar"
                                            OnClick="lbBuscarAdministradorModal_Click" />
                                    </div>
                                </div>
                            </div>
                            <div class="container">
                                <asp:GridView ID="gvAdministradores" runat="server" OnRowDataBound="gvAdministradores_RowDataBound"
                                    AllowPaging="true" PageSize="5" AutoGenerateColumns="false"
                                    CssClass="table table-hover table-responsive table-striped"
                                    OnPageIndexChanging="gvAdministradores_PageIndexChanging">
                                    <Columns>
                                        <asp:BoundField HeaderText="ID" DataField="idAdministrador" />
                                        <asp:TemplateField HeaderText="Nombre">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNombreAdministrador" runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbSeleccionarAdministrador" CssClass="btn btn-success" runat="server"
                                                    Text="<i class='fa-solid fa-check'></i> Seleccionar" CommandArgument='<%# Eval("IdAdministrador") %>' OnClick="lbSeleccionarAdministrador_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>

    <!-- MODAL PARA CONFIRMACION -->
    <div class="modal" id="confirmar-modal">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <!-- Modal Header (si es necesario, puedes agregarlo) -->
                <div class="modal-header">
                    <asp:Label ID="lblmodalconfirmar" runat="server" class="modal-title"  Text="Confirmación de Cambios"></asp:Label>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <!-- Modal Body -->
                <div class="modal-body">
                    <div class="row justify-content-center">
                        <!-- Contenido del mensaje de confirmación -->
                        <div class="col-12 mb-3">
                            <asp:Label ID="lblMensajeConfirmacion" CssClass="form-control text-center" runat="server" Text="¿Está seguro de que desea guardar los cambios?"></asp:Label>
                        </div>

                        <!-- Botones -->
                        <div class="col-12 d-flex justify-content-around">
                            <asp:Button ID="btnCerrarConfirm" CssClass="btn btn-secondary" runat="server" Text="Cancelar" OnClick="btnCerrarConfirm_Click" />
                            <asp:Button ID="btnConfirmar" CssClass="btn btn-primary" runat="server" Text="Guardar" OnClick="btnConfirmar_Click" />
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
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
                            <asp:Label ID="lblMensajeError" runat="server" CssClass="form-control"  Text="Mensaje de error"></asp:Label>
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

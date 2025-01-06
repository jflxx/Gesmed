<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="GestionRepresentantes.aspx.cs" Inherits="GesmedWA.Views.GestionRepresentantes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="../../Scripts/Visitas.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>
        <div class="container mt-4">
            <h2 class="text-center mb-4">
                <asp:Label ID="lblTitulo" runat="server" Text="Formulario de Usuario"></asp:Label>
            </h2>

            <!-- Sección: Datos Personales -->
            <div class="card mb-4">
                <div class="card-body">
                    <h6 class="card-title">Datos Personales</h6>
                    <div class="row g-3">
                        <div class="col-12 col-sm-6 col-lg-4">
                            <label for="dni" class="form-label">DNI</label>
                            <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control" MaxLength="15" Placeholder="Ingrese DNI"></asp:TextBox>
                        </div>
                        <div class="col-12 col-sm-6 col-lg-4">
                            <label for="nombre" class="form-label">Nombre</label>
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" MaxLength="15" Placeholder="Ingrese nombre"></asp:TextBox>
                        </div>
                        <div class="col-12 col-sm-6 col-lg-4">
                            <label for="apellidoPaterno" class="form-label">Apellido Paterno</label>
                            <asp:TextBox ID="txtApellidoPaterno" runat="server" CssClass="form-control" MaxLength="15" Placeholder="Ingrese apellido paterno"></asp:TextBox>
                        </div>
                        <div class="col-12 col-sm-6 col-lg-4">
                            <label for="apellidoMaterno" class="form-label">Apellido Materno</label>
                            <asp:TextBox ID="txtApellidoMaterno" runat="server" CssClass="form-control" MaxLength="15" Placeholder="Ingrese apellido materno"></asp:TextBox>
                        </div>
                        <div class="col-12 col-sm-6 col-lg-4">
                            <label for="subzona" class="form-label">Subzona</label>
                            <asp:TextBox ID="txtSubzona" runat="server" CssClass="form-control" MaxLength="20" Placeholder="Ingrese subzona"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sección: Datos de Contacto -->
            <div class="card mb-4">
                <div class="card-body">
                    <h6 class="card-title">Datos de Contacto</h6>
                    <div class="row g-3">
                        <div class="col-12 col-sm-6 col-lg-4">
                            <label for="correo" class="form-label">Correo Electrónico</label>
                            <asp:TextBox ID="txtCorreo" runat="server" CssClass="form-control" MaxLength="50" TextMode="Email" Placeholder="Ingrese correo electrónico"></asp:TextBox>
                        </div>
                        <div class="col-12 col-sm-6 col-lg-4">
                            <label for="numeroDetelefono" class="form-label">Número de Teléfono</label>
                            <asp:TextBox ID="txtNumeroTelefono" runat="server" CssClass="form-control" MaxLength="15" TextMode="Phone" Placeholder="Ingrese número de teléfono"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sección: Cuenta de Usuario -->
            <div class="card mb-4">
                <div class="card-body">
                    <h6 class="card-title">Cuenta de Usuario</h6>
                    <div class="row g-3">
                        <div class="col-12 col-sm-6 col-lg-4">
                            <label for="username" class="form-label">Username</label>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" MaxLength="50" Placeholder="Ingrese nombre de usuario"></asp:TextBox>
                        </div>
                        <div class="col-12 col-sm-6 col-lg-4">
                            <label for="password" class="form-label">Password</label>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" MaxLength="50" TextMode="Password" Placeholder="Ingrese contraseña"></asp:TextBox>
                        </div>
                        <div class="col-12 col-sm-6 col-lg-4">
                            <label for="activo" class="form-label">Activo</label>
                            <asp:DropDownList ID="ddlActivo" runat="server" CssClass="form-select">
                                <asp:ListItem Value="1">Sí</asp:ListItem>
                                <asp:ListItem Value="0">No</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sección: Información de Supervisor -->
            <div class="card mb-4">
                <div class="card-body">
                    <h6 class="card-title">Información de Supervisor</h6>
                    <div class="row g-3">
                        <div class="col-12 col-sm-6 col-lg-4">
                            <label for="fSupervisor" class="form-label">Supervisor</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtSupervisor" runat="server" CssClass="form-control" ReadOnly="True" Placeholder="Seleccione un Supervisor"></asp:TextBox>
                                <asp:LinkButton ID="btnBuscarSupervisor" runat="server" CssClass="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#modalSupervisor" 
                                    OnClick="btnBuscarSupervisor_Click">
                                    <i class="fas fa-search"></i> Buscar
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- DATOS DEL REPRESENTANTE -->
                <div class="card-body col-md-12">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-md-4 mb-2">
                                    <asp:Label ID="idSupervisor" CssClass="col-form-label" runat="server" Text="ID del Representante:"></asp:Label>
                                    <asp:TextBox ID="txtIdSupervisor" CssClass="form-control" Enabled="false" runat="server"></asp:TextBox>
                                </div>
                                <div class="col-md-4 mb-2">
                                    <asp:Label ID="nombreSupervisor" CssClass="col-form-label" runat="server" Text="Nombre del Represenante:"></asp:Label>
                                    <asp:TextBox ID="txtNombreSupervisor" CssClass="form-control" Enabled="false" runat="server"></asp:TextBox>
                                </div>
                                <div class="col-md-4 mb-2">
                                    <asp:Label ID="subzonaSupervisor" CssClass="col-form-label" runat="server" Text="Subzona del Representante:"></asp:Label>
                                    <asp:TextBox ID="txtSubzonaSupervisor" CssClass="form-control" Enabled="false" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>

            <!-- Botones -->
            <div class="d-flex justify-content-center mt-4 gap-2">
                <asp:Button ID="btnRegresar" runat="server" CssClass="btn btn-secondary" Text="Regresar" OnClick="btnRegresar_Click" />
                <asp:Button ID="btnGuardar" runat="server" CssClass="btn btn-primary" Text="Guardar" OnClick="btnGuardar_Click" />
            </div>
        </div>
    <!-- Modal Supervisor -->
    <div class="modal fade" id="modalSupervisor" tabindex="-1" aria-labelledby="modalSupervisorLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalSupervisorLabel">Búsqueda de Supervisor</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <!-- Filtro de búsqueda -->
                            <div class="container pb-3">
                                <div class="row align-items-center">
                                    <div class="col-sm-4">
                                        <asp:Label CssClass="form-label" runat="server" Text="Ingresar nombre o código del Supervisor:"></asp:Label>
                                    </div>
                                    <div class="col-sm-6 col-md-4">
                                        <asp:TextBox CssClass="form-control" ID="txtNombreCodigoSupervisor" runat="server" placeholder="Buscar supervisor..."></asp:TextBox>
                                    </div>
                                    <div class="col-sm-2 col-md-2 mt-3 mt-sm-0">
                                        <asp:LinkButton ID="lbBuscarSupervisorModal" runat="server" CssClass="btn btn-primary w-100" Text="Buscar" OnClick="lbBuscarSupervisorModal_Click"/>
                                    </div>
                                </div>
                            </div>

                            <!-- Resultados de búsqueda -->
                            <div class="container">
                                <asp:GridView ID="gvSupervisores" runat="server" AllowPaging="true" PageSize="5" AutoGenerateColumns="false"
                                    CssClass="table table-hover table-responsive table-striped" OnPageIndexChanging="gvSupervisores_PageIndexChanging">
                                    <Columns>
                                        <asp:BoundField HeaderText="ID" DataField="idSupervisor" />
                                        <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                                        <asp:BoundField HeaderText="Distrito" DataField="Distrito" />
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbSeleccionarSupervisor" CssClass="btn btn-success btn-sm" runat="server" 
                                                    Text="Seleccionar" CommandArgument='<%# Eval("IdSupervisor") %>' 
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

    <!-- MODAL PARA CONFIRMACION -->
       <div class="modal" id="confirmar-modal">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <!-- Modal Header (si es necesario, puedes agregarlo) -->
                    <div class="modal-header">
                        <asp:Label id="lblmodalconfirmar" class="modal-title" runat="server" Text="Confirmación de Cambios"></asp:Label>
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
</asp:Content>

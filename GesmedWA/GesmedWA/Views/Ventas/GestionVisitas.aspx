<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="GestionVisitas.aspx.cs" Inherits="GesmedWA.Views.GestionVisitas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Gestionar Visitas Médicas -->
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="../../Scripts/Visitas.js" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>

    <div class="container">

        <div class="card">

            <div class="card-header">
                <h2>
                    <!-- Cambiar el titulo dependiendo de si se registran o muestran datos -->
                    <asp:Label ID="lblTitulo" runat="server" Text="lblTitulo"></asp:Label>
                </h2>
            </div>
            <div class="card-body">
                <div class="card border">
                    <div class="card-header bg-light">
                        <h5 class="card-title mb-0">Datos Generales de la visita</h5>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-8 row">
                            <!-- Aca iran todos los datos principales de la visita -->
                            <!-- ID -->
                            <div class="col-md-6 mb-3">
                                <asp:Label ID="lblIdVisita" CssClass="col-form-label" runat="server" Text="ID de la Visita:"></asp:Label>
                                <asp:TextBox ID="txtIdVisita" CssClass="form-control" Enabled="false" runat="server"></asp:TextBox>
                            </div>
                            <!-- TIPO VISITA -->
                            <div class="col-md-6 mb-3">
                                <asp:Label ID="lblTipoVisita" CssClass="col-form-label" runat="server" Text="Tipo de Visita:"></asp:Label>
                                <asp:DropDownList ID="ddlTipoVisita" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="-" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="GEORREFERENCIA" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="GEOLOCALIZACION" Value="3"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <!-- FECHA VISITA -->
                            <div class="col-md-6 mb-3">
                                <asp:Label ID="lblFechaVisita" runat="server" Text="Fecha de la Visita:" CssClass="col-form-label" />
                                <asp:TextBox ID="dtpFechaVisita" runat="server" type="date" CssClass="form-control"></asp:TextBox>
                            </div>
                            <!-- HORA VISITA -->
                            <div class="col-md-6 mb-3">
                                <asp:Label ID="lblHoraVisita" runat="server" Text="Hora de la Visita:" CssClass="col-form-label" />
                                <asp:TextBox ID="dtpHoraVisita" runat="server" TextMode="Time" CssClass="form-control"></asp:TextBox>
                            </div>
                            <!-- ESTADO VISITA -->
                            <div class="col-md-12 mb-3">
                                <asp:Label ID="lblEstadoVisita" CssClass="col-form-label" runat="server" Text="Estado de la visita:"></asp:Label>
                                <div class="form-control">
                                    <div class="form-check form-check-inline">
                                        <input id="rbProgramada" class="form-check-input" type="radio" runat="server" disabled="disabled" checked/>
                                        <label ID="lblProgramada" class="form-check-label" for="cphContenido_rbProgramada">Programada</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input id="rbEnProgreso" class="form-check-input" type="radio" runat="server" disabled="disabled"/>
                                        <label ID="lblEnProgreso" class="form-check-label" for="cphContenido_rbEnProgreso">En Progreso</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input id="rbFinalizado" class="form-check-input" type="radio" runat="server" disabled="disabled"/>
                                        <label ID="lblFinalizado" class="form-check-label" for="cphContenido_rbFinalizado">Finalizado</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input id="rbCancelado" class="form-check-input" type="radio" runat="server" disabled="disabled"/>
                                        <label ID="lblCancelado" class="form-check-label" for="cphContenido_rbCancelado">Cancelado</label>
                                    </div>
                                </div>
                            </div>
                            <!-- DETALLES DE LA VISITA -->
                            <div class="col-md-12 mb-3">
                                <asp:Label ID="lblDetallesVisita" CssClass="col-form-label" runat="server" Text="Detalles de la visita:"></asp:Label>
                                <asp:TextBox ID="txtDetallesVisita" TextMode="MultiLine" CssClass="col-md-12" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <!-- DATOS DEL CLIENTE -->
                        <div class="card border col-md-4 bg-body">
                            <div class="card-header mb-0 mt-2 rounded-2">
                                <div class="row">
                                    <div class="col-md-8">
                                        <h5 class="card-title mb-0 mt-1">Selección del Cliente</h5>
                                    </div>
                                    <div class="col-auto">
                                        <asp:LinkButton ID="btnBuscarCliente" runat="server" CssClass="btn btn-info" Text="<i class='fa-solid fa-magnifying-glass pe-2'></i> Buscar" 
                                            OnClick="btnBuscarCliente_Click"/>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <!-- Aca se muestran los datos -->
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <asp:Label ID="lblIdCliente" CssClass="col-form-label" runat="server" Text="ID del cliente:"></asp:Label>
                                                <asp:TextBox ID="txtIdCliente" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox>
                                            </div>
                                            <div class="col-md-6">
                                                <asp:Label ID="lblTipoCliente" CssClass="col-form-label" runat="server" Text="Tipo Cliente:"></asp:Label>
                                                <asp:TextBox ID="txtTipoCliente" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox>
                                            </div>
                                            <div class="col-md-12">
                                                <asp:Label ID="lblNombreCliente" CssClass="col-form-label" runat="server" Text="Nombre:"></asp:Label>
                                                <asp:TextBox ID="txtNombreCliente" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox>
                                            </div>
                                            <div class="col-md-12 mb-2">
                                                <asp:Label ID="lblUbicacionCliente" CssClass="col-form-label" runat="server" Text="Ubicacion:"></asp:Label>
                                                <asp:TextBox ID="txtUbicacionCliente" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Acá se agregará el representante -->
            <div class="card-body mt-0">
                <div class="card-header">
                    <div class="row">
                        <div class="col-md-10">
                            <h5 class="card-title mb-0">Selección del representante</h5>
                        </div>
                        <div class="col-md-auto">
                            <asp:LinkButton ID="btnBuscarRepresentante" runat="server" CssClass="btn btn-info" Text="<i class='fa-solid fa-magnifying-glass pe-2'></i> Buscar" 
                                OnClick="btnBuscarRepresentante_Click"/>
                        </div>
                    </div>
                </div>
                <!-- DATOS DEL REPRESENTANTE -->
                <div class="card-body col-md-12">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-md-4 mb-2">
                                    <asp:Label ID="idRepresentante" CssClass="col-form-label" runat="server" Text="ID del Representante:"></asp:Label>
                                    <asp:TextBox ID="txtIdRepresetante" CssClass="form-control" Enabled="false" runat="server"></asp:TextBox>
                                </div>
                                <div class="col-md-4 mb-2">
                                    <asp:Label ID="nombreRepresentante" CssClass="col-form-label" runat="server" Text="Nombre del Represenante:"></asp:Label>
                                    <asp:TextBox ID="txtNombreRepresentante" CssClass="form-control" Enabled="false" runat="server"></asp:TextBox>
                                </div>
                                <div class="col-md-4 mb-2">
                                    <asp:Label ID="subzonaRepresentante" CssClass="col-form-label" runat="server" Text="Subzona del Representante:"></asp:Label>
                                    <asp:TextBox ID="txtSubzonaRepresentante" CssClass="form-control" Enabled="false" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
            <!-- Botones para la finalizacion -->
            <div class="card-footer clearfix">
                <asp:Button ID="btnRegresar" runat="server" Text="Regresar" CssClass="float-start btn btn-secondary" OnClick="btnRegresar_Click"/>
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="float-end btn btn-primary" OnClick="btnGuardar_Click"/>
            </div>
        </div>
    </div>
    
    <!-- Modal para la seleccion del representante -->
    <div class="modal" id="representante-modal">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Búsqueda de Representante Medico</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="container pb-3">
                                <div class="row align-items-center">
                                    <div class="col-auto">
                                        <asp:Label CssClass="col-form-label" runat="server" Text="Ingresar nombre o código del Representante:"></asp:Label>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:TextBox CssClass="form-control" ID="txtNombreCodigoRepresentante" runat="server"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-2">
                                        <asp:LinkButton ID="lbBuscarRepresentante" runat="server" CssClass="btn btn-info" Text="<i class='fa-solid fa-magnifying-glass pe-2'></i> Buscar" 
                                            OnClick="lbBuscarRepresentante_Click"/>
                                    </div>
                                </div>
                            </div>
                            <div class="container">
                                <asp:GridView ID="gvRepresentantes" runat="server" AllowPaging="true" PageSize="5" AutoGenerateColumns="false"
                                    CssClass="table table-hover table-responsive table-striped" OnPageIndexChanging="gvRepresentantes_PageIndexChanging">
                                    <Columns>
                                        <asp:BoundField HeaderText="ID" DataField="idRepresentanteMedico"/>
                                        <asp:BoundField HeaderText="Nombre" DataField="Nombre"/>
                                        <asp:BoundField HeaderText="SubZona" DataField="subZona"/>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbSeleccionarRepresentante" CssClass="btn btn-success" runat="server" 
                                                    Text="<i class='fa-solid fa-check'></i> Seleccionar" CommandArgument='<%# Eval("idRepresentanteMedico") %>' 
                                                    OnClick="lbSeleccionarRepresentante_Click"/>
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

    <!-- Modal para la seleccion del cliente -->
    <div class="modal" id="cliente-modal">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Búsqueda de Cliente</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="container pb-3">
                                <div class="row align-items-center">
                                    <div class="col-auto">
                                        <asp:Label CssClass="col-form-label" runat="server" Text="Ingresar nombre o ID del Cliente:"></asp:Label>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:TextBox CssClass="form-control" ID="txtNombreIdCliente" runat="server"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-2">
                                        <asp:DropDownList ID="ddlTipoCliente" runat="server" CssClass="form-select">
                                            <asp:ListItem Text="-" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Médico" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Farmacia" Value="3"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-sm-2">
                                        <asp:LinkButton ID="lbBuscarClienteModal" runat="server" CssClass="btn btn-info" Text="<i class='fa-solid fa-magnifying-glass pe-2'></i> Buscar" 
                                            OnClick="lbBuscarClienteModal_Click"/>
                                    </div>
                                </div>
                            </div>
                            <!-- Aca van los datos a mostrar del cliente OJO: Cambiar NombreF -->
                            <div class="container">
                                <asp:GridView ID="gvClientes" runat="server" AllowPaging="true" PageSize="5" AutoGenerateColumns="false"
                                    CssClass="table table-hover table-responsive table-striped" OnPageIndexChanging="gvClientes_PageIndexChanging">
                                    <Columns>
                                        <asp:BoundField HeaderText="Código" DataField="IdCliente"/>
                                        <asp:BoundField HeaderText="Nombre" DataField="Nombre"/>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbSeleccionarCliente" CssClass="btn btn-success" runat="server" 
                                                    Text="<i class='fa-solid fa-check'></i> Seleccionar" CommandArgument='<%# Eval("IdCliente") %>' 
                                                    OnClick="lbSeleccionarCliente_Click"/>
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

    <!-- MODAL PARA EL ERROR -->
    <div class="modal" id="error-modal">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="card-body col-md-12">
                        <div class="row">
                            <!-- Contenido del modal de error -->
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <div class="col-md-12 mb-2">
                                        <asp:Label ID="lblMensajeError" CssClass="form-control" runat="server" Text="Mensaje de error"></asp:Label>
                                    </div>
                                    <div class="col-md-2"></div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <!-- Boton para cerrar el modal -->
                            <div class="col-md-4 mb-2">
                                <asp:Button ID="btnCerrarError" CssClass="btn btn-warning" runat="server" Text="Cerrar" OnClick="btnCerrarError_Click"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

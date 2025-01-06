<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="ListaClientes.aspx.cs" Inherits="GesmedWA.Views.ListaClientes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="../../Scripts/Visitas.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>
    <asp:Panel runat="server" CssClass="container mt-5">
        <div class="row mb-3">
            <div class="col-md-4">
                <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control" Placeholder="Buscar por Nombre" />
            </div>
            <div class="col-12 col-sm-6 col-lg-4">
                <div class="input-group">
                    <asp:TextBox ID="txtSupervisor" runat="server" CssClass="form-control" ReadOnly="True" Placeholder="Seleccione un Supervisor"></asp:TextBox>
                    <asp:LinkButton ID="lbBuscarSupervisor" runat="server"
                        CssClass="btn btn-outline-secondary"
                        OnClientClick="$('#modalSupervisor').modal('show'); return false;"
                        Text="<i class='fas fa-search'></i>" />
                </div>
            </div>
        </div>
        <div class="col-md-2 d-flex mb-3">
            <asp:Button ID="btnInsertarFarmacia" runat="server" CssClass="btn btn-primary me-2" Text="Insertar Farmacia" OnClick="btnInsertarFarmacia_Click" />
            <asp:Button ID="btnInsertarDoctor" runat="server" CssClass="btn btn-primary" Text="Insertar Doctor" OnClick="btnInsertarDoctor_Click" />
        </div>
        <!-- Tabla de datos -->
        <asp:GridView ID="gvClientes" runat="server" OnRowDataBound="gvClientes_RowDataBound"
            AllowPaging="true" PageSize="5" AutoGenerateColumns="false"
            ShowHeaderWhenEmpty="true" CssClass="table table-hover table-responsive table-striped"
            OnPageIndexChanging="gvClientes_PageIndexChanging">
            <Columns>

                <asp:BoundField HeaderText="ID" DataField="idCliente" />
                <asp:TemplateField HeaderText="Nombre">
                    <ItemTemplate>
                        <asp:Label ID="lblNombre" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Tipo">
                    <ItemTemplate>
                        <asp:Label ID="lblTipo" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Detalle">
                    <ItemTemplate>
                        <asp:Label ID="lblDetalle" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Acciones">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbVerCliente" CssClass="btn btn-warning" runat="server"
                            Text="<i class='fa-solid fa-eye'></i>"
                            OnClick="lbSeleccionarCliente_Click"
                            CommandArgument='<%# Eval("idCliente") %>'
                            data-Tipo='<%# Eval("Tipo") %>' />
                        <asp:LinkButton ID="btActualizarCliente" CssClass="btn btn-warning" runat="server"
                            Text="<i class='fa-solid fa-pen'></i>"
                            OnClick="btActualizarCliente_Click"
                            CommandArgument='<%# Eval("idCliente") %>'
                            data-Tipo='<%# Eval("Tipo") %>' />
                        <asp:LinkButton ID="btEliminarCliente" CssClass="btn btn-warning" runat="server"
                            Text="<i class='fa-solid fa-trash'></i>"
                            OnClick="btEliminarCliente_Click"
                            CommandArgument='<%# Eval("idCliente") %>'
                            data-Tipo='<%# Eval("Tipo") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </asp:Panel>
    <!-- MODAL PARA EL ERROR -->
    <div class="modal" id="error-modal">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="card-body col-md-12">
                        <div class="row">
                            <div class="col-md-12 mb-2">
                                <asp:Label ID="lblMensajeError" CssClass="form-control justify-content-center" runat="server" Text="¿Está seguro que desea eliminar este cliente?"></asp:Label>
                            </div>
                            <div class="col-md-4 mb-2">
                                <asp:Button ID="btnCerrarError" CssClass="btn btn-warning" runat="server" Text="No, cancelar cambios"
                                    OnClick="btnCerrarError_Click" />
                            </div>
                            <div class="col-md-1"></div>
                            <div class="col-md-4 mb-2">
                                <asp:Button ID="btnAceptarError" CssClass="btn btn-warning" runat="server" Text="Sí, eliminar este cliente"
                                    OnClick="btnAceptarError_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
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
</asp:Content>

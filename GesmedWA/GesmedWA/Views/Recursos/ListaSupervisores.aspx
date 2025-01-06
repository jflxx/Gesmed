<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="ListaSupervisores.aspx.cs" Inherits="GesmedWA.Views.ListaSupervisores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .pagination-container .pagination {
            display: flex;
            justify-content: center;
            padding-top: 1rem;
        }
        .pagination-container .pagination a,
        .pagination-container .pagination .page-item {
            color: #0d6efd; /* Bootstrap primary color */
            padding: 0.5rem 0.75rem;
            margin: 0 2px;
            text-decoration: none;
            border-radius: 0.25rem;
            border: 1px solid #dee2e6;
        }
        .pagination-container .pagination .active a {
            background-color: #0d6efd;
            color: white;
            border: 1px solid #0d6efd;
        }
        .text-success {
            color: green;
            font-weight: bold;
        }

        .text-danger {
            color: red;
            font-weight: bold;
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="../../Scripts/gestionarSupervisores.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <asp:HiddenField ID="hfIdSupervisor" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <asp:Panel runat="server" CssClass="container mt-5">
        <div class="row mb-3">
            <div class="col-md-4">
                <!--botón de buscar-->
                <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control" Placeholder="Buscar por:" />
            </div>

            <div class="col-md-3">
                <!--opciones de busqueda-->
                <asp:DropDownList ID="ddlBuscarPor" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Nombre" Value="0" Selected="True"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col md-1">
                <!-- Aca va un ddl para mostrar el parametro por el cual debe ordenar -->
                <asp:DropDownList ID="ddlOrdenamiento" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Modo de listado:" Value="0" Selected="True" Disabled="True"></asp:ListItem>
                    <asp:ListItem Text="Todos" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Solo activos" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Solo desactivos" Value="3"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col md-1">
                <asp:Button ID="btnOrdenarSupervisor" runat="server" CssClass="btn btn-info" Text="Ordenar" OnClick="btnOrdenarSupervisor_Click" />
            </div>
            <div class="col-md-2">
                <asp:Button ID="btnInsertar" runat="server" CssClass="btn btn-primary w-100" Text="Insertar Supervisores" OnClick="btnInsertar_Click"
                    class="botonInsertar" />
            </div>
        </div>
        <!-- Tabla de datos -->
        <asp:GridView ID="gvSupervisores" runat="server" AllowPaging="true" PageSize="5" AutoGenerateColumns="false"
            ShowHeaderWhenEmpty="true" CssClass="table table-hover table-responsive table-striped"
            OnPageIndexChanging="gvSupervisores_PageIndexChanging" OnRowDataBound="GridView1_RowDataBound">
            <PagerStyle CssClass="pagination-container" />
            <Columns>
                <asp:BoundField HeaderText="DNI" DataField="DNI" />
                <asp:BoundField HeaderText="Nombre" DataField="nombre" />
                <asp:BoundField HeaderText="Apellido Paterno" DataField="apellidoPaterno" />
                <asp:BoundField HeaderText="Correo" DataField="correo" />
                <asp:BoundField HeaderText="Distrito" DataField="distrito" />
                <asp:TemplateField HeaderText="Estado">
                    <ItemTemplate>
                        <asp:Label ID="lblActivo" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Acciones">
                    <ItemTemplate>
                        <asp:LinkButton CssClass="btn btn-warning" runat="server" ID="lbSeleccionarSupervisor"
                            Text="<i class='fa-solid fa-eye'></i>" CommandArgument='<%# Eval("idSupervisor")%>'
                            OnClick="lbSeleccionarSupervisor_Click" />
                        <asp:LinkButton CssClass="btn btn-warning" runat="server" ID="lbEditarSupervisor"
                            Text="<i class='fa-solid fa-pencil'></i>" CommandArgument='<%# Eval("idSupervisor")%>'
                            OnClick="lbEditar_Click" />
                        <asp:LinkButton
                            ID="btnEliminar"
                            runat="server"
                            CssClass="btn btn-warning"
                            CommandArgument='<%# Eval("idSupervisor") %>'
                            OnClick="lbSeleccionarSupervisorEliminar_Click">
                            <i class="fa-solid fa-trash"></i>
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <!---- moda del error de alfredo-->
        <!-- Modal -->
        <div id="eliminarModal" class="modal" tabindex="-1" aria-labelledby="eliminarModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="eliminarModalLabel">¿Estás seguro?</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p>Estás a punto de desactivar al supervisor<p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <asp:Button runat="server" ID="btEliminarSupervisor"
                            OnClick="btnEliminarSupervisor_Click"
                            CssClass="btn btn-danger" data-bs-dismiss="modal"
                            Text="Sí, desactivar" />
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>
</asp:Content>

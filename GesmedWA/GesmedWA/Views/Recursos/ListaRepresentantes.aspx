<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="ListaRepresentantes.aspx.cs" Inherits="GesmedWA.Views.ListaRepresentantes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .acciones-gridview {
            width: 10%; /* Ajusta según sea necesario */
            white-space: nowrap;
        }

        .acciones-gridview .btn {
            padding: 5px; /* Reduce el tamaño del botón */
            font-size: 15px; /* Ajusta el tamaño de los iconos */
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="../../Scripts/Visitas.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <asp:Panel runat="server" CssClass="container mt-5">
        <!-- Fila de búsqueda -->
        <div class="row mb-4">
            <div class="col-md-4 mb-3">
                <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control" Placeholder="Buscar por..." />
            </div>
            <div class="col-md-3 mb-3">
                <asp:DropDownList ID="ddlBuscarPor" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Ordenar por:" Value="0"></asp:ListItem>
                    <asp:ListItem Text="Nombre o Apellidos" Value="1"></asp:ListItem>
                    <asp:ListItem Text="KPI Ascendente" Value="2"></asp:ListItem>
                    <asp:ListItem Text="KPI Descendente" Value="3"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-md-2 mb-3">
                <asp:Button ID="btnBuscar" runat="server" CssClass="btn btn-primary w-100" Text="Buscar" OnClick="btnBuscar_Click" />
            </div>
            <div class="col-md-2 mb-3">
                <asp:Button ID="btnInsertar" runat="server" CssClass="btn btn-success w-100" Text="Insertar Representante" OnClick="btnInsertar_Click" />
            </div>
        </div>

        <!-- Tabla de datos -->
        <asp:GridView ID="gvRepresentantesMedicos" runat="server" AllowPaging="true" PageSize="5" AutoGenerateColumns="false" 
            ShowHeaderWhenEmpty="true" CssClass="table table-hover table-striped table-bordered table-sm" 
            OnPageIndexChanging="gvRepresentantesMedicos_PageIndexChanging" OnRowDataBound="gvRepresentantesMedicos_RowDataBound">
            <Columns>
                <asp:BoundField HeaderText="ID" DataField="IdRepresentanteMedico" ItemStyle-Width="10%" />
                <asp:BoundField HeaderText="Nombre" DataField="Nombre" ItemStyle-Width="20%" />
                <asp:BoundField HeaderText="Apellido Paterno" DataField="ApellidoPaterno" ItemStyle-Width="20%" />
                <asp:BoundField HeaderText="Zona" DataField="SubZona" ItemStyle-Width="20%" />
                <asp:BoundField HeaderText="KPI" DataField="KPI" ItemStyle-Width="10%" />
                <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="20%">
                    <ItemTemplate>
                        <div class="d-flex justify-content-around">
                            <asp:LinkButton ID="btMostrarDatos" CssClass="btn btn-warning btn-sm flex-fill mx-1" runat="server" 
                                Text="<i class='fa-solid fa-eye'></i>" 
                                CommandName="MostrarDatos" CommandArgument='<%# Eval("IdRepresentanteMedico") %>' OnClick="btMostrarDatos_Click" />
                            <asp:LinkButton ID="btActualizarRepresentante" CssClass="btn btn-warning btn-sm flex-fill mx-1" runat="server" 
                                Text="<i class='fa-solid fa-pen'></i>" 
                                OnClick="btActualizarRepresentante_Click" CommandArgument='<%# Eval("IdRepresentanteMedico") %>' />
                            <asp:LinkButton ID="btEliminarRepresentante" CssClass="btn btn-danger btn-sm flex-fill mx-1" runat="server" 
                                Text="<i class='fa-solid fa-trash'></i>" 
                                OnClick="btEliminarRepresentante_Click" CommandArgument='<%# Eval("IdRepresentanteMedico") %>' />
                            <asp:LinkButton ID="btnVisitas" CssClass="btn btn-info btn-sm flex-fill mx-1" runat="server" 
                                Text="<i class='fa-solid fa-list'></i>" 
                                OnClick="btnVisitas_Click" CommandArgument='<%# Eval("IdRepresentanteMedico") %>' />
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </asp:Panel>

    <!-- Modal para confirmación de error -->
    <div class="modal fade" id="error-modal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="errorModalLabel">Confirmación de eliminación</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:Label ID="lblMensajeError" runat="server" CssClass="form-control" Text="¿Está seguro que desea eliminar este Representante?"></asp:Label>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnCerrarError" CssClass="btn btn-secondary" runat="server" Text="NO, cancelar cambios" OnClick="btnCerrarError_Click" data-bs-dismiss="modal" />
                    <asp:Button ID="btnAceptarError" CssClass="btn btn-danger" runat="server" Text="SÍ, eliminar este Representante" OnClick="btnAceptarError_Click" />
                </div>
            </div>
        </div>
    </div>


</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="ListaVisitas.aspx.cs" Inherits="GesmedWA.Views.ListaVisitas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="../../Scripts/Visitas.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <asp:Panel runat="server" CssClass="container mt-5">
        <div class="row mb-3">
            <div class="col-md-4">
                <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control" Placeholder="Buscar por:" />
            </div>
            <div class="col-md-2">
                <asp:DropDownList ID="ddlBuscarPor" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Cliente" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Representante" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Tipo Visita" Value="3"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-md-1">
                <asp:Button ID="btnBuscarVisita" runat="server" CssClass="btn btn-info" Text="Buscar" OnClick="btnBuscarVisita_Click" />
            </div>
            <div class="col md-1">
                <!-- Aca va un ddl para mostrar el parametro por el cual debe ordenar -->
                <asp:DropDownList ID="ddlTipoOrdenamiento" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Ordenar por:" Value="0"></asp:ListItem>
                    <asp:ListItem Text="Fecha y Hora" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Representante" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Cliente" Value="3"></asp:ListItem>
                    <asp:ListItem Text="Estado" Value="4"></asp:ListItem>
                    <asp:ListItem Text="Tipo Visita" Value="5"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col md-1">
                <asp:Button ID="btnOrdenarVisita" runat="server" CssClass="btn btn-info" Text="Ordenar" OnClick="btnOrdenarVisita_Click" />
            </div>
            <div class="col-md-2">
                <asp:Button ID="btnInsertar" runat="server" CssClass="btn btn-primary w-100" Text="Insertar Visita" OnClick="btnInsertar_Click"
                        class="botonInsertar"/>
            </div>
        </div>
        <!-- Tabla de datos -->
        <asp:GridView ID="gvVisitas" runat="server" AllowPaging="true" PageSize="6" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" 
                CssClass="table table-hover table-responsive table-striped" OnPageIndexChanging="gvVisitas_PageIndexChanging" 
                OnRowDataBound="gvVisitas_RowDataBound"> 
            <Columns>
                <asp:BoundField HeaderText="ID" DataField="idVisita"/>
                <asp:BoundField HeaderText="Representante" DataField="representante.nombre" />
                <asp:BoundField HeaderText="Cliente (Persona)" DataField="cliente.nombre" />
                <asp:BoundField HeaderText="Fecha" DataField="fecha" />
                <asp:BoundField HeaderText="Hora" DataField="hora" />
                <asp:BoundField HeaderText="Tipo de Visita" DataField="tipoVisita" />
                <asp:BoundField HeaderText="Estado de la Visita" DataField="estado" />
                <asp:TemplateField HeaderText="Acciones">
                    <ItemTemplate>
                        <asp:LinkButton ID="btMostrarDatos" CssClass="btn btn-warning" runat="server" Text="<i class='fa-solid fa-eye'></i>"
                            OnClick="btMostrarDatos_Click" CommandArgument='<%# Eval("idVisita") %>' />
                        <asp:LinkButton ID="btActualizarVisita" CssClass="btn btn-warning" runat="server" Text="<i class='fa-solid fa-pen'></i>"
                            OnClick="btActualizarVisita_Click" CommandArgument='<%# Eval("idVisita") %>' />
                        <asp:LinkButton ID="btEliminarVisita" CssClass="btn btn-danger" runat="server" Text="<i class='fa-solid fa-trash'></i>"
                            OnClick="btEliminarVisita_Click" CommandArgument='<%# Eval("idVisita") %>' />
                        <asp:LinkButton ID="btCompletarVisita" CssClass="btn btn-success" runat="server" Text="<i class='fa-solid fa-check'></i>"
                            OnClick="btCompletarVisita_Click" CommandArgument='<%# Eval("idVisita") + "," + Eval("representante.idRepresentanteMedico") + "," + Eval("fecha") %>' />
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
                                <asp:Label ID="lblMensajeError" CssClass="form-control" runat="server" Text=""></asp:Label>
                            </div>
                            <div class="col-md-4 mb-2">
                                <asp:Button ID="btnCerrarError" CssClass="btn btn-secondary" runat="server" Text="Cerrar" OnClick="btnCerrarError_Click"/>
                            </div>
                            <div class="col-md-1"></div>
                            <div class="col-md-4 mb-2">
                                <asp:Button ID="btnAceptarError" CssClass="btn btn-danger" runat="server" Text="Aceptar" OnClick="btnAceptarError_Click"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- MODAL PARA LA VISITA -->
    <div class="modal" id="aceptar-modal">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="eliminarModalLabel">Se necesita su confirmación</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="card-body col-md-12">
                        <div class="row">
                            <div class="col-md-12 mb-2">
                                <asp:Label ID="lblMensajeAceptarion" CssClass="form-control" runat="server" Text="¿Desea confirmar la finalización de la visita?"></asp:Label>
                            </div>
                            <div class="col-md-4 mb-2">
                                <asp:Button ID="btnFinalizarVisita" CssClass="btn btn-primary" runat="server" Text="Aceptar" OnClick="btnFinalizarVisita_Click"/>
                            </div>
                            <div class="col-md-1"></div>
                            <div class="col-md-4 mb-2">
                                <asp:Button ID="btnRegresarVisita" CssClass="btn btn-secondary" runat="server" Text="Regresar" OnClick="btnRegresarVisita_Click"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

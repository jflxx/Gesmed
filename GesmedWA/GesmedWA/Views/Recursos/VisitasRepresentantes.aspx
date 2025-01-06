<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="VisitasRepresentantes.aspx.cs" Inherits="GesmedWA.Views.Recursos.VisitasRepresentantes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script type="text/javascript">
    function openInNewTab() {
        window.document.forms[0].target = '_blank';
        setTimeout(function () { window.document.forms[0].target = ''; }, 0);
    }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container mt-4">
        <h3 class="text-center">Visitas del Representante Médico</h3>

        <!-- Sección del representante -->
        <div class="card mb-4">
            <div class="card-body">
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label" for="TxtRepresentante">Representante Médico:</label>
                    <div class="col-sm-10">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <asp:Label ID="TxtRepresentanteId" runat="server" Text="ID" CssClass="input-group-text" />
                            </div>
                            <asp:TextBox ID="TxtRepresentante" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Botón Resumen del Representante encima del GridView -->
        <div class="text-end mt-3">
            <asp:Button ID="BtnResumenRepresentante" runat="server" Text="Resumen del Representante" CssClass="btn btn-secondary" OnClick="BtnResumenRepresentante_Click" OnClientClick="openInNewTab();" />
        </div>

        <!-- Tarjetas de estadísticas -->
        <div class="row mt-4">
            <div class="col-md-3 mb-3">
                <div class="card h-100">
                    <div class="card-body text-center">
                        <h5 class="card-title">Total Visitas</h5>
                        <asp:Label ID="lblTotalVisitas" runat="server" class="card-text">0</asp:Label>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="card h-100">
                    <div class="card-body text-center">
                        <h5 class="card-title">Finalizados</h5>
                        <asp:Label ID="lblFinalizados" runat="server" class="card-text">0</asp:Label>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="card h-100">
                    <div class="card-body text-center">
                        <h5 class="card-title">Cancelados</h5>
                        <asp:Label ID="lblCancelados" runat="server" class="card-text">0</asp:Label>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="card h-100">
                    <div class="card-body text-center">
                        <h5 class="card-title">En Progreso</h5>
                        <asp:Label ID="lblEnProgreso" runat="server" class="card-text">0</asp:Label>
                    </div>
                </div>
            </div>
        </div>

        <!-- Grid de visitas -->
        <div class="card mb-4">
            <div class="card-body">
                <asp:GridView ID="GvVisitas" runat="server" AutoGenerateColumns="false" CssClass="table table-hover table-striped" OnRowDataBound="GvVisitas_RowDataBound">
                    <Columns>
                        <asp:BoundField HeaderText="Id Visita" DataField="IdVisita" />
                        <asp:BoundField HeaderText="Nombre Cliente" DataField="cliente.nombre" />
                        <asp:BoundField HeaderText="Fecha" DataField="fecha" />
                        <asp:BoundField HeaderText="Hora" DataField="hora" />
                        <asp:BoundField HeaderText="Tipo de Visita" DataField="tipoVisita" />
                        <asp:BoundField HeaderText="Estado de la Visita" DataField="estado" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <!-- Botón Regresar debajo del GridView -->
        <div class="text-center mt-3">
            <asp:Button ID="BtnRegresar" runat="server" Text="Regresar" CssClass="btn btn-primary" OnClick="BtnRegresar_Click" />
        </div>
    </div>




</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="GestionReporte.aspx.cs" Inherits="GesmedWA.Views.Reportes.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function openInNewTab() {
            window.document.forms[0].target = '_blank';
            setTimeout(function () { window.document.forms[0].target = ''; }, 0);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container mt-5">
        <!-- Tarjeta principal -->
        <div class="card shadow">
            <div class="card-header bg-primary text-white">
                <h2 class="mb-0">
                    <i class="fa-solid fa-clipboard-list me-2"></i>
                    <asp:Label ID="lblTitulo" runat="server" Text="Generar Reporte de Visitas"></asp:Label>
                </h2>
            </div>
            <div class="card-body">
                <!-- Campos de selección de fecha -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <label for="dtpFechaInicio" class="form-label">Fecha de Inicio:</label>
                        <asp:TextBox ID="dtpFechaInicio" runat="server" type="date" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label for="dtpFechaFin" class="form-label">Fecha de Fin:</label>
                        <asp:TextBox ID="dtpFechaFin" runat="server" type="date" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>

                <!-- Botones -->
                <div class="d-flex justify-content-between">
                    <asp:Button ID="btnRegresar" runat="server" Text="Regresar" CssClass="btn btn-secondary" OnClick="btnRegresar_Click" />
                    <asp:Button ID="btnGuardar" runat="server" Text="Generar Reporte" CssClass="btn btn-primary" OnClick="btnGenerarReporte_Click" OnClientClick="openInNewTab();"/>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

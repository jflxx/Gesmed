<%@ Page Title="Dashboard - Medical Representatives" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="GesmedWA.Views.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
    <style>
        .welcome-card {
            transition: transform 0.3s ease;
        }

            .welcome-card:hover {
                transform: translateY(-5px);
            }

        .role-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
        }

        .stats-card {
            border-radius: 15px;
            border: none;
            transition: all 0.3s ease;
        }

            .stats-card:hover {
                box-shadow: 0 8px 16px rgba(0,0,0,0.1);
            }

        .user-avatar {
            background: linear-gradient(135deg, #0d6efd, #0dcaf0);
            padding: 2rem;
            border-radius: 50%;
            margin-bottom: 1.5rem;
        }

        .quick-actions {
            margin-top: 2rem;
        }

        .action-button {
            padding: 1rem;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

            .action-button:hover {
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.min.js"></script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container py-5">
        <!-- Tarjeta principal de bienvenida -->
        <div class="row mb-4">
            <div class="col-lg-12">
                <div class="card welcome-card shadow-lg">
                    <div class="card-body text-center p-5">
                        <div class="user-avatar d-inline-block mb-4">
                            <i class="fas fa-user-md fa-4x text-white"></i>
                        </div>
                        <h1 class="display-4 fw-bold mb-3">¡Bienvenido de nuevo!</h1>
                        <p class="lead mb-4">
                            <asp:Label ID="lblTexto" runat="server" CssClass="text-primary fw-bold"></asp:Label>
                        </p>
                        <span class="role-badge bg-primary text-white">
                            <i class="fas fa-shield-alt me-2"></i>
                            <asp:Label ID="lblRol" runat="server"></asp:Label>
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

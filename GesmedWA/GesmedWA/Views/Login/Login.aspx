<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="GesmedWA.Views.Login.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="../../Content/bootstrap-grid.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />

    <title>Iniciar Sesión - GesmedSoft</title>
    <style>
        :root {
            --primary-color: #0284fe;
            --secondary-color: #00CBFE;
            --gradient-start: rgba(2, 132, 254, 0.95);
            --gradient-end: rgba(0, 203, 254, 0.90);
            --error-color: #dc3545;
            --white: #ffffff;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            min-height: 100vh;
            background: linear-gradient(135deg, var(--gradient-start), var(--gradient-end)), url('../../Images/medical-background.jpg') center/cover no-repeat fixed;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .login-container {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 420px;
            transform: translateY(0);
            transition: transform 0.3s ease;
            animation: fadeIn 0.5s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .Logo {
            text-align: center;
            margin-bottom: 30px;
        }

            .Logo img {
                max-width: 180px;
                height: auto;
                margin-bottom: 20px;
                transition: transform 0.3s ease;
            }

                .Logo img:hover {
                    transform: scale(1.05);
                }

        .input-group {
            position: relative;
            margin-bottom: 25px;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px 12px 45px;
            background-color: #f8f9fa;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            color: #495057;
            font-size: 15px;
            transition: all 0.3s ease;
        }

            .form-control:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(2, 132, 254, 0.1);
                background-color: var(--white);
            }

        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
            transition: color 0.3s ease;
        }

        .form-control:focus + .input-icon {
            color: var(--primary-color);
        }

        .btn-primary {
            background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
            border: none;
            color: var(--white);
            padding: 12px;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 500;
            width: 100%;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(2, 132, 254, 0.3);
            }

            .btn-primary:active {
                transform: translateY(0);
            }

        .text-danger {
            color: var(--error-color);
            font-size: 14px;
            margin-top: 15px;
            text-align: center;
            display: block;
            animation: shake 0.5s ease;
        }

        @keyframes shake {
            0%, 100% {
                transform: translateX(0);
            }

            25% {
                transform: translateX(-5px);
            }

            75% {
                transform: translateX(5px);
            }
        }

        /* Responsive adjustments */
        @media (max-width: 480px) {
            .login-container {
                padding: 30px 20px;
            }

            .Logo img {
                max-width: 150px;
            }

            .form-control {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <div class="Logo">
                <img src="../../Images/LogoGesmed.png" alt="LogoGesmed" />
                <h2 style="color: #0284fe; font-weight: 600; margin-bottom: 30px;">Bienvenido a GesmedSoft</h2>
            </div>

            <div class="input-group">
                <asp:TextBox ID="username" CssClass="form-control" runat="server"
                    Placeholder="Usuario" required="required"></asp:TextBox>
                <i class="fas fa-user input-icon"></i>
            </div>

            <div class="input-group">
                <asp:TextBox ID="password" CssClass="form-control" TextMode="Password"
                    runat="server" Placeholder="Contraseña" required="required"></asp:TextBox>
                <i class="fas fa-lock input-icon"></i>
            </div>

            <div class="d-grid">
                <asp:Button ID="submitButton" runat="server" Text="Iniciar Sesión"
                    CssClass="btn btn-primary" OnClick="submitButton_Click" />
            </div>

            <div class="text-center">
                <asp:Label ID="errorMessage" runat="server" CssClass="text-danger" Visible="false"></asp:Label>
            </div>
        </div>
    </form>

    <script src="../../Scripts/bootstrap.bundle.js"></script>
</body>
</html>
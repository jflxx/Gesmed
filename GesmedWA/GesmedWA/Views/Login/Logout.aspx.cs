using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GesmedWA.Views.Login
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Termina la sesión del usuario
            Session.Abandon();  // Elimina todos los objetos de sesión

            // Redirige al usuario a la página de login
            Response.Redirect("./Login.aspx");  // Redirige a la página de login
        }
    }
}
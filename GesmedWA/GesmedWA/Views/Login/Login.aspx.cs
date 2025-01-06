using GesmedWA.GesmedWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GesmedWA.Views.Login
{
    public partial class Login : System.Web.UI.Page
    {
        private UsuarioWSClient usuarioDAO;
        protected void Page_Load(object sender, EventArgs e)
        {
            usuarioDAO = new UsuarioWSClient();
        }

        protected void submitButton_Click(object sender, EventArgs e)
        {
            usuario user = new usuario();
            user.user = username.Text;
            user.password = password.Text;
            Session["Usuario"]=usuarioDAO.verificarUsuario(user);
            usuario t = (usuario)Session["Usuario"];
            if (t.activo)
            {
                FormsAuthenticationTicket tkt;
                string cookiestr;
                HttpCookie ck;
                tkt = new FormsAuthenticationTicket(1, user.user, DateTime.Now,
                    DateTime.Now.AddMinutes(30), true, "datos adicionales del usuario");
                cookiestr = FormsAuthentication.Encrypt(tkt);
                ck = new HttpCookie(FormsAuthentication.FormsCookieName, cookiestr);
                ck.Expires = tkt.Expiration;
                ck.Path = FormsAuthentication.FormsCookiePath;
                Response.Cookies.Add(ck);

                char rol = (char)usuarioDAO.obtenerRol(t.idUsuario);
                Session["rol"] = rol;
                Session["id"] = t.idUsuario;
                Session["username"] = t.user;
                string strRedirect;
                strRedirect = Request["ReturnUrl"];
                if (strRedirect == null)
                    strRedirect = "../Inicio/Home.aspx";
                Response.Redirect(strRedirect, true);
            }
            else {
                errorMessage.Text = "Contraseña incorrecta. Inténtalo de nuevo.";
                errorMessage.Visible = true;
                //Response.Redirect("./Login.aspx", true);
            }
                
        }
    }
}
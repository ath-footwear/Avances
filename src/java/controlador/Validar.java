/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import Modelo.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import persistencia.Avances;

/**
 *
 * @author mich
 */
@WebServlet(name = "Validar", urlPatterns = {"/Validar"})
public class Validar extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession objSesion = request.getSession(true);
        try {
        String nombre = request.getParameter("nombrelog");//obtencion de datos del formulario
        String contrasena = request.getParameter("contrasenalog");
        //System.out.println("," + nombre + "," + contrasena + ",");
        boolean flag=false;//recogera el resultado del proceso para verificar los campos.
        char arr[];
        char arr1[];
        int interv =180;
         PrintWriter out = response.getWriter();
        //control de acceso
        //System.out.println("," + nombre + "," + contrasena + ",");
        if (nombre.equals(null) || contrasena.equals(null) || nombre.equals("") || contrasena.equals("")) { // verificar caracteres remplazar 
                out.println("<script type=\"text/javascript\">");
                out.println("location='index.jsp';");
                out.println("</script>");
            flag =true;
        } else {
            arr = nombre.toCharArray();
            arr1 = contrasena.toCharArray();
            for (int i = 0; i < arr.length; i++) {
                if (arr[i] == '|' || arr[i] == '\'' || arr[i] == '\"' || arr[i] == '=' || arr[i] == '!') {
                    flag=true;
                out.println("<script type=\"text/javascript\">");
                out.println("location='index.jsp';");
                out.println("</script>");
                    i = arr.length;
                }
            }
            for (int i = 0; i < arr1.length; i++) {
                if (arr1[i] == '|' || arr1[i] == '\'' || arr1[i] == '\"' || arr1[i] == '=' || arr1[i] == '!') {
                    flag=true;                   
                out.println("<script type=\"text/javascript\">");
                out.println("location='index.jsp';");
                out.println("</script>");
                    i = arr1.length;
                }
            }
        }
        if(flag){// si es verdad regresa a la pagina de inicio 
                out.println("<script type=\"text/javascript\">");
                out.println("location='index.jsp';");
                out.println("</script>");
        }else{// si no se revisara campos en bd
        String tipo = "";
        // Definir variable de referencia a un objeto de tipo Usuario
        Usuario u = new Usuario();
        // Consultar Base de datos
        Avances a = new Avances();
            u = a.buscar(nombre, contrasena);// verificar campos en bd.
            if (u.getTipo().equals("n")) {//si no existe o se equivoco en alguno de los campos                 
                out.println("<script type=\"text/javascript\">");// regresa a la pantalla de inicio con un msj.
                out.println("alert('Usuario o contrasena incorrectos');");
                out.println("location='index.jsp';");
                out.println("</script>");
            } else {
                tipo = u.getTipo();
                switch (tipo) {// si es administrador
                    case "ADMIN":
                        objSesion.setMaxInactiveInterval(interv+1000);
                        objSesion.setAttribute("usuario", nombre);// asignar sesiones con su objeto.
                        objSesion.setAttribute("tipo", tipo);
                        objSesion.setAttribute("i_d", u.getId_usuario());
                        objSesion.setAttribute("conexion", a.getConexion());
                        request.setAttribute("usuario1", u);
                        response.sendRedirect("admin/index.jsp");// redirecciona pagina de inicio por tipo de usuario
                        break;
                    case "BASICO":
                    case "MEDIOBASICO":
                    case "PREINTERMEDIO":
                        //usuarios de planta
                        //System.out.println(tipo+"/Planta");
                        objSesion.setMaxInactiveInterval(interv);
                        objSesion.setAttribute("usuario", nombre);
                        objSesion.setAttribute("tipo", tipo);
                        objSesion.setAttribute("i_d", u.getId_usuario());
                        objSesion.setAttribute("conexion", a.getConexion());
                        response.sendRedirect("planta/index.jsp");
                        break;
                    case "USUARIO":
                        //usuario normal
                        ArrayList<String> array1= new ArrayList<>();
                        objSesion.setMaxInactiveInterval(interv+860);
                        objSesion.setAttribute("usuario", nombre);
                        objSesion.setAttribute("tipo", tipo);
                        objSesion.setAttribute("i_d", u.getId_usuario());
                        objSesion.setAttribute("cap",array1);
                        objSesion.setAttribute("conexion", a.getConexion());
                        request.setAttribute("usuario1", u);
                        response.sendRedirect("usuario/index.jsp");
                        break;
                    default:
                        // capturista
                        ArrayList<String> array= new ArrayList<>();
                        objSesion.setMaxInactiveInterval(interv+100000);
                        objSesion.setAttribute("usuario", nombre);
                        objSesion.setAttribute("tipo", tipo);
                        objSesion.setAttribute("i_d", u.getId_usuario());
                        objSesion.setAttribute("cap",array);
                        objSesion.setAttribute("conexion", a.getConexion());
                        request.setAttribute("usuario1", u);
                        response.sendRedirect("capturador/index.jsp");
                        break;
                }
            }
        
        }
        } catch (SQLException ex) {
            System.out.println(ex+" error "+ex.getMessage());
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Validar.class.getName()).log(Level.SEVERE, null, ex);
        }

        // Redireccionar a una pagina de respuesta
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

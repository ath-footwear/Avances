/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import Modelo.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import persistencia.Avances;

/**
 *
 * @author mich
 */
@WebServlet(name = "Cokie", urlPatterns = {"/Cokie"})
public class Cokie extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

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
        try {
            response.setContentType("text/html;charset=UTF-8");
            HttpSession sesion = request.getSession(true);
            Connection c = (Connection) sesion.getAttribute("con");

            String val = request.getParameter("pant");
//            System.out.println("aaa " + val);
            Cookie Galleta = new Cookie("pantalla", val);
//            El tiempo activo que durará la cookie
//            Galleta.setMaxAge(1*24*60*60);
            response.addCookie(Galleta);
            PrintWriter out = response.getWriter();
            Avances a = new Avances();
//            Se revisa que la conexion este activa para no abrir una nueva
            if (c != null) {
                System.out.println("conexion activa");
            } else {
                //System.out.println("No activaaaaaaaaaaaaaaaaaaa");
                a.abrir();
                sesion.setAttribute("con", a.getConexion());
//                sesion.setMaxInactiveInterval(1*24*60*60);
            }            
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Cokie.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Cokie.class.getName()).log(Level.SEVERE, null, ex);
        }
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

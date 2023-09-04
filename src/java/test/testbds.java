/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package test;

import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import persistencia.Avances;

/**
 *
 * @author GATEWAY1-
 */
public class testbds {
    public static void main(String [] args){
        try {
            testbd();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(testbds.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(testbds.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void testbd() throws ClassNotFoundException, SQLException{
    Avances a = new Avances();
            a.abrir();
            a.cerrar();
    
    }
}

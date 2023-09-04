/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pruebas;

import Modelo.Funciones;
import Modelo.pantalla;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import persistencia.Avances;
import persistencia.sqlpantallas;

/**
 *
 * @author GATEWAY1-
 */
public class pruebasumapares {
    public static void main(String [] args){
        pruebasumapares p = new pruebasumapares();
        p.getpuntos();
    }
    
    
    public void getpuntos(){
        try {
            Avances a = new Avances();
            sqlpantallas s = new sqlpantallas();
            a.abrir();
//            ArrayList<pantalla> arr=s.getprsxhr(a.getConexion(), 1, "22/08/2023", "corte");
////            for (pantalla arr1 : arr) {
////                System.out.println("* "+arr1.getH8()+"* "+arr1.getH9()+"* "+arr1.getH10()+"* "+arr1.getH11()+"* "+arr1.getH12()+"* "+arr1.getH13()+"* "+arr1.getH14()+"* "+arr1.getH15()+"* "+arr1.getH16()+"* "+arr1.getH17()+"* "+arr1.getH18());
////            }
//            Funciones f = new Funciones();
//            f.getprsxdepa(arr);
            a.cerrar();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(pruebasumapares.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(pruebasumapares.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}

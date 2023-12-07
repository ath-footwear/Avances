/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

import java.util.ArrayList;

/**
 *
 * @author GATEWAY1-
 */
public class formateodedatos {

    public boolean getfalla1imagen(ArrayList<Falla> arr) {
        String i2 = arr.get(0).getImagen2();
        String i3 = arr.get(0).getImagen3();
        String i4 = arr.get(0).getImagen4();
        String i5 = arr.get(0).getImagen5();
        String i6 = arr.get(0).getImagen6();
        return (i2.equals("fallas/blank.png") && i3.equals("fallas/blank.png")
                && i4.equals("fallas/blank.png") && i5.equals("fallas/blank.png") && i6.equals("fallas/blank.png"));
    }

    public boolean getfalla2imagen(ArrayList<Falla> arr) {
        String i3 = arr.get(0).getImagen3();
        String i4 = arr.get(0).getImagen4();
        String i5 = arr.get(0).getImagen5();
        String i6 = arr.get(0).getImagen6();
        return (i3.equals("fallas/blank.png")
                && i4.equals("fallas/blank.png") && i5.equals("fallas/blank.png") && i6.equals("fallas/blank.png"));
    }

}

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
public class Funciones {

    public String getmaqdep(String departamento) {
        String depa = "";
        switch (departamento) {
            case "corte":
                depa = "cormaq";
                break;
            case "precorte":
                depa = "precormaq";
                break;
            case "pespunte":
                depa = "pesmaq";
                break;
            case "deshebrado":
                depa = "desmaq";
                break;
            case "ojillado":
                depa = "ojimaq";
                break;
            case "inspeccion":
                depa = "inspmaq";
                break;
            case "preacabado":
                depa = "preamaq";
                break;
            case "montado":
            case "montado2":
                depa = "montmaq";
                break;
            case "pt":
                depa = "ptmaq";
                break;
        }
        return depa;
    }

    /**
     * Obtiene el nombre de la columna de la fecha de acuerdo al departamento
     *
     * @param departamento
     * @return
     */
    public String getnfechadep(String departamento) {
        String depa = "";
        switch (departamento) {
            case "corte":
                depa = "fechacor";
                break;
            case "precorte":
                depa = "fechaprecor";
                break;
            case "pespunte":
                depa = "fechapes";
                break;
            case "deshebrado":
                depa = "fechades";
                break;
            case "ojillado":
                depa = "fechaoji";
                break;
            case "inspeccion":
                depa = "fechainsp";
                break;
            case "preacabado":
                depa = "fechaprea";
                break;
            case "montado":
            case "montado2":
                depa = "fechamont";
                break;
            case "pt":
                depa = "fechapt";
                break;
        }
        return depa;
    }

    /**
     * Obtiene el departamento adecuado por si es que hay mas de un numero de
     * registro en el departamento
     *
     * @param departamento
     * @return
     */
    public String getndepa(String departamento) {
        String depa;
        switch (departamento) {
            case "montado2":
                depa = "montado";
                break;
            default:
                depa = departamento;
                break;
        }
        return depa;
    }

    public int[] getprsxdepa(ArrayList<pantalla> arrpantalla) {

        int puntero = 0;
        int arrsuma[] = new int[11];
        int canttotal = 0;
        for (int i = 0; i < arrpantalla.size(); i++) {
            int cantidad = 0;
//            System.out.println(cantidad + " puntero " + puntero);
            switch (puntero) {
                case 0:
                    cantidad = arrpantalla.get(i).getH8();
                    break;
                case 1:
                    cantidad = arrpantalla.get(i).getH9();
                    break;
                case 2:
                    cantidad = arrpantalla.get(i).getH10();
                    break;
                case 3:
                    cantidad = arrpantalla.get(i).getH11();
                    break;
                case 4:
                    cantidad = arrpantalla.get(i).getH12();
                    break;
                case 5:
                    cantidad = arrpantalla.get(i).getH13();
                    break;
                case 6:
                    cantidad = arrpantalla.get(i).getH14();
                    break;
                case 7:
                    cantidad = arrpantalla.get(i).getH15();
                    break;
                case 8:
                    cantidad = arrpantalla.get(i).getH16();
                    break;
                case 9:
                    cantidad = arrpantalla.get(i).getH17();
                    break;
                case 10:
                    cantidad = arrpantalla.get(i).getH18();
                    break;
            }
            if (cantidad != 0) {
                arrsuma[puntero] += cantidad;
            } else {
                puntero++;
                i--;
//                if (arrpantalla.size() > 1) {
//                    i--;
//                }
                if(puntero==11){
                i=arrpantalla.size();
                }
            }
        }
        pantalla p = new pantalla();
        p.setH8(arrsuma[0]);
        p.setH9(arrsuma[1]);
        p.setH10(arrsuma[2]);
        p.setH11(arrsuma[3]);
        p.setH12(arrsuma[4]);
        p.setH13(arrsuma[5]);
        p.setH14(arrsuma[6]);
        p.setH15(arrsuma[7]);
        p.setH16(arrsuma[8]);
        p.setH17(arrsuma[9]);
        p.setH18(arrsuma[10]);
        return arrsuma;
    }
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

/**
 *
 * @author GATEWAY1-
 */
public class metadep implements java.io.Serializable{

    private String nombre;
    private int cantxhr;
    private int cantxdia;

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getCantxhr() {
        return cantxhr;
    }

    public void setCantxhr(int cantxhr) {
        this.cantxhr = cantxhr;
    }

    public int getCantxdia() {
        return cantxdia;
    }

    public void setCantxdia(int cantxdia) {
        this.cantxdia = cantxdia;
    }
}

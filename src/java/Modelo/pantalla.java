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
public class pantalla implements java.io.Serializable{
    private int pantalla,orders;
    private String nombre,corte,precorte,pespunte,deshebrado,ojillado,inspeccion,montado,pt, depa;
    private int h8,h9,h10,h11,h12,h13,h14,h15,h16,h17,h18;

    public int getOrders() {
        return orders;
    }

    public void setOrders(int orders) {
        this.orders = orders;
    }

    public int getH8() {
        return h8;
    }

    public void setH8(int h8) {
        this.h8 = h8;
    }

    public int getH9() {
        return h9;
    }

    public void setH9(int h9) {
        this.h9 = h9;
    }

    public int getH10() {
        return h10;
    }

    public void setH10(int h10) {
        this.h10 = h10;
    }

    public int getH11() {
        return h11;
    }

    public void setH11(int h11) {
        this.h11 = h11;
    }

    public int getH12() {
        return h12;
    }

    public void setH12(int h12) {
        this.h12 = h12;
    }

    public int getH13() {
        return h13;
    }

    public void setH13(int h13) {
        this.h13 = h13;
    }

    public int getH14() {
        return h14;
    }

    public void setH14(int h14) {
        this.h14 = h14;
    }

    public int getH15() {
        return h15;
    }

    public void setH15(int h15) {
        this.h15 = h15;
    }

    public int getH16() {
        return h16;
    }

    public void setH16(int h16) {
        this.h16 = h16;
    }

    public int getH17() {
        return h17;
    }

    public void setH17(int h17) {
        this.h17 = h17;
    }

    public int getH18() {
        return h18;
    }

    public void setH18(int h18) {
        this.h18 = h18;
    }

    public String getDepa() {
        return depa;
    }

    public void setDepa(String depa) {
        this.depa = depa;
    }

    public int getPantalla() {
        return pantalla;
    }

    public void setPantalla(int pantalla) {
        this.pantalla = pantalla;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCorte() {
        return corte;
    }

    public void setCorte(String corte) {
        this.corte = corte;
    }

    public String getPrecorte() {
        return precorte;
    }

    public void setPrecorte(String precorte) {
        this.precorte = precorte;
    }

    public String getPespunte() {
        return pespunte;
    }

    public void setPespunte(String pespunte) {
        this.pespunte = pespunte;
    }

    public String getDeshebrado() {
        return deshebrado;
    }

    public void setDeshebrado(String deshebrado) {
        this.deshebrado = deshebrado;
    }

    public String getOjillado() {
        return ojillado;
    }

    public void setOjillado(String ojillado) {
        this.ojillado = ojillado;
    }

    public String getInspeccion() {
        return inspeccion;
    }

    public void setInspeccion(String inspeccion) {
        this.inspeccion = inspeccion;
    }

    public String getMontado() {
        return montado;
    }

    public void setMontado(String montado) {
        this.montado = montado;
    }

    public String getPt() {
        return pt;
    }

    public void setPt(String pt) {
        this.pt = pt;
    }
}

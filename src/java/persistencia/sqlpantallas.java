/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package persistencia;

import Modelo.Anuncio;
import Modelo.Falla;
import Modelo.Funciones;
import Modelo.Tiempospantalla;
import Modelo.metadep;
import Modelo.pantalla;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author GATEWAY1-
 */
public class sqlpantallas {

    public ArrayList<metadep> getmetas(Connection c, String dep) {
        ArrayList<metadep> arr = new ArrayList<>();
        try {
            ResultSet rs;
            PreparedStatement st;
            String sql = "select * from metaxdep where nombre='" + dep + "'";
//            System.out.println("metas " + sql);
            st = c.prepareStatement(sql);
            rs = st.executeQuery();
            while (rs.next()) {
                metadep m = new metadep();
                m.setNombre(rs.getString("nombre"));
                m.setCantxhr(rs.getInt("cantxhr"));
                m.setCantxdia(rs.getInt("cantxdia"));
                arr.add(m);
            }
            rs.close();
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(sqlpantallas.class.getName()).log(Level.SEVERE, null, ex);
        }
        return arr;
    }

    public ArrayList<pantalla> getpantalla(Connection c) {
        ArrayList<pantalla> arr = new ArrayList<>();
        try {
            ResultSet rs;
            PreparedStatement st;
            String sql = "select pantalla,nombre from pantallas";
            st = c.prepareStatement(sql);
            rs = st.executeQuery();
            while (rs.next()) {
                pantalla p = new pantalla();
                p.setPantalla(rs.getInt("pantalla"));
                p.setNombre(rs.getString("nombre"));
                arr.add(p);
            }
            rs.close();
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(sqlpantallas.class.getName()).log(Level.SEVERE, null, ex);
        }
        return arr;
    }

    public ArrayList<pantalla> getpantallaindividual(Connection c, int pantalla) {
        ArrayList<pantalla> arr = new ArrayList<>();
        try {
            ResultSet rs;
            PreparedStatement st;
            String sql = "select pantalla,nombre,depa,orders\n"
                    + "from pantallas\n"
                    + "unpivot\n"
                    + "(\n"
                    + " orders for depa in(corte,precorte,pespunte,deshebrado,ojillado,inspeccion,preacabado,montado,montado2,pt) \n"
                    + ") as p\n"
                    + "where orders!=0 and pantalla=" + pantalla;
            //System.out.println("npant " + sql);
            st = c.prepareStatement(sql);
            rs = st.executeQuery();
            while (rs.next()) {
                pantalla p = new pantalla();
                p.setPantalla(rs.getInt("pantalla"));
                p.setNombre(rs.getString("nombre"));
                p.setDepa(rs.getString("depa"));
                p.setOrders(rs.getInt("orders"));

                arr.add(p);
            }
            rs.close();
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(sqlpantallas.class.getName()).log(Level.SEVERE, null, ex);
        }
        return arr;
    }

    public ArrayList<pantalla> getprsxhr(Connection c, int pantalla, String fecha, String depaanterior, int orders) {
        ArrayList<pantalla> arr = new ArrayList<>();
        Funciones f = new Funciones();
        String dep = f.getnfechadep(depaanterior);
        String departamento = f.getndepa(depaanterior);
        String maq = f.getmaqdep(depaanterior);
        try {
            ResultSet rs;
            PreparedStatement st;
//            Se amplio la hora inicial y final por posibles fallos en el despliegue de las pantallas
//            Mas que nada porque estan fuera de rango
            String sql = "select " + departamento + ", \n"
                    + " h8=case when convert(int,substring(convert(varchar," + dep + ",8),0,3))>=6 and convert(int,substring(convert(varchar," + dep + ",8),0,3))<9 then sum(npares) else 0 end,\n"
                    + " h9=case when convert(int,substring(convert(varchar," + dep + ",8),0,3))>=9 and convert(int,substring(convert(varchar," + dep + ",8),0,3))<10 then sum(npares) else 0 end,\n"
                    + " h10=case when convert(int,substring(convert(varchar," + dep + ",8),0,3))>=10 and convert(int,substring(convert(varchar," + dep + ",8),0,3))<11 then sum(npares) else 0 end,\n"
                    + " h11=case when convert(int,substring(convert(varchar," + dep + ",8),0,3))>=11 and convert(int,substring(convert(varchar," + dep + ",8),0,3))<12 then sum(npares) else 0 end,\n"
                    + " h12=case when convert(int,substring(convert(varchar," + dep + ",8),0,3))>=12 and convert(int,substring(convert(varchar," + dep + ",8),0,3))<13 then sum(npares) else 0 end,\n"
                    + " h13=case when convert(int,substring(convert(varchar," + dep + ",8),0,3))>=13 and convert(int,substring(convert(varchar," + dep + ",8),0,3))<14 then sum(npares) else 0 end,\n"
                    + " h14=case when convert(int,substring(convert(varchar," + dep + ",8),0,3))>=14 and convert(int,substring(convert(varchar," + dep + ",8),0,3))<15 then sum(npares) else 0 end,\n"
                    + " h15=case when convert(int,substring(convert(varchar," + dep + ",8),0,3))>=15 and convert(int,substring(convert(varchar," + dep + ",8),0,3))<16 then sum(npares) else 0 end,\n"
                    + " h16=case when convert(int,substring(convert(varchar," + dep + ",8),0,3))>=16 and convert(int,substring(convert(varchar," + dep + ",8),0,3))<17 then sum(npares) else 0 end,\n"
                    + " h17=case when convert(int,substring(convert(varchar," + dep + ",8),0,3))>=17 and convert(int,substring(convert(varchar," + dep + ",8),0,3))<18 then sum(npares) else 0 end,\n"
                    + " h18=case when convert(int,substring(convert(varchar," + dep + ",8),0,3))>=18 and convert(int,substring(convert(varchar," + dep + ",8),0,3))<20 then sum(npares) else 0 end\n"
                    + "from programa p\n"
                    + "join avance a on a.id_prog=p.id_prog\n"
                    + "where convert(date," + dep + ") = '" + fecha + "' and " + departamento + "=" + orders + " and " + maq + "='PL'\n"
                    + "group by " + dep + "," + departamento + "\n"
                    + "order by " + dep + "";
            //System.out.println("npant " + sql);
            st = c.prepareStatement(sql);
            rs = st.executeQuery();
            while (rs.next()) {
                pantalla p = new pantalla();
                p.setPantalla(pantalla);
                p.setH8(rs.getInt("h8"));
                p.setH9(rs.getInt("h9"));
                p.setH10(rs.getInt("h10"));
                p.setH11(rs.getInt("h11"));
                p.setH12(rs.getInt("h12"));
                p.setH13(rs.getInt("h13"));
                p.setH14(rs.getInt("h14"));
                p.setH15(rs.getInt("h15"));
                p.setH16(rs.getInt("h16"));
                p.setH17(rs.getInt("h17"));
                p.setH18(rs.getInt("h18"));
                arr.add(p);
            }
            rs.close();
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(sqlpantallas.class.getName()).log(Level.SEVERE, null, ex);
        }
        return arr;
    }

    public ArrayList<Anuncio> getanuncios(Connection c, int pantalla, String fechav) {
        ArrayList<Anuncio> arr = new ArrayList<>();
        try {
            PreparedStatement st;
            ResultSet rs;
            String sql = "select top(3) * from anuncios\n" +
"                    where estatus='1' and pantalla="+pantalla+" and convert(date,fechav)>='14/12/2023'\n" +
"                    order by fecha desc";
            st = c.prepareStatement(sql);
            rs = st.executeQuery();
            while (rs.next()) {
                Anuncio a = new Anuncio();
                a.setAnuncio(rs.getInt("anuncio"));
                a.setAsunto(rs.getString("asunto"));
                a.setPantalla(pantalla);
                a.setCuerpo(rs.getString("cuerpo"));
                a.setImagen(rs.getString("imagen"));
                arr.add(a);
            }
        } catch (SQLException ex) {
            Logger.getLogger(sqlpantallas.class.getName()).log(Level.SEVERE, null, ex);
        }
        return arr;
    }

    public ArrayList<Falla> getfallas(Connection c, int pantalla) {
        ArrayList<Falla> arr = new ArrayList<>();
        try {
            PreparedStatement st;
            ResultSet rs;
            String sql = "select * from fallas\n"
                    + "where estatus='1' and pantalla=" + pantalla+" "
                    + "order by fecha desc";
            st = c.prepareStatement(sql);
            rs = st.executeQuery();
            while (rs.next()) {
                Falla f = new Falla();
                f.setFalla(rs.getInt("id_falla"));
                f.setPantalla(pantalla);
                f.setNombrefalla(rs.getString("nombrefalla"));
                f.setUsuario(rs.getString("usuario"));
                f.setObservaciones(rs.getString("observaciones"));
                f.setImagen1(rs.getString("imagen1"));
                f.setImagen2(rs.getString("imagen2"));
                f.setImagen3(rs.getString("imagen3"));
                f.setImagen4(rs.getString("imagen4"));
                f.setImagen5(rs.getString("imagen5"));
                f.setImagen6(rs.getString("imagen6"));
                f.setDescimag1(rs.getString("descimagen1"));
                f.setDescimag2(rs.getString("descimagen2"));
                f.setDescimag3(rs.getString("descimagen3"));
                f.setDescimag4(rs.getString("descimagen4"));
                f.setDescimag5(rs.getString("descimagen5"));
                f.setDescimag6(rs.getString("descimagen6"));
                arr.add(f);
            }
        } catch (SQLException ex) {
            Logger.getLogger(sqlpantallas.class.getName()).log(Level.SEVERE, null, ex);
        }
        return arr;
    }
    
        public Tiempospantalla getiempos(Connection c) {
         Tiempospantalla t = new Tiempospantalla();
        try {
            PreparedStatement st;
            ResultSet rs;
            String sql = "select * from tiempospantalla";
            st = c.prepareStatement(sql);
            rs = st.executeQuery();
            while (rs.next()) {
                t.setPantmin(rs.getInt("pantmin"));
                t.setPantsup(rs.getInt("pantsup"));
                t.setAnunmin(rs.getInt("anunmin"));
                t.setAnunsup(rs.getInt("anunsup"));
                t.setFallamin(rs.getInt("fallamin"));
                t.setFallasup(rs.getInt("fallasup"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(sqlpantallas.class.getName()).log(Level.SEVERE, null, ex);
        }
        return t;
    }
}

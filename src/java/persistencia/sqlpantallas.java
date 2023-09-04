/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package persistencia;

import Modelo.Funciones;
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
            System.out.println("metas " + sql);
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
            System.out.println("npant " + sql);
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
        String dep=f.getnfechadep(depaanterior);
        String departamento=f.getndepa(depaanterior);
        try {
            ResultSet rs;
            PreparedStatement st;
            String sql = "select "+departamento+", \n"
                    + " h8=case when convert(int,substring(convert(varchar,"+dep+",8),0,3))>=8 and convert(int,substring(convert(varchar,"+dep+",8),0,3))<9 then sum(npares) else 0 end,\n"
                    + " h9=case when convert(int,substring(convert(varchar,"+dep+",8),0,3))>=9 and convert(int,substring(convert(varchar,"+dep+",8),0,3))<10 then sum(npares) else 0 end,\n"
                    + " h10=case when convert(int,substring(convert(varchar,"+dep+",8),0,3))>=10 and convert(int,substring(convert(varchar,"+dep+",8),0,3))<11 then sum(npares) else 0 end,\n"
                    + " h11=case when convert(int,substring(convert(varchar,"+dep+",8),0,3))>=11 and convert(int,substring(convert(varchar,"+dep+",8),0,3))<12 then sum(npares) else 0 end,\n"
                    + " h12=case when convert(int,substring(convert(varchar,"+dep+",8),0,3))>=12 and convert(int,substring(convert(varchar,"+dep+",8),0,3))<13 then sum(npares) else 0 end,\n"
                    + " h13=case when convert(int,substring(convert(varchar,"+dep+",8),0,3))>=13 and convert(int,substring(convert(varchar,"+dep+",8),0,3))<14 then sum(npares) else 0 end,\n"
                    + " h14=case when convert(int,substring(convert(varchar,"+dep+",8),0,3))>=14 and convert(int,substring(convert(varchar,"+dep+",8),0,3))<15 then sum(npares) else 0 end,\n"
                    + " h15=case when convert(int,substring(convert(varchar,"+dep+",8),0,3))>=15 and convert(int,substring(convert(varchar,"+dep+",8),0,3))<16 then sum(npares) else 0 end,\n"
                    + " h16=case when convert(int,substring(convert(varchar,"+dep+",8),0,3))>=16 and convert(int,substring(convert(varchar,"+dep+",8),0,3))<17 then sum(npares) else 0 end,\n"
                    + " h17=case when convert(int,substring(convert(varchar,"+dep+",8),0,3))>=17 and convert(int,substring(convert(varchar,"+dep+",8),0,3))<18 then sum(npares) else 0 end,\n"
                    + " h18=case when convert(int,substring(convert(varchar,"+dep+",8),0,3))>=18 and convert(int,substring(convert(varchar,"+dep+",8),0,3))<19 then sum(npares) else 0 end\n"
                    + "from programa p\n"
                    + "join avance a on a.id_prog=p.id_prog\n"
                    + "where convert(date,"+dep+") = '"+fecha+"' and "+departamento+"="+orders+"\n"
                    + "group by "+dep+","+departamento+"\n"
                    + "order by "+dep+"";
            System.out.println("npant " + sql);
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
}

<%-- 
    Document   : index
    Created on : Sep 26, 2017, 2:39:00 PM
    Author     : gateway1
--%>
<%@page import="java.util.Calendar"%>
<%@page import="Modelo.Programa"%>
<%@page import="java.util.ArrayList"%>
<%@page import="persistencia.Avances"%>
<% HttpSession objSesion = request.getSession(true);
//i_d
    boolean estado;
    String usuario = (String) objSesion.getAttribute("usuario");
    String tipos = (String) objSesion.getAttribute("tipo");
    String ids = String.valueOf(objSesion.getAttribute("i_d"));

    //out.print(carrito.size());
    // out.println("" + tipos+"/"+ids);
    if (usuario != null && tipos != null) {
        if(tipos.equals("ADMIN")){
        }else
            response.sendRedirect("../index.jsp");
    } else {
        response.sendRedirect("../index.jsp");
    }
     Calendar fecha = Calendar.getInstance();
    int year = fecha.get(Calendar.YEAR);
    int mes = fecha.get(Calendar.MONTH) + 1;
    Avances bd = new Avances();
    String autofill=bd.check_autofill();
    String autofillm=bd.check_autofill_m();
    // estado = bd.alerta();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
    <head>
        
        <meta http-equiv="refresh" content="800">
        <link rel="icon"  href="../images/aff.png" sizes="32x32"/>
        <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
        <link rel='stylesheet' type="text/css" href="../css/bootstrap.min.css">
        <link rel='stylesheet' type="text/css" href="../css/responsive.css">
        <link rel="stylesheet" type="text/css" href="../css/fondos.css">
        <link rel="stylesheet" type="text/css" href="../css/loginn.css">
        <link rel="stylesheet" type="text/css" href="../css/letras.css">
        <script type="text/javascript" src="../js/bootstrap.js"></script>
        <script type="text/javascript" src="../js/bootstrap.min.js"></script>
        <script type="text/javascript" src="../js/jquery-3.1.1.min.js"></script>
        <script type="text/javascript" src="../js/bootstrap.min.js"></script>

        <title>Home</title>
    </head>
    <body class="body1">
        <div class="container-fluid">
                <nav class="navbar navbar-default">
                <ul class="nav navbar-nav nav-pills">
                    <li><a class="navbar-brand" href="index.jsp"><img src="../images/home.png" class="" width="25"></a></li>
                    <li class="dropdown ln">
                        <a  class="dropdown-toggle" data-toggle="dropdown" href="#80">
                            Usuario<span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu" id="#90" role="menu">

                            <li class="ln"><a href="">Busqueda</a></li>
                            <li class="ln"><a href="lote_detenido.jsp">Lotes detenidos</a></li>
                            <li class="ln"><a href="verpares.jsp">Ver pares</a></li>   
                        </ul>
                    </li>
                    <!--<li class="ln"><a  href="../Dateupdate">actualizar fechas</a></li>-->
                    <li class="ln"><a href="../Cierresesion">Salir</a></li>
                   

                </ul>
                <div style="float:right" class="nav nav-pills">
                    <li > <label class="ln">Online: <%=usuario%></label></li>
                    <li class="ln btnmy-2 my-sm-0 "><a ><img src="../images/opciones.png" width="5" height="20" alt=""></a></li>
                </div>
            </nav>
            <div class="container" align="center">
                <div class="espacio-md-up"></div>
                <div class="row espacios-lg fondos jumbis" align="center">
                    <label class="ln-ln fuera">opciones</label><br>
                    <div class="row" align="center">
                        <div class="col-sm-offset-4 col-sm-2">
                            <label class="ln">auto-rellenado :</label>
                        </div>
                        <div class="col-sm-1" id="fillstatus">
                            <%
                            if(autofill.equals("1")){
                                  out.print("<input type=\"checkbox\" name=\"auto_fill\" id=\"auto_fill\" onchange=\"autofill()\" checked=\"checked\"/ >");
                            }else out.print("<input type=\"checkbox\" name=\"auto_fill\" id=\"auto_fill\" onchange=\"autofill()\"/>"); 
                            %></div> 
                    </div>
                    <div class="row" align="center">
                        <div class="col-sm-offset-4 col-sm-2">
                            <label class="ln">auto-rellenado personal:</label>
                        </div>
                        <div class="col-sm-1" id="fillstatus">
                            <%
                            if(autofillm.equals("1")){
                                  out.print("<input type=\"checkbox\" name=\"auto_fill_m\" id=\"auto_fill_m\" onchange=\"autofillm()\" checked=\"checked\"/ >");
                            }else out.print("<input type=\"checkbox\" name=\"auto_fill_m\" id=\"auto_fill_m\" onchange=\"autofillm()\"/>"); 
                            %></div> 
                    </div>
                    <br>
                </div>
                   <div id="respuesta" class="row deep-sm"></div>
            </div><br>
        </div> 
    <script>
       function jumpto(){
           document.getElementById("mes").focus();
       }
        
        function autofill(){
        var programa = '0';
                var lote = '0';
                var estilo = '0';
                var pares = '0';
                var corrida = '0';
                var combinacion = '0';
                var mes ='0';    
        var autofill;
            if(document.getElementById("auto_fill").checked==true){
                autofill="1";
            }else autofill="0";
            var uso ="autofill";
            $.ajax({
                    type: 'post',
                    data: {f: programa, f1: lote, f2: estilo, f3: pares, f4: corrida, f5: combinacion, f6: mes,uso: uso,autofill:autofill},
                    url: '../Getregs',
                    success: function (result) {
                        $('#auto_fill').html(result);
                        // document.location.reload();
                        //document.forma1.lote.focus();
                    }
                });
        }        
        function autofillm(){
        var programa = '0';
                var lote = '0';
                var estilo = '0';
                var pares = '0';
                var corrida = '0';
                var combinacion = '0';
                var mes ='0';    
        var autofill;
            if(document.getElementById("auto_fill_m").checked==true){
                autofill="1";
            }else autofill="0";
            var uso ="autofillm";
            $.ajax({
                    type: 'post',
                    data: {f: programa, f1: lote, f2: estilo, f3: pares, f4: corrida, f5: combinacion, f6: mes,uso: uso,autofill:autofill},
                    url: '../Getregs',
                    success: function (result) {
                        $('#auto_fill_m').html(result);
                        // document.location.reload();
                        //document.forma1.lote.focus();
                    }
                });
        }
            
        function saltok(){
            document.getElementById("boton").focus();
            
        }
    </script>
</body>
</html>

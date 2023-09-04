<%-- 
    Document   : index
    Created on : Sep 26, 2017, 2:39:00 PM
    Author     : gateway1
--%>

<%@page import="java.util.ArrayList"%>
<% HttpSession objSesion = request.getSession(false);
    boolean estado;
    String usuario = (String) objSesion.getAttribute("usuario");
    try {
        String tipos = (String) objSesion.getAttribute("tipo");
        String ids = String.valueOf(objSesion.getAttribute("i_d"));
        if (usuario != null && tipos != null && tipos.equals("INTERMEDIO")) {
            // out.println(usuario);
        } else {
            response.sendRedirect("../index.jsp");
        }
        Avances bd = new Avances();
        ArrayList<String> array = array = bd.getmaquila();
%>
<%@page import="java.io.PrintWriter"%>
<%@page import="persistencia.Avances"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
    <head>
        <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon"  href="../images/aff.png" sizes="32x32"/>
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
        <!--<script type="text/javascript" src="http://librosweb.es/ejemplos/bootstrap_3/js/bootstrap.min.js"></script>-->
        <script>
            $(document).ready(function () {
                document.getElementById("maquila").focus();
            });
        </script>
        <script>

        </script>
        <title>Planta</title>
    </head>
    <body class="body1" >
        <div class="container-fluid">
            <div></div>
            <nav class="navbar navbar-default">
                <ul class="nav navbar-nav nav-pills">
                    <li ><a class="navbar-brand" href="index.jsp"><img src="../images/home.png" class="" width="25"></a></li>
                    <li class="ln"><a href="buscalote.jsp">Reporte Programa</a></li>
                    <li class="ln active"><a  href="">Avance General</a></li>
                    <li class="ln"><a href="verpares.jsp">Ver Pares</a></li>
                    <li class="ln"><a href="../Cierresesion">Salir</a></li>
                </ul>
                <div style="float:right" class="nav nav-pills">
                    <li > <label class="ln">Online: <%=usuario%></label></li>
                </div>
            </nav>
            <div class="container" align="center">
                <div class="espacio-md-up">
                    <%
                        if (usuario.equals("leon")) {
                            out.println("<label class=l1>Origen:&nbsp;&nbsp;&nbsp;" + usuario.toUpperCase() + "</label>");
                        } else if (tipos.equals("INTERMEDIO")) {
                    %>
                    <div class="col-sm-7" align="center" id="avancemaquilas">
                        <div class="col-sm-offset-8" align="center">
                            <label class="l1">Maquila: </label> <select class="btn form-control" style="color:black" name="maquila" id="maquila" onchange="salto()">
                                <%
                                    for (int i = 0; i < array.size(); i++) {
                                        out.print("<option>" + array.get(i) + "</option>");
                                    }
                                %>
                            </select><br><br>
                            <label class="l1">Departamento: </label> <select class="btn form-control" style="color:black" name="depmaquila" id="depmaquila" onchange="salto1()">
                                <%
                                    out.print("<option>corte</option>");
                                    out.print("<option>precorte</option>");
                                    out.print("<option>pespunte</option>");
                                    out.print("<option>deshebrado</option>");
                                    out.print("<option>ojillado</option>");
                                    out.print("<option>inspeccion</option>");
                                    out.print("<option>preacabado</option>");
                                    out.print("<option>montado</option>");
                                %>
                            </select><br><br>                
                        </div></div>
                        <%
                            } else {
                                out.println("<label class=l1>Departamento:&nbsp;&nbsp;&nbsp;" + usuario.toUpperCase() + "</label>");
                            }
                        %>
                    <div class="row espacios-lg">
                        <div class="col-md-8" align="center">
                            <div class="col-md-offset-6" align="center">
                                <div style=" <% if (usuario.equals("leon")) {
                                    out.print("display: block");
                                } else {
                                    out.print("display: none");
                                }%>">
                                    DEPARTAMENTO : <select style="color:black" name="depar" id="depar" onchange="salto()">
                                        <option>corte</option>
                                        <option>precorte</option>
                                        <option>pespunte</option>
                                    </select><br><br>
                                </div>
                                <div style=" <% if (!usuario.equals("leon") && !usuario.equals("avancemaquila") && !tipos.equals("INTERMEDIO")) {
                                    out.print("display: block");
                                } else {
                                    out.print("display: none");
                                }%>">
                                    <label  style="color:black" class="l1" onchange="salto()" disabled >ORIGEN:&nbsp;&nbsp;&nbsp;&nbsp;PLANTA</label>
                                    <div class="stealth"><input name="marcas" id="marcas" value="PLANTA"></div>
                                    <br><br>
                                </div>
                                <div>
                                    <div style=" <% if (usuario.equals("montado")) {
                                            out.print("display: block");
                                        } else {
                                            out.print("display: none");
                                        }%>" id="divbanda">
                                        BANDA: <select style="color:black" name="banda" id="banda" onchange="salto2()">
                                            <option>1</option>
                                            <option>2</option>
                                            <option>3</option>
                                        </select><br><br>
                                    </div>
                                </div>
                                <br><br>
                                <label class="ln">Codigo:</label>
                                <input type="text" name="codigo" id="codigo" class="form-control" onchange="okas()" required><br>
                                <!--<input type="submit" name="ok" id="ok" class="btn btn-danger" onclick="okas()">-->
                            </div>
                        </div>
                    </div>
                    <div id="llenado"></div>
                </div>                
            </div>

        </div>
        <script>
            function okas() {
                var marcas = $('#marcas').val();
                var depar = $('#depar').val();
                var banda = $('#banda').val();
                var codigo = $('#codigo').val();
                var maquila = $('#maquila').val();
                var depmaquila = $('#depmaquila').val();
                $.ajax({
                    type: 'post',
                    data: {marcas: marcas, depar: depar, banda: banda, codigo: codigo, maquila: maquila, depmaquila: depmaquila},
                    url: '../formaravance',
                    success: function (result) {
                        $('#llenado').html(result);
                        document.getElementById("codigo").value = "";
                    }
                });
            }
            function salto() {
                document.getElementById("depmaquila").focus();
            }
            function salto1() {
                var banda = $('#depmaquila').val();
                if (banda == 'montado') {
                    document.getElementById("divbanda").style.display = 'block';
                    //document.getElementById("divbanda").innerHTML='BANDA: <select style="color:black" name="banda" id="banda" onchange="salto()"><option>1</option> <option>2</option> <option>3</option> </select><br><br>';
                    document.getElementById("banda").focus();
                } else {
                    document.getElementById("divbanda").style.display = 'none';
                    document.getElementById("codigo").focus();
                }
            }
            function salto2() {
                document.getElementById("codigo").focus();
            }
        </script>
    </body>
</html>
<%
    } catch (Exception e) {
        out.println("<script type=\"text/javascript\">");
        out.println("location='../index.jsp';");
        out.println("</script>");
    }
%>
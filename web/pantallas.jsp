<%-- 
    Document   : Log
    Author     : mich
--%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Modelo.Funciones"%>
<%@page import="Modelo.metadep"%>
<%@page import="java.sql.Connection"%>
<%@page import="persistencia.sqlpantallas"%>
<%@page import="java.util.List"%>
<%@page import="persistencia.Avances"%>
<%@page import="Modelo.pantalla"%>
<%@page import="java.util.ArrayList"%>
<%
    try {
        HttpSession sesion = request.getSession(false);
        //Se obtiene la cockie de la conexion, si es que existe alguna
        Connection c = (Connection) sesion.getAttribute("con");
        //Array que contiene o contendra todas las pantallas dadas de alta
        List<pantalla> arr = new ArrayList<pantalla>();
        Cookie[] galleta = request.getCookies();
        java.util.Date date = new Date();
        //fecha a mostrar 
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        //Variable utilizada para saber si volver a abrir una conexion o no
        boolean band = true;
// Se revisa cada cockie encontrada mediante el for y se busca especificamente la llamada pantalla
        for (int i = 0; i < galleta.length; i++) {
            System.out.println(i + " " + galleta[i].getName());
            if (galleta[i].getName().equals("pantalla")) {
                //System.out.println("ejecuta consulta " + galleta[i].getValue());
                band = false;
                i = galleta.length;
            }
        }
        if (c != null) {
            //System.out.println("Hola");
            sqlpantallas s = new sqlpantallas();
            arr = s.getpantalla(c);
        } else {
            //Solo es para mostrar que aqui entro
            //System.out.println("nel");
        }
        if (band) {
            //System.out.println("no avance");
            Avances a = new Avances();
            a.abrir();
            sqlpantallas s = new sqlpantallas();
            arr = s.getpantalla(a.getConexion());
        }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pantalla</title>
        <link rel="icon"  href="images/aff.png" sizes="32x32"/>
        <link rel="stylesheet" type="text/css" href="css/loginn.css">
        <link rel="stylesheet" type="text/css" href="css/opcional.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
        <script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
        <script type="text/javascript">

            function creacockie() {
                var uso = $('#pant').val();
                //alert(uso);
                $.ajax({
                    type: 'post',
                    data: {pant: uso},
                    url: 'Cokie',
                    success: function (result) {
                        $('#respuesta').html(result);
                        window.location.reload();
                    }
                });
            }
            function reload() {
                window.location.reload();
            }
        </script>
    </head>
    <body class="" >
        <div class="col-md-12">
            <div align="left" class="col-md-2"><a href="index.jsp"><img src="images/AF.png" width="150px" height="70px" class="img-responsive"/></a></div>
            <div align="right" class="col-md-10 combos" >
                <select id="pant" name="pant">
                    <%  for (int i = 0; i < arr.size(); i++) {
                            out.println("<option selected value=" + arr.get(i).getPantalla() + "><h2 class=combos>" + arr.get(i).getNombre() + "</h2></option>");
                        }
                    %>
                </select>
            </div>
        </div>

        <div class="col-md-12">
            <div align="left" class="col-md-4" style="">
                <h3 class="encabezado">Fecha: <%=sdf.format(date)%></h3>
            </div>
            <div align="right" class="col-md-8" style="">
                <button class="btn-success btn"   onclick="creacockie()">
                    <p class="combos">Iniciar</p>
                </button>
            </div>

        </div>



        <div align="center" style="padding-top: 1%">

            <%    for (int i = 0; i < galleta.length; i++) {
                    System.out.println("--------------------" + galleta[i].getName());
//                  Entra solo si la cokie es la indicada, sino no hace toda esta parte de carga                    
                    if (galleta[i].getName().equals("pantalla")) {
                        out.println("<script type=text/javascript>setTimeout(reload, 50000);</script>");
                        System.out.println("ejecuta consulta " + galleta[i].getValue());
                        sqlpantallas a = new sqlpantallas();
                        //Obtiene los departamentos de la pantalla seleccionada de los cuales se usará su nombre y tipo de orden
                        ArrayList<pantalla> arrpant = a.getpantallaindividual(c, Integer.parseInt(galleta[i].getValue()));
                        for (int j = 0; j < arrpant.size(); j++) {
//                          Clase para funciones extra, para formatear u obtener datos mas concretos               
                            Funciones f = new Funciones();
//                          Arraylist que obtiene los datos de pares de cada departamento  
                            List<metadep> arrmeta = a.getmetas(c, f.getndepa(arrpant.get(j).getDepa()));
//                          Almacenar en variables los datos de los arrays para que no sea tan grande la instruccion de el metodo a llamar  
                            int pantallaarr = Integer.parseInt(galleta[i].getValue());
                            int orders = arrpant.get(j).getOrders();
                            String departamento = arrpant.get(j).getDepa();
                            int total = 0;
//                          Obtener los pares x hr mediante un query a la base de datos  
                            ArrayList<pantalla> arrpares=a.getprsxhr(c,pantallaarr, sdf.format(date), departamento, orders);
                            //ArrayList<pantalla> arrpares = a.getprsxhr(c, pantallaarr, "22/08/2023", departamento, orders);
//                          Esta funcion formatea el numero de renglones a solo un renglon de tipo array normal  
                            int[] arrprs = f.getprsxdepa(arrpares);
                            //System.out.println("aaaaaaa "+arrpares.size()+" bbbbbbb "+arrprs.length);
            %>

            <div class="container-fluid" align="center">
                <div class=" " >
                    <div class="row" >
                        <div class="col-sm-12" >
                            <div >
                                <div class="table-responsive" >
                                    <h3 class="encabezado fondoencdep" ><%=arrpant.get(j).getDepa().toUpperCase()%></h3>
                                    <table class="table table-striped table-hover col-sm-12" >
                                        <thead class="encabezado">
                                        <td scope="col" class="alineartabla">8</td>
                                        <td scope="col" class="alineartabla">9</td>
                                        <td scope="col" class="alineartabla">10</td>
                                        <td scope="col" class="alineartabla">11</td>
                                        <td scope="col" class="alineartabla">12</td>
                                        <td scope="col" class="alineartabla">13</td>
                                        <td scope="col" class="alineartabla">14</td>
                                        <td scope="col" class="alineartabla">15</td>
                                        <td scope="col" class="alineartabla">16</td>
                                        <td scope="col" class="alineartabla">17</td>
                                        <td scope="col" class="alineartabla">18</td>
                                        <td scope="col" class="alineartabla">Meta</td>
                                        </thead>
                                        <tbody id="lenado">
                                            <tr class="alineartabla rowtablaprsdia">
                                                <td colspan="11" class="alineartabla tamanoparesxhr espaciado-sm">Pares x Hora: <%=arrmeta.get(0).getCantxhr()%></td>   
                                                <td class="fondocolnaranja tamanoparesxhr"><%=arrmeta.get(0).getCantxdia()%></td>
                                            </tr>
                                            <tr class="alineartabla rowtabla">
                                                <%
//                                      Ciclo para el llenado de las lineas       
//                                      Se verifica la cantidad con la cantidad de prs esimados por dia y hr
                                                    for (int z = 0; z < arrprs.length; z++) {
                                                        if (arrprs[z] >= arrmeta.get(0).getCantxhr()) {
                                                            out.print("<td class=fondocolverde>" + arrprs[z] + "</td>");
                                                        } else {
                                                            out.print("<td class=fondocolrojo>" + arrprs[z] + "</td>");
                                                        }
                                                        total += arrprs[z];
                                                    }
                                                    if (total >= arrmeta.get(0).getCantxdia()) {
                                                        out.print("<td class=fondocolverde>" + total + "</td>");
                                                    } else {
                                                        out.print("<td class=fondocolrojo>" + total + "</td>");
                                                    }
                                                %>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div><br>
                            </div>
                        </div>
                    </div>    
                </div>   
            </div>
            <%
                    //System.out.println("tamaño meta " + arrmeta.size());
                }

                //List<metadep> arrmeta = a.getmetas(c, arrpant.get(i).getNombre());
                //System.out.println("tamaño meta " + arrmeta.size());
            %>

            <%                    }
                }
            %>

        </div>
    </body>
</html>
<%    } catch (Exception e) {
    }
%>
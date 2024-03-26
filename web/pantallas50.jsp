<%-- 
    Document   : Log
    Author     : mich
--%>
<%@page import="Modelo.formateodedatos"%>
<%@page import="Modelo.Falla"%>
<%@page import="Modelo.Anuncio"%>
<%@page import="Modelo.Tiempospantalla"%>
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
    HttpSession sesion = request.getSession(false);
    try {
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
// Entra solo si no hay una cokie de pantallas        
        if (band) {
            //System.out.println("no avance");
            Avances a = new Avances();
// Condicional por si no elige departamento no abra n veces la conexion a la bd
// Ademas que asigna de una ves la conexion a la cokie
            if (c == null) {
                a.abrir();
                c = a.getConexion();
                session.setAttribute("con", c);
            }
            sqlpantallas s = new sqlpantallas();
            arr = s.getpantalla(c);
        }
        int anuncio = Integer.parseInt(sesion.getAttribute("anuncio").toString());// forzar el catch para asigna el primer valor
        int nAnuncio = Integer.parseInt(sesion.getAttribute("nanuncios").toString());// forzar el catch para asigna el primer valor
        //variable para control de como se presentan los departamentos en forma de carrusel
        int carrusel = Integer.parseInt(sesion.getAttribute("carrusel").toString());// forzar el catch para asigna el primer valor
        System.out.println("anuncios " + anuncio + " " + c);
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
// Recarga para ejecucion inmediata        
            function reload() {
                window.location.reload();
            }
        </script>
    </head>
    <body class="" >
        <%
//  Condicional solo para mostrar y no mostrar el menu de los avances, logo y departamentos
//  fuera de los resultados de los avances, ocultandolos solo si hay anuncios o fallas
// No funciono porque en las pantallas no funcionaba de manera adecuadas
//            sqlpantallas a = new sqlpantallas();
//            Tiempospantalla tp = new Tiempospantalla();
//            tp = a.getiempos(c);
            //           if (anuncio <= tp.getPantsup() || anuncio == 0 || c == null) {
        %>
        <!--Div que incluye el logo y los departamentos disponibles a seleccionar-->
        <div class="col-md-12">
            <div align="left" class="col-lg-2"><a href="index.jsp"><img src="images/AF.png" width="250px" height="180px" class="img-responsive"/></a></div>
            <div align="right" class="col-lg-10 combos" >
                <select id="pant" name="pant">
                    <%  for (int i = 0; i < arr.size(); i++) {
                            out.println("<option selected value=" + arr.get(i).getPantalla() + "><h2 class=combos>" + arr.get(i).getNombre() + "</h2></option>");
                        }
                    %>
                </select>
            </div>
        </div>
        <!--Div que incluye la fecha actual y el boton para la seleccion de departamento-->
        <div class="col-md-12">
            <div align="left" class="col-lg-4" style="">
                <h3 class="encabezado">Fecha: <%=sdf.format(date)%></h3>
            </div>
            <div align="right" class="col-lg-8" style="">
                <button class="btn-success btn"   onclick="creacockie()">
                    <p class="combos">Iniciar</p>
                </button>
            </div>
        </div>
        <%
            //           }
//  Fin de condicional para despliegue de menu para avances
        %>
        <div align="center" style="padding-top: 1%">

            <%    for (int i = 0; i < galleta.length; i++) {
                    System.out.println("--------------------" + galleta[i].getName());
//                  Entra solo si la cokie es la indicada, sino no hace toda esta parte de carga                    
                    if (galleta[i].getName().equals("pantalla")) {
                        out.println("<script type=text/javascript>setTimeout(reload, 60000);</script>");
                        //Ya no se utiliza el ciclo para recorrer todo lo que habia en la pantalla ya que serán independientes
                        sqlpantallas a = new sqlpantallas();
                        Tiempospantalla tp = new Tiempospantalla();
                        tp = a.getiempos(c);
                        System.out.println("Anuncio " + anuncio + " " + tp.getPantsup() + " carrusel " + carrusel);
                        if (anuncio >= tp.getPantmin() && anuncio <= tp.getPantsup()) {// Despliegue de avances
                            ArrayList<pantalla> arrpant;
                            List<metadep> arrmeta = new ArrayList<metadep>();
                            ArrayList<pantalla> arrpares;
                            Funciones f = new Funciones();
                            int total = 0;
                            //Variable para hacer uso de inyeccion y los demas departamentos, ya que se 
                            //se utiliza una ves para el despliegue del departamento
                            int carraux = 0;
                            if (carrusel == 0) {
                                //Datos predeterminados para el departamento de inyeccion ya que como no esta conformado de la misma manera
                                //es necesario que sea independiente con sus propias reglas
                                arrpant = new ArrayList<pantalla>();
                                pantalla p = new pantalla();
                                p.setDepa("INYECCION");
                                arrpant.add(p);
                                metadep met = new metadep();
                                met.setCantxdia(1120);
                                met.setCantxhr(120);
                                arrmeta.add(met);
                                arrpares = a.getprsxhrinyeccion(c, sdf.format(date));
                                carraux = carrusel;
                            } else {
                                //Valor -1 a carrusel ya que como se utilizo el primer valor de cero para inyeccion es necesario
                                //volver  tomar el valor de ese indice
                                carraux = carrusel - 1;
                                //Obtiene los departamentos de la pantalla seleccionada de los cuales se usará su nombre y tipo de orden
                                arrpant = a.getpantallaindividual(c, Integer.parseInt(galleta[i].getValue()));
                                //   for (int j = 0; j < arrpant.size(); j++) {
//                          Clase para funciones extra, para formatear u obtener datos mas concretos     
//                          Arraylist que obtiene los datos de pares de cada departamento  
                                arrmeta = a.getmetas(c, f.getndepa(arrpant.get(carrusel - 1).getDepa()));
//                          Almacenar en variables los datos de los arrays para que no sea tan grande la instruccion de el metodo a llamar  
                                int pantallaarr = Integer.parseInt(galleta[i].getValue());
                                int orders = arrpant.get(carrusel - 1).getOrders();
                                String departamento = arrpant.get(carrusel - 1).getDepa();

//                          Obtener los pares x hr mediante un query a la base de datos  
                                arrpares = a.getprsxhr(c, pantallaarr, sdf.format(date), departamento, orders);
                                //ArrayList<pantalla> arrpares = a.getprsxhr(c, pantallaarr, "04/11/2023", departamento, orders);
//                          Esta funcion formatea el numero de renglones a solo un renglon de tipo array normal  

                                //System.out.println("aaaaaaa "+arrpares.size()+" bbbbbbb "+arrprs.length);
                            }
                            int[] arrprs = f.getprsxdepa(arrpares);
            %>
            <div class="container-fluid" align="center">
                <div class=" " >
                    <div class="row" >
                        <div class="col-lg-12" >
                            <div >
                                <div class="table-responsive" >
                                    <h1 class="encabezado fondoencdep" ><%=arrpant.get(carraux).getDepa().toUpperCase()%></h1>
                                    <table class="table table-striped table-hover col-lg-12" >
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
                //}// for de pantallas
                //carrusel++;
//Control del carrusel para los avances de prod de planta e inyeccion
                carrusel = (carrusel >= 2) ? 0 : carrusel + 1;
                anuncio++;
                System.out.println("Asignacion de anuncio " + anuncio);
                sesion.setAttribute("anuncio", anuncio);
                sesion.setAttribute("carrusel", carrusel);
// DEspliegue de anuncios
            } else if (anuncio >= tp.getAnunmin() && anuncio <= tp.getAnunsup()) {
                ArrayList<Anuncio> arranuncio = a.getanuncios(c, Integer.parseInt(galleta[i].getValue()), sdf.format(date));
                if (arranuncio.isEmpty()) {
                    anuncio = tp.getAnunsup();
                    carrusel = 0;
                    sesion.setAttribute("anuncio", anuncio + 1);
                    sesion.setAttribute("carrusel", 0);
                    response.sendRedirect("pantallas50.jsp");
                } else {
//Verifica el indice del anuncio y desplegar mas de uno activo en distinto ciclo
//pero despliega mas de uno sin tener que estar moviendo estatus
                    if (nAnuncio < arranuncio.size()) {
            %>
            <div class="container-fluid" >
                <div class="col-lg-12">
                    <label class="letraanuncio"><%=arranuncio.get(nAnuncio).getCuerpo().toUpperCase()%></label>
                </div>
                <div class=" col-lg-12 alinearimagen">
                    <img src="<%=arranuncio.get(nAnuncio).getImagen()%>" class="img-responsive maxtamanoimagenanuncio" >
                </div>
            </div>
            <%
                nAnuncio++;
            } else {
                nAnuncio = 0;
            %>
            <div class="container-fluid" >
                <div class="col-lg-12">
                    <label class="letraanuncio"><%=arranuncio.get(nAnuncio).getCuerpo().toUpperCase()%></label>
                </div>
                <div class=" col-lg-12 alinearimagen">
                    <img src="<%=arranuncio.get(nAnuncio).getImagen()%>" class="img-responsive maxtamanoimagenanuncio" >
                </div>
            </div>
            <%
                    }
                    anuncio++;
                    sesion.setAttribute("anuncio", anuncio);
                    sesion.setAttribute("nanuncios", nAnuncio);
                }

            } else if (anuncio >= tp.getFallamin() && anuncio <= tp.getFallasup()) {
                ArrayList<Falla> arrfalla = a.getfallas(c, Integer.parseInt(galleta[i].getValue()));
                if (arrfalla.isEmpty()) {
                    anuncio = 0;
                    carrusel = 0;
                    sesion.setAttribute("anuncio", 0);
                    sesion.setAttribute("carrusel", 0);
                    response.sendRedirect("pantallas50.jsp");
                } else {
            %>
            <div class="container-fluid">
                <div class="letrafallaenc">
                    <label class="letrafallaenc2"><%=arrfalla.get(0).getObservaciones()%></label>
                </div>
                <div class="row">
                    <% formateodedatos format = new formateodedatos();
                        if (format.getfalla1imagen(arrfalla)) {
                            out.print("<div class=col-md-12 letrafallas>"
                                    + "<label>" + arrfalla.get(0).getDescimag1() + "</label>"
                                    + "<a href=\"" + arrfalla.get(0).getImagen1() + "\"><img src=" + arrfalla.get(0).getImagen1() + " class=\"img-responsive imgfijopantalla-lg\"></a>"
                                    + "</div>");
                        } else if (format.getfalla2imagen(arrfalla)) {
                            out.print("<div class=col-md-6 letrafallas>"
                                    + "<label>" + arrfalla.get(0).getDescimag1() + "</label>"
                                    + "<a href=\"" + arrfalla.get(0).getImagen1() + "\"><img src=" + arrfalla.get(0).getImagen1() + " class=\"img-responsive imgfijopantalla-md\"></a>"
                                    + "</div>");
                            out.print("<div class=col-md-6 letrafallas>"
                                    + "<label>" + arrfalla.get(0).getDescimag2() + "</label>"
                                    + "<a href=\"" + arrfalla.get(0).getImagen2() + "\"><img src=" + arrfalla.get(0).getImagen2() + " class=\"img-responsive imgfijopantalla-md\"></a>"
                                    + "</div>");
                        } else {
                    %>
                    <div class="col-md-4 letrafallas">
                        <label><%=arrfalla.get(0).getDescimag1()%></label>
                        <a href="<%=arrfalla.get(0).getImagen1()%>"><img src="<%=arrfalla.get(0).getImagen1()%>" class="img-responsive imgfijopantalla"></a>
                    </div>
                    <div class="col-md-4 letrafallas">
                        <label><%=arrfalla.get(0).getDescimag2()%></label>
                        <a href="<%=arrfalla.get(0).getImagen2()%>"><img src="<%=arrfalla.get(0).getImagen2()%>" class="img-responsive imgfijopantalla" ></a>
                    </div>
                    <div class="col-md-4 letrafallas">
                        <label><%=arrfalla.get(0).getDescimag3()%></label>
                        <a href="<%=arrfalla.get(0).getImagen3()%>"><img src="<%=arrfalla.get(0).getImagen3()%>" class="img-responsive imgfijopantalla" </a>
                    </div>
                    <div class="col-md-4 letrafallas">
                        <label><%=arrfalla.get(0).getDescimag4()%></label>
                        <a href="<%=arrfalla.get(0).getImagen4()%>"><img src="<%=arrfalla.get(0).getImagen4()%>" class="img-responsive imgfijopantalla"></a>
                    </div>
                    <div class="col-md-4 letrafallas">
                        <label><%=arrfalla.get(0).getDescimag5()%></label>
                        <a href="<%=arrfalla.get(0).getImagen5()%>"><img src="<%=arrfalla.get(0).getImagen5()%>" class="img-responsive imgfijopantalla"></a>
                    </div>
                    <div class="col-md-4 letrafallas">
                        <label><%=arrfalla.get(0).getDescimag6()%></label>
                        <a href="<%=arrfalla.get(0).getImagen6()%>"><img src="<%=arrfalla.get(0).getImagen6()%>" class="img-responsive imgfijopantalla"></a>
                    </div>
                </div>
            </div>
            <%          }
                        anuncio++;
                        sesion.setAttribute("anuncio", anuncio);
                    }
                } else if (anuncio > tp.getFallasup()) {
                    anuncio = 0;
                    carrusel = 0;
                    sesion.setAttribute("anuncio", 0);
                    sesion.setAttribute("carrusel", 0);
                    response.sendRedirect("pantallas50.jsp");
                }
                //List<metadep> arrmeta = a.getmetas(c, arrpant.get(i).getNombre());
                //System.out.println("tamaño meta " + arrmeta.size());
            %>
            <%      }
                }
            %>
        </div>
    </body>
    <%    } catch (Exception e) {
            System.out.println("Excepcion " + e.getCause() + " " + e.getMessage());
            sesion.setAttribute("anuncio", 0);
            sesion.setAttribute("nanuncios", 0);
            sesion.setAttribute("carrusel", 0);
            //response.sendRedirect("pantallas65.jsp");
        }

    %>
</html>

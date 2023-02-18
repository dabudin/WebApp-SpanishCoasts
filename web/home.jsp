<%@page import="entities.Usuario"%>
<%@page import="entities.Playa"%>
<%@page import="entities.Municipio"%>
<%@page import="entities.Provincia"%>
<%@page import="java.util.List"%>
<%@page import="entities.Ccaa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">

<head>
  <title>WEB Playas</title>
  <!-- Required meta tags -->
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous" />
  <!-- Mi CSS -->
  <link rel="stylesheet" href="css/mycss.css" />
  <!-- Font Awesome -->
  <link rel="stylesheet" href="//use.fontawesome.com/releases/v5.15.2/css/all.css">
</head>
<%
    List<Ccaa> ccaas = (List<Ccaa>) session.getAttribute("ccaas");
    Ccaa ccaasel = (Ccaa) session.getAttribute("ccaasel");
    List<Provincia> provincias = (List<Provincia>) session.getAttribute("provincias");
    Provincia provinciasel = (Provincia) session.getAttribute("provinciasel");
    List<Municipio> municipios = (List<Municipio>) session.getAttribute("municipios");
    Municipio municipiosel = (Municipio) session.getAttribute("municipiosel");
    List<Playa> playas = (List<Playa>) session.getAttribute("playas");
    Usuario usuario = (Usuario) session.getAttribute("usuario");
%>
<body>

  <div class="container mishadow px-0 pb-3">

    <!-- NAVBAR -->
    <nav class="navbar navbar-expand-lg bg-light navbar-light rounded pb-3 mb-4">

      <!-- LOGO -->
      <img src="img/logo.png" alt="Logo playa" />
      <!-- LOGO -->

      <button class="navbar-toggler d-lg-none my-3" type="button" data-toggle="collapse" data-target="#collapsibleNavId"
        aria-controls="collapsibleNavId" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="collapsibleNavId">    
        <div class="row mx-0 ml-auto mt-4 mb-3">

          <!-- LOGIN / LOGOUT -->
          <div class="col-12 px-3 mb-4 mt-0 text-left text-lg-right">

            <% if (usuario == null) { %>
            
            <button type="button" class="btn btn-danger px-3"
                    data-toggle="modal" data-target="#modallogin">
              Login
            </button>
            
            <% } else { %>

            <p class="text-primary d-inline mx-3 p-0"> Welcome, <%=usuario.getNick() %></p>
            <a class="btn btn-success px-3" href="Controller?op=logout" role="button">Logout</a>
            
            <% } %>

          </div>
          <!-- LOGIN / LOGOUT -->


          <!-- SELECTS -->
          <div class="col-12 px-0">
            <div class="form-group row m-0 d-flex justify-content-end">         

              <form class="col-12 col-lg-3"
                  action="Controller?op=getprovinciasbyccaa" method="POST">
                <select class="form-control" 
                        id="ccaa" name="ccaa" onchange="this.form.submit()">
                    
                  <% if (ccaasel == null) { %>
                  
                  <option value="0"> Seleccione CCAA </option>
                  
                  <% } else { %>
                  
                  <option value="<%=ccaasel.getId() %>"><%=ccaasel.getNombre() %></option>
                  
                  <% } %>

                  <% for (Ccaa ccaa : ccaas) { %>
                  
                  <option value="<%=ccaa.getId() %>"><%=ccaa.getNombre() %></option>
                  
                  <% } %>

                </select>
              </form>

              <form class="col-12 col-lg-3"
                  action="Controller?op=getmunicipiosbyprovincia" method="POST">
                <select class="form-control mt-4 mt-lg-0" 
                        id="provincia" name="provincia" onchange="this.form.submit()">
                    
                  <% if (provinciasel == null) { %>
                  
                  <option value="0"> Seleccione Provincia </option>
                  
                  <% } else { %>
                  
                  <option value="<%=provinciasel.getId() %>"><%=provinciasel.getNombre() %></option>
                  
                  <% } %>

                  <%  if (provincias != null) {
                        for (Provincia provincia : provincias) { %>
                  
                  <option value="<%=provincia.getId() %>"><%=provincia.getNombre() %></option>
                  
                  <% }} %>

                </select>
              </form>

              <form class="col-12 col-lg-3"
                  action="Controller?op=getplayasbymunicipio" method="POST">
                <select class="form-control mt-4 mt-lg-0" 
                        id="municipio" name="municipio" onchange="this.form.submit()">
                  
                  <% if (municipiosel == null) { %>
                  
                  <option value="0"> Seleccione Municipio </option>
                  
                  <% } else { %>
                  
                  <option value="<%=municipiosel.getId() %>"><%=municipiosel.getNombre() %></option>
                  
                  <% } %>

                  <%  if (municipios != null) {
                        for (Municipio municipio : municipios) { %>
                  
                  <option value="<%=municipio.getId() %>"><%=municipio.getNombre() %></option>
                  
                  <% }} %>

                </select>
              </form>

            </div>      
          </div>
          <!-- SELECTS -->


        </div>
      </div>
    </nav>
    <!-- NAVBAR -->


    <!-- CARDS PLAYAS -->
    <div class="row mx-0">

      <%  if (playas != null) {
          for (Playa playa : playas) { %>
        
      <div class="col-12 col-md-6 px-3 mb-4">
        <div class="card">

            <img src="img/<%=playa.getId() %>_<%=playa.getImagesList().get(0).getId() %>.jpg" 
                 class="card-img-top" alt="">

          <div class="card-body">

            <h5 class="card-title"><%=playa.getNombre() %></h5>
            <p class="card-text mb-4"><%=playa.getDescripcion() %></p>

            <% if (usuario != null) { %>
            
            <div class="d-flex justify-content-between">
                    
              <a role="button" data-toggle="modal" data-target="#modalinfo"
                 data-idplaya="<%=playa.getId() %>" 
                 data-nombreplaya="<%=playa.getNombre() %>" >
                <i class="fas fa-info-circle"></i>
              </a>
                    
              <a href="Controller?op=detalle&playa=<%=playa.getId() %>" >
                <i class="fas fa-star-half-alt"></i>
              </a>

            </div>
            
            <% } %>

          </div>
        </div>
      </div>
      
      <% }} %>


    </div>
    <!-- CARDS PLAYAS -->


  </div>


  <!-- MODAL LOGIN -->
  <div id="modallogin" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <div class="modal-content">

        <div class="modal-header">
          <h5 class="modal-title">Login / Register</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>

        <!-- Formulario para loguearse (a través del controller) -->
        <form action="Controller?op=login" method="POST">

          <div class="modal-body">
            <div class="form-group">

              <label for="inputdni" class="col-form-label">DNI</label>
              <input type="text" class="form-control" id="inputdni" name="dni" 
                     placeholder="Escriba su DNI">

              <label for="inputnombre" class="col-form-label">Nombre</label>
              <input type="text" class="form-control" id="inputnombre" name="nombre" 
                     placeholder="Escriba su nombre"></input>

            </div>
          </div>

          <div class="modal-footer">
            
            <button type="button" class="btn btn-secondary" data-dismiss="modal">
                Cancelar
            </button>
            <button class="btn btn-primary" type="submit">
                Login / Register
            </button>
                
          </div>

        </form>

      </div>
    </div>
  </div>
  <!-- MODAL LOGIN -->


  <!-- MODAL INFO -->
  <div id="modalinfo" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <div class="modal-content">

        <div class="modal-header bg-primary">
          <h5 class="modal-title text-white ml-auto">Calificación de la playa</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>

        <div class="modal-body">

          <!-- Introducir aquí tabla de votaciones mediante Ajax -->

        </div>

        <div class="modal-footer">
          <button type="button" class="btn btn-primary" data-dismiss="modal">Aceptar</button>
        </div>

      </div>
    </div>
  </div>
  <!-- MODAL LOGIN -->


  <!-- Optional JavaScript -->
  <!-- jQuery first, then Popper.js, then Bootstrap JS -->
  <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
    integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
    crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
    integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
    crossorigin="anonymous"></script>
  <!-- Mi JavaScript -->
  <script src="js/myjs.js"></script>
</body>

</html>

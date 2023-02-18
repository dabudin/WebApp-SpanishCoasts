<%@page import="entities.Images"%>
<%@page import="entities.Playa"%>
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
</head>
<%
    Playa playa = (Playa) request.getAttribute("playa");
    int puntuacionmedia = (int) request.getAttribute("puntuacionmedia");
%>
<body>

  <div class="container mishadow pb-3 px-4" style="background-color: #f8f9fa;">

    <!-- CARD DETALLE PLAYA -->
    <div class="card rounded mb-2">

      <div class="card-body midetalle rounded">

        <div class="text-center mb-1 p-5">
            
          <h1 class="card-title fs-60"><%=playa.getNombre() %></h1>
          
          <span>
              
              <img class="mi-w mb-4" src="img/ccaa_<%=playa.getMunicipio().getProvincia().getCcaa().getId() %>.png"
                   alt="Bandera de la Comunidad de <%=playa.getMunicipio().getProvincia().getCcaa().getNombre() %>" />
              
              <h1 class="card-text d-inline fs-60">   
              <%=playa.getMunicipio().getNombre() %>
              (<%=playa.getMunicipio().getProvincia().getNombre() %>)
              </h1>
              
              <img class="mi-w mb-4" src="img/ccaa_<%=playa.getMunicipio().getProvincia().getCcaa().getId() %>.png"
                   alt="Bandera de la Comunidad de <%=playa.getMunicipio().getProvincia().getCcaa().getNombre() %>" />
              
          </span>
          
          <p class="mb-5"><%=playa.getDescripcion() %></p>
          
          <img src="img/ic_<%=puntuacionmedia %>.png" alt="Puntuacion media" />

        </div>

      </div>
    </div>
    <!-- CARD DETALLE PLAYA -->


    <!-- CAROUSEL IMAGENES PLAYA -->
    <div id="carouselplayas" class="carousel slide" data-ride="carousel">
      <div class="carousel-inner">

        <% 
            for (Images image : playa.getImagesList() ) { 
            if ( image.equals(playa.getImagesList().get(0)) ) {
        %>
          
        <div class="carousel-item active">
          <img src="img_playas/<%=image.getPlaya().getId() %>_<%=image.getId() %>.jpg"
               class="d-block w-100" alt="">
        </div>
        
        <% } else { %>

        <div class="carousel-item">
          <img src="img_playas/<%=image.getPlaya().getId() %>_<%=image.getId() %>.jpg"
               class="d-block w-100" alt="">
        </div>
        
        <% }} %>

      </div>
        
      <a class="carousel-control-prev" href="#carouselplayas" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
      </a>
      <a class="carousel-control-next" href="#carouselplayas" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
      </a>
    </div>
    <!-- CAROUSEL IMAGENES PLAYA -->


    <!-- ICONOS CALIFICAR PLAYA -->
    <div class="caritas mt-2 pl-1 d-flex justify-content-center">

      <a href="Controller?op=calificarplaya&puntos=1&playa=<%=playa.getId() %>">
        <img class="pr-3" src="img/ic_1.png" Alt="Carita de 1 punto"/>
      </a>

      <a href="Controller?op=calificarplaya&puntos=2&playa=<%=playa.getId() %>">
        <img class="pr-3" src="img/ic_2.png" Alt="Carita de 2 puntos"/>
      </a>

      <a href="Controller?op=calificarplaya&puntos=3&playa=<%=playa.getId() %>">
        <img class="pr-3" src="img/ic_3.png" Alt="Carita de 3 puntos"/>
      </a>

      <a href="Controller?op=calificarplaya&puntos=4&playa=<%=playa.getId() %>">
        <img class="pr-3" src="img/ic_4.png" Alt="Carita de 4 puntos"/>
      </a>

      <a href="Controller?op=calificarplaya&puntos=5&playa=<%=playa.getId() %>">
        <img class="pr-3" src="img/ic_5.png" Alt="Carita de 5 puntos"/>
      </a>

    </div>
    <!-- ICONOS CALIFICAR PLAYA -->

  </div>


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

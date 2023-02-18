<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String nombreplaya = (String) request.getAttribute("nombreplaya");
    List<Long> calificaciones = (List<Long>) request.getAttribute("calificaciones");
%>
      
<table class="table table-striped text-primary">
    
    <thead>
      <tr>
          <th scope="col" colspan="2" class="text-center">
              <h2><%=nombreplaya %></h2>
          </th>
      </tr>
    </thead>
    
    <tbody>
        
        <% for (int i=0; i<5; i++) { %>
        
      <tr>
        <th scope="row">
            <img src="img/ic_<%=i+1 %>.png" alt="Carita de <%=i+1 %> puntos" 
                 style="width: 60px;"/>
        </th>
        <td><%=calificaciones.get(i).toString() %></td>
      </tr>
      
      <% } %>
      
    </tbody>
    
</table>  
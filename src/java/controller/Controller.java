/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entities.Ccaa;
import entities.Municipio;
import entities.Playa;
import entities.Provincia;
import entities.Punto;
import entities.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.NoResultException;
import javax.persistence.Query;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.JPAUtil;

/**
 *
 * @author Lenovo
 */
@WebServlet(name = "Controller", urlPatterns = {"/Controller"})
public class Controller extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Controller</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Controller at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String op = request.getParameter("op"); 
        RequestDispatcher dispatcher;
        
        //Creamos el singleton "Entity Manager"
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        Query q;

        if (op.equals("inicio")) {

            q = em.createNamedQuery("Ccaa.findAll");
            List<Ccaa> ccaas = (List<Ccaa>) q.getResultList();
            session.setAttribute("ccaas", ccaas);
            
            session.removeAttribute("ccaasel");
            session.removeAttribute("provinciasel");
            session.removeAttribute("municipiosel");
            session.removeAttribute("playas");
            
            //Refrescamos la vista (la página) con los nuevos datos de la sesión
            dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
            
        } else if (op.equals("getprovinciasbyccaa")) {
            
            int idccaa = Integer.valueOf(request.getParameter("ccaa"));
            q = em.createNamedQuery("Ccaa.findById");
            q.setParameter("id", idccaa); 
            Ccaa ccaasel = (Ccaa) q.getSingleResult();
            
            List<Provincia> provincias = ccaasel.getProvinciaList();
            session.setAttribute("provincias", provincias);
            session.setAttribute("ccaasel", ccaasel);
            
            session.removeAttribute("municipios");
            session.removeAttribute("provinciasel");
            session.removeAttribute("municipiosel");
            
            //Refrescamos la vista (la página) con los nuevos datos de la sesión
            dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
            
        } else if (op.equals("getmunicipiosbyprovincia")) {
            
            int idprovincia = Integer.valueOf(request.getParameter("provincia"));
            q = em.createNamedQuery("Provincia.findById");
            q.setParameter("id", idprovincia); 
            Provincia provinciasel = (Provincia) q.getSingleResult();
            
            List<Municipio> municipios = provinciasel.getMunicipioList();
            session.setAttribute("municipios", municipios);
            session.setAttribute("provinciasel", provinciasel);
            
            session.removeAttribute("municipiosel");
            
            //Refrescamos la vista (la página) con los nuevos datos de la sesión
            dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
            
        } else if (op.equals("getplayasbymunicipio")) {
            
            int idmunicipio = Integer.valueOf(request.getParameter("municipio"));
            q = em.createNamedQuery("Municipio.findById");
            q.setParameter("id", idmunicipio); 
            Municipio municipiosel = (Municipio) q.getSingleResult();
            List<Playa> playas = municipiosel.getPlayaList();
            
            session.setAttribute("playas", playas);
            session.setAttribute("municipiosel", municipiosel);
            
            //Refrescamos la vista (la página) con los nuevos datos de la sesión
            dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
            
        } else if(op.equals("login")) {
            
            String dni = request.getParameter("dni");
            String nombre = request.getParameter("nombre");
            Short id;
            
            try {
                id = Short.valueOf(dni);
            } catch (NumberFormatException e) {
                id = -1;
            }
            
            if ( (id != -1) && !(nombre.equals("")) ) {
                
                q = em.createQuery("SELECT u FROM Usuario u "
                    + "WHERE u.id = :id AND u.nick = :nick");
                q.setParameter("id", id);
                q.setParameter("nick", nombre);
                
                Usuario usuario;
                
                try {
                    usuario = (Usuario) q.getSingleResult();
                } catch (NoResultException e) {
                    usuario = null;
                }
                
                if (usuario == null) {
                    
                    EntityTransaction tr = em.getTransaction();
                    tr.begin();
                    usuario = new Usuario(id);
                    usuario.setNick(nombre);
                    em.persist(usuario);
                    tr.commit();
                    
                    q = em.createQuery("SELECT u.id FROM Usuario u "
                        + "WHERE u.nick like :nick");
                    q.setParameter("nick", nombre);
                    List<Short> ids = (List<Short>) q.getResultList();
                
                    if (!ids.contains(id)) {

                        Short idmax = 0;
                        for (Short id1 : ids) {
                            if (id1 > idmax) 
                                idmax = id1;
                        }

                        usuario.setId(idmax);
                    }
                }
                
                session.setAttribute("usuario", usuario);
            }
           
            //Refrescamos la vista (la página) con los nuevos datos de la sesión
            dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
            
        } else if (op.equals("logout")) {
            
            session.removeAttribute("usuario");
            
            //Refrescamos la vista (la página) con los nuevos datos de la sesión
            dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
            
        } else if (op.equals("info")) {
            
            Integer idplaya = Integer.valueOf(request.getParameter("idplaya"));
            String nombreplaya = request.getParameter("nombreplaya");
            List<Long> calificaciones = new ArrayList();
            
            for (Short i=1; i<=5; i++) {
                
                q = em.createQuery("SELECT COUNT(p) FROM Punto p "
                        + "WHERE p.playa.id = :id AND p.puntos = :puntos");
                q.setParameter("id", idplaya);
                q.setParameter("puntos", i);
                
                Long calificacion = (Long) q.getSingleResult();  
                calificaciones.add(calificacion);
                
            }
            
            request.setAttribute("nombreplaya", nombreplaya);
            request.setAttribute("calificaciones", calificaciones);
            
            //Refrescamos la vista (la página) con los nuevos datos de la sesión
            dispatcher = request.getRequestDispatcher("info.jsp");
            dispatcher.forward(request, response);
            
        } else if (op.equals("detalle") || op.equals("calificarplaya")) {
            
            Integer idplaya = Integer.valueOf(request.getParameter("playa"));
            Playa playa = em.find(Playa.class, idplaya);

            
            if (op.equals("calificarplaya")) {

                Usuario usuario = (Usuario) session.getAttribute("usuario");
                Short puntos = Short.valueOf(request.getParameter("puntos"));
                
                q = em.createQuery("SELECT p FROM Punto p WHERE p.playa = :playa "
                        + "AND p.usuario = :usuario");
                q.setParameter("playa", playa);
                q.setParameter("usuario", usuario);
                
                Punto punto;
                
                try {
                    punto = (Punto) q.getSingleResult();
                } catch (NoResultException e) {
                    punto = null;
                }
                
                EntityTransaction t = em.getTransaction();
                
                if (punto==null) {
                    
                    t.begin();
                    punto = new Punto();
                    punto.setPlaya(playa);
                    punto.setUsuario(usuario);
                    punto.setPuntos(puntos);
                    em.persist(punto);
                    t.commit();
                    
                } else {

                    t.begin();
                    punto.setPuntos(puntos);
                    em.merge(punto);
                    t.commit();
                }
            }
            
            try {
                Thread.sleep(100);
                em.refresh(playa);
            } catch (InterruptedException ex) {
                Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
            }
           
            
            int nCalificaciones = playa.getPuntoList().size();
            Double nPuntos = 0.0;
            
            for (Punto punto : playa.getPuntoList()) {
                nPuntos += punto.getPuntos();
            }

            if (!Double.isNaN(nPuntos / nCalificaciones)) {
                
                int puntuacionmedia = (int) (nPuntos / nCalificaciones);
                request.setAttribute("puntuacionmedia", puntuacionmedia);
                
            } else {
                
                request.setAttribute("puntuacionmedia", 3);
                
            }
                    
            request.setAttribute("playa", playa);
            
            //Refrescamos la vista (la página) con los nuevos datos de la sesión
            dispatcher = request.getRequestDispatcher("detalle.jsp");
            dispatcher.forward(request, response);      
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

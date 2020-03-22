/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entities.Movie;
import entities.Person;
import entities.Rating;
import entities.Usuario;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import jpautil.JPAUtil;

/**
 *
 * @author diurno
 */
@WebServlet(name = "Controller", urlPatterns = {"/Controller"})
public class Controller extends HttpServlet {

    private EntityManager em;
    private Query q;
    private List<Person> personas;
    private List<Movie> peliculas;
    private List<Rating> puntos;
    private EntityTransaction t;
    private Usuario user;

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
        HttpSession session = request.getSession();
        RequestDispatcher dispatcher;
        String op = request.getParameter("op");
        em = JPAUtil.getEntityManagerFactory().createEntityManager();
        if (op.equals("inicio")) {
            q = em.createNamedQuery("Person.findAll");
            personas = q.getResultList();
            q = em.createNamedQuery("Movie.findAll");
            peliculas = q.getResultList();
            q = em.createNamedQuery("Rating.findAll");
            puntos = q.getResultList();
            session.setAttribute("personas", personas);
            session.setAttribute("peliculas", peliculas);
            session.setAttribute("puntos", puntos);
            session.setAttribute("ficha", "person");
            dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
        }else if (op.equals("personomovie")) {
            String ficha = request.getParameter("ficha");
            session.setAttribute("ficha", ficha);
            dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);

        }else if (op.equals("rating")) {
            String rating = request.getParameter(String.valueOf("rating"));
            String id = request.getParameter(String.valueOf("id"));
            Usuario user2 = Usuario.class.cast(session.getAttribute("usuario"));
           
            // creamos nuestro objeto Rating
            Rating ratingnew = new Rating();
            ratingnew.setPuntos(Short.parseShort(rating));
            ratingnew.setIdrating(Short.parseShort("1"));
            Person aux = em.find(Person.class, Integer.parseInt(id));
            
            ratingnew.setIdperson(aux);
            ratingnew.setDni(user2);
            t = em.getTransaction();
            t.begin();
            em.persist(ratingnew);
            t.commit();
            
            q = em.createNamedQuery("Rating.findAll");
            puntos = q.getResultList();
            session.setAttribute("puntos", puntos);
            
            dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
           
	} 
        else if (op.equals("login")) {
            String dni = (String) request.getParameter("dni");
            String nombre = (String) request.getParameter("nombre");
            if (nombre.isEmpty() || dni.isEmpty()){
                session.setAttribute("msg", "Ambos campos son obligatorios...");
            } else {
                user = em.find(Usuario.class, dni);
                if (user == null){
                    Usuario nuevoUsuario = new Usuario(dni);
                    nuevoUsuario.setNombre(nombre);
                    t = em.getTransaction();
                    t.begin();
                    em.persist(nuevoUsuario);
                    t.commit();
                    user = nuevoUsuario;
                }
                session.setAttribute("usuario", user);
            }
            dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
        }else if (op.equals("logout")) {
            session.removeAttribute("usuario");
            dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
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
        processRequest(request, response);
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
        processRequest(request, response);
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

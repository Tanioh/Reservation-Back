package com.reservation.backoffice.controller;

import com.reservation.backoffice.dao.ReservationDAO;
import com.reservation.backoffice.dao.ClientDAO;
import com.reservation.backoffice.dao.VoitureDAO;
import com.reservation.backoffice.model.Reservation;
import com.reservation.backoffice.model.Client;
import com.reservation.backoffice.model.Voiture;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

/**
 * Contrôleur BackOffice pour la gestion des réservations.
 * Utilise le pattern MVC avec jframework.
 * 
 * Routes :
 * - GET  /reservations          → Liste des réservations (avec filtres)
 * - GET  /reservations/new      → Formulaire de création
 * - POST /reservations/create   → Créer une réservation
 * - GET  /reservations/edit?id= → Formulaire de modification
 * - POST /reservations/update   → Mettre à jour une réservation
 * - POST /reservations/delete   → Supprimer une réservation
 * - POST /reservations/statut   → Changer le statut
 */
@WebServlet("/reservations/*")
public class ReservationController extends HttpServlet {

    private final ReservationDAO reservationDAO = new ReservationDAO();
    private final ClientDAO clientDAO = new ClientDAO();
    private final VoitureDAO voitureDAO = new VoitureDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String pathInfo = req.getPathInfo();
        if (pathInfo == null) pathInfo = "/";

        try {
            switch (pathInfo) {
                case "/":
                case "/list":
                    listReservations(req, resp);
                    break;
                case "/new":
                    showCreateForm(req, resp);
                    break;
                case "/edit":
                    showEditForm(req, resp);
                    break;
                case "/detail":
                    showDetail(req, resp);
                    break;
                default:
                    listReservations(req, resp);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Erreur base de données", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String pathInfo = req.getPathInfo();
        if (pathInfo == null) pathInfo = "/";

        try {
            switch (pathInfo) {
                case "/create":
                    createReservation(req, resp);
                    break;
                case "/update":
                    updateReservation(req, resp);
                    break;
                case "/delete":
                    deleteReservation(req, resp);
                    break;
                case "/statut":
                    changeStatut(req, resp);
                    break;
                default:
                    resp.sendRedirect(req.getContextPath() + "/reservations");
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Erreur base de données", e);
        }
    }

    /**
     * Liste des réservations avec filtre par date.
     */
    private void listReservations(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {

        // Récupérer les paramètres de filtre
        String dateDebutStr = req.getParameter("dateDebut");
        String dateFinStr = req.getParameter("dateFin");
        String statut = req.getParameter("statut");

        Date dateDebut = null;
        Date dateFin = null;

        if (dateDebutStr != null && !dateDebutStr.isEmpty()) {
            dateDebut = Date.valueOf(dateDebutStr);
        }
        if (dateFinStr != null && !dateFinStr.isEmpty()) {
            dateFin = Date.valueOf(dateFinStr);
        }

        List<Reservation> reservations = reservationDAO.findByFilter(dateDebut, dateFin, statut);

        req.setAttribute("reservations", reservations);
        req.setAttribute("dateDebut", dateDebutStr);
        req.setAttribute("dateFin", dateFinStr);
        req.setAttribute("statut", statut);
        req.getRequestDispatcher("/WEB-INF/views/reservation/list.jsp").forward(req, resp);
    }

    /**
     * Afficher le formulaire de création.
     */
    private void showCreateForm(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {

        List<Client> clients = clientDAO.findAll();
        List<Voiture> voitures = voitureDAO.findDisponibles();

        req.setAttribute("clients", clients);
        req.setAttribute("voitures", voitures);
        req.getRequestDispatcher("/WEB-INF/views/reservation/form.jsp").forward(req, resp);
    }

    /**
     * Afficher le formulaire de modification.
     */
    private void showEditForm(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        Reservation reservation = reservationDAO.findById(id);
        List<Client> clients = clientDAO.findAll();
        List<Voiture> voitures = voitureDAO.findAll();

        req.setAttribute("reservation", reservation);
        req.setAttribute("clients", clients);
        req.setAttribute("voitures", voitures);
        req.getRequestDispatcher("/WEB-INF/views/reservation/form.jsp").forward(req, resp);
    }

    /**
     * Afficher le détail d'une réservation.
     */
    private void showDetail(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        Reservation reservation = reservationDAO.findById(id);

        req.setAttribute("reservation", reservation);
        req.getRequestDispatcher("/WEB-INF/views/reservation/detail.jsp").forward(req, resp);
    }

    /**
     * Créer une nouvelle réservation.
     */
    private void createReservation(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, IOException {

        Reservation r = new Reservation();
        r.setIdClient(Integer.parseInt(req.getParameter("idClient")));
        r.setIdVoiture(Integer.parseInt(req.getParameter("idVoiture")));
        r.setDateDebut(Date.valueOf(req.getParameter("dateDebut")));
        r.setDateFin(Date.valueOf(req.getParameter("dateFin")));
        r.setMontantTotal(Double.parseDouble(req.getParameter("montantTotal")));
        r.setStatut(req.getParameter("statut"));
        r.setCommentaire(req.getParameter("commentaire"));

        reservationDAO.insert(r);
        resp.sendRedirect(req.getContextPath() + "/reservations");
    }

    /**
     * Mettre à jour une réservation existante.
     */
    private void updateReservation(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, IOException {

        Reservation r = new Reservation();
        r.setIdReservation(Integer.parseInt(req.getParameter("idReservation")));
        r.setIdClient(Integer.parseInt(req.getParameter("idClient")));
        r.setIdVoiture(Integer.parseInt(req.getParameter("idVoiture")));
        r.setDateDebut(Date.valueOf(req.getParameter("dateDebut")));
        r.setDateFin(Date.valueOf(req.getParameter("dateFin")));
        r.setMontantTotal(Double.parseDouble(req.getParameter("montantTotal")));
        r.setStatut(req.getParameter("statut"));
        r.setCommentaire(req.getParameter("commentaire"));

        reservationDAO.update(r);
        resp.sendRedirect(req.getContextPath() + "/reservations");
    }

    /**
     * Supprimer une réservation.
     */
    private void deleteReservation(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        reservationDAO.delete(id);
        resp.sendRedirect(req.getContextPath() + "/reservations");
    }

    /**
     * Changer le statut d'une réservation.
     */
    private void changeStatut(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        String statut = req.getParameter("statut");
        reservationDAO.updateStatut(id, statut);
        resp.sendRedirect(req.getContextPath() + "/reservations");
    }
}

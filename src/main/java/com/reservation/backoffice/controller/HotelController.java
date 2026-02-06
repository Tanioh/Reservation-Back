package com.reservation.backoffice.controller;

import com.reservation.backoffice.dao.HotelDAO;
import com.reservation.backoffice.model.Hotel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Contrôleur BackOffice pour la gestion des hôtels.
 */
@WebServlet("/hotels/*")
public class HotelController extends HttpServlet {

    private final HotelDAO hotelDAO = new HotelDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String pathInfo = req.getPathInfo();
        if (pathInfo == null) pathInfo = "/";

        try {
            switch (pathInfo) {
                case "/":
                case "/list":
                    listHotels(req, resp);
                    break;
                case "/new":
                    showCreateForm(req, resp);
                    break;
                case "/edit":
                    showEditForm(req, resp);
                    break;
                default:
                    listHotels(req, resp);
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
                    createHotel(req, resp);
                    break;
                case "/update":
                    updateHotel(req, resp);
                    break;
                case "/delete":
                    deleteHotel(req, resp);
                    break;
                default:
                    resp.sendRedirect(req.getContextPath() + "/hotels");
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Erreur base de données", e);
        }
    }

    private void listHotels(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {
        List<Hotel> hotels = hotelDAO.findAll();
        req.setAttribute("hotels", hotels);
        req.getRequestDispatcher("/WEB-INF/views/hotel/list.jsp").forward(req, resp);
    }

    private void showCreateForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/hotel/form.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Hotel hotel = hotelDAO.findById(id);
        req.setAttribute("hotel", hotel);
        req.getRequestDispatcher("/WEB-INF/views/hotel/form.jsp").forward(req, resp);
    }

    private void createHotel(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, IOException {
        Hotel h = new Hotel();
        h.setNom(req.getParameter("nom"));
        h.setAdresse(req.getParameter("adresse"));
        h.setVille(req.getParameter("ville"));
        h.setCodePostal(req.getParameter("codePostal"));
        h.setTelephone(req.getParameter("telephone"));
        h.setEmail(req.getParameter("email"));
        h.setNbEtoiles(Integer.parseInt(req.getParameter("nbEtoiles")));
        hotelDAO.insert(h);
        resp.sendRedirect(req.getContextPath() + "/hotels");
    }

    private void updateHotel(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, IOException {
        Hotel h = new Hotel();
        h.setIdHotel(Integer.parseInt(req.getParameter("idHotel")));
        h.setNom(req.getParameter("nom"));
        h.setAdresse(req.getParameter("adresse"));
        h.setVille(req.getParameter("ville"));
        h.setCodePostal(req.getParameter("codePostal"));
        h.setTelephone(req.getParameter("telephone"));
        h.setEmail(req.getParameter("email"));
        h.setNbEtoiles(Integer.parseInt(req.getParameter("nbEtoiles")));
        hotelDAO.update(h);
        resp.sendRedirect(req.getContextPath() + "/hotels");
    }

    private void deleteHotel(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        hotelDAO.delete(id);
        resp.sendRedirect(req.getContextPath() + "/hotels");
    }
}

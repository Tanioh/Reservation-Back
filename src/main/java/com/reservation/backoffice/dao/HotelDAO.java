package com.reservation.backoffice.dao;

import com.reservation.backoffice.config.DatabaseConfig;
import com.reservation.backoffice.model.Hotel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO pour la gestion des hôtels.
 */
public class HotelDAO {

    /**
     * Récupérer tous les hôtels.
     */
    public List<Hotel> findAll() throws SQLException {
        List<Hotel> hotels = new ArrayList<>();
        String sql = "SELECT * FROM hotel ORDER BY nom";

        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                hotels.add(mapResultSet(rs));
            }
        }
        return hotels;
    }

    /**
     * Trouver un hôtel par ID.
     */
    public Hotel findById(int id) throws SQLException {
        String sql = "SELECT * FROM hotel WHERE id_hotel = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSet(rs);
                }
            }
        }
        return null;
    }

    /**
     * Insérer un nouvel hôtel.
     */
    public Hotel insert(Hotel hotel) throws SQLException {
        String sql = "INSERT INTO hotel (nom, adresse, ville, code_postal, telephone, email, nb_etoiles) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?) RETURNING id_hotel";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, hotel.getNom());
            ps.setString(2, hotel.getAdresse());
            ps.setString(3, hotel.getVille());
            ps.setString(4, hotel.getCodePostal());
            ps.setString(5, hotel.getTelephone());
            ps.setString(6, hotel.getEmail());
            ps.setInt(7, hotel.getNbEtoiles());

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    hotel.setIdHotel(rs.getInt("id_hotel"));
                }
            }
        }
        return hotel;
    }

    /**
     * Mettre à jour un hôtel.
     */
    public void update(Hotel hotel) throws SQLException {
        String sql = "UPDATE hotel SET nom=?, adresse=?, ville=?, code_postal=?, "
                   + "telephone=?, email=?, nb_etoiles=? WHERE id_hotel=?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, hotel.getNom());
            ps.setString(2, hotel.getAdresse());
            ps.setString(3, hotel.getVille());
            ps.setString(4, hotel.getCodePostal());
            ps.setString(5, hotel.getTelephone());
            ps.setString(6, hotel.getEmail());
            ps.setInt(7, hotel.getNbEtoiles());
            ps.setInt(8, hotel.getIdHotel());
            ps.executeUpdate();
        }
    }

    /**
     * Supprimer un hôtel.
     */
    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM hotel WHERE id_hotel = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    private Hotel mapResultSet(ResultSet rs) throws SQLException {
        Hotel h = new Hotel();
        h.setIdHotel(rs.getInt("id_hotel"));
        h.setNom(rs.getString("nom"));
        h.setAdresse(rs.getString("adresse"));
        h.setVille(rs.getString("ville"));
        h.setCodePostal(rs.getString("code_postal"));
        h.setTelephone(rs.getString("telephone"));
        h.setEmail(rs.getString("email"));
        h.setNbEtoiles(rs.getInt("nb_etoiles"));
        h.setDateCreation(rs.getTimestamp("date_creation"));
        return h;
    }
}

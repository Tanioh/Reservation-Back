package com.reservation.backoffice.dao;

import com.reservation.backoffice.config.DatabaseConfig;
import com.reservation.backoffice.model.Client;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO pour la gestion des clients.
 */
public class ClientDAO {

    public List<Client> findAll() throws SQLException {
        List<Client> clients = new ArrayList<>();
        String sql = "SELECT * FROM client ORDER BY nom, prenom";

        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                clients.add(mapResultSet(rs));
            }
        }
        return clients;
    }

    public Client findById(int id) throws SQLException {
        String sql = "SELECT * FROM client WHERE id_client = ?";
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

    private Client mapResultSet(ResultSet rs) throws SQLException {
        Client c = new Client();
        c.setIdClient(rs.getInt("id_client"));
        c.setNom(rs.getString("nom"));
        c.setPrenom(rs.getString("prenom"));
        c.setEmail(rs.getString("email"));
        c.setTelephone(rs.getString("telephone"));
        c.setAdresse(rs.getString("adresse"));
        c.setDateInscription(rs.getTimestamp("date_inscription"));
        return c;
    }
}

package com.reservation.backoffice.dao;

import com.reservation.backoffice.config.DatabaseConfig;
import com.reservation.backoffice.model.Voiture;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO pour la gestion des voitures.
 */
public class VoitureDAO {

    public List<Voiture> findAll() throws SQLException {
        List<Voiture> voitures = new ArrayList<>();
        String sql = "SELECT v.*, h.nom AS nom_hotel FROM voiture v "
                   + "LEFT JOIN hotel h ON v.id_hotel = h.id_hotel "
                   + "ORDER BY v.marque, v.modele";

        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                voitures.add(mapResultSet(rs));
            }
        }
        return voitures;
    }

    public List<Voiture> findDisponibles() throws SQLException {
        List<Voiture> voitures = new ArrayList<>();
        String sql = "SELECT v.*, h.nom AS nom_hotel FROM voiture v "
                   + "LEFT JOIN hotel h ON v.id_hotel = h.id_hotel "
                   + "WHERE v.disponible = TRUE ORDER BY v.marque, v.modele";

        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                voitures.add(mapResultSet(rs));
            }
        }
        return voitures;
    }

    public Voiture findById(int id) throws SQLException {
        String sql = "SELECT v.*, h.nom AS nom_hotel FROM voiture v "
                   + "LEFT JOIN hotel h ON v.id_hotel = h.id_hotel "
                   + "WHERE v.id_voiture = ?";
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

    private Voiture mapResultSet(ResultSet rs) throws SQLException {
        Voiture v = new Voiture();
        v.setIdVoiture(rs.getInt("id_voiture"));
        v.setMarque(rs.getString("marque"));
        v.setModele(rs.getString("modele"));
        v.setImmatriculation(rs.getString("immatriculation"));
        v.setCouleur(rs.getString("couleur"));
        v.setNbPlaces(rs.getInt("nb_places"));
        v.setPrixJournalier(rs.getDouble("prix_journalier"));
        v.setDisponible(rs.getBoolean("disponible"));
        v.setIdHotel(rs.getInt("id_hotel"));
        v.setDateAjout(rs.getTimestamp("date_ajout"));
        v.setNomHotel(rs.getString("nom_hotel"));
        return v;
    }
}

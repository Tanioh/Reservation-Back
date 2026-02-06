package com.reservation.backoffice.dao;

import com.reservation.backoffice.config.DatabaseConfig;
import com.reservation.backoffice.model.Reservation;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO pour la gestion des réservations.
 * Supporte le filtrage par date début et date fin.
 */
public class ReservationDAO {

    /**
     * Récupérer toutes les réservations avec jointures client + voiture.
     */
    public List<Reservation> findAll() throws SQLException {
        return findByFilter(null, null, null);
    }

    /**
     * Rechercher des réservations avec filtre par date et/ou statut.
     *
     * @param dateDebut  Date de début minimale (nullable)
     * @param dateFin    Date de fin maximale (nullable)
     * @param statut     Statut de la réservation (nullable)
     */
    public List<Reservation> findByFilter(Date dateDebut, Date dateFin, String statut) throws SQLException {
        List<Reservation> reservations = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT r.*, c.nom AS nom_client, c.prenom AS prenom_client, "
            + "CONCAT(v.marque, ' ', v.modele) AS nom_voiture "
            + "FROM reservation r "
            + "JOIN client c ON r.id_client = c.id_client "
            + "JOIN voiture v ON r.id_voiture = v.id_voiture "
            + "WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();

        if (dateDebut != null) {
            sql.append("AND r.date_debut >= ? ");
            params.add(dateDebut);
        }
        if (dateFin != null) {
            sql.append("AND r.date_fin <= ? ");
            params.add(dateFin);
        }
        if (statut != null && !statut.isEmpty()) {
            sql.append("AND r.statut = ? ");
            params.add(statut);
        }

        sql.append("ORDER BY r.date_reservation DESC");

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                Object param = params.get(i);
                if (param instanceof Date) {
                    ps.setDate(i + 1, (Date) param);
                } else {
                    ps.setString(i + 1, (String) param);
                }
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    reservations.add(mapResultSet(rs));
                }
            }
        }
        return reservations;
    }

    /**
     * Trouver une réservation par ID.
     */
    public Reservation findById(int id) throws SQLException {
        String sql = "SELECT r.*, c.nom AS nom_client, c.prenom AS prenom_client, "
                   + "CONCAT(v.marque, ' ', v.modele) AS nom_voiture "
                   + "FROM reservation r "
                   + "JOIN client c ON r.id_client = c.id_client "
                   + "JOIN voiture v ON r.id_voiture = v.id_voiture "
                   + "WHERE r.id_reservation = ?";

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
     * Insérer une nouvelle réservation.
     */
    public Reservation insert(Reservation reservation) throws SQLException {
        String sql = "INSERT INTO reservation (id_client, id_voiture, date_debut, date_fin, "
                   + "montant_total, statut, commentaire) VALUES (?, ?, ?, ?, ?, ?, ?) RETURNING id_reservation";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, reservation.getIdClient());
            ps.setInt(2, reservation.getIdVoiture());
            ps.setDate(3, reservation.getDateDebut());
            ps.setDate(4, reservation.getDateFin());
            ps.setDouble(5, reservation.getMontantTotal());
            ps.setString(6, reservation.getStatut());
            ps.setString(7, reservation.getCommentaire());

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    reservation.setIdReservation(rs.getInt("id_reservation"));
                }
            }
        }
        return reservation;
    }

    /**
     * Mettre à jour une réservation.
     */
    public void update(Reservation reservation) throws SQLException {
        String sql = "UPDATE reservation SET id_client=?, id_voiture=?, date_debut=?, date_fin=?, "
                   + "montant_total=?, statut=?, commentaire=? WHERE id_reservation=?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, reservation.getIdClient());
            ps.setInt(2, reservation.getIdVoiture());
            ps.setDate(3, reservation.getDateDebut());
            ps.setDate(4, reservation.getDateFin());
            ps.setDouble(5, reservation.getMontantTotal());
            ps.setString(6, reservation.getStatut());
            ps.setString(7, reservation.getCommentaire());
            ps.setInt(8, reservation.getIdReservation());
            ps.executeUpdate();
        }
    }

    /**
     * Supprimer une réservation.
     */
    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM reservation WHERE id_reservation = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    /**
     * Changer le statut d'une réservation.
     */
    public void updateStatut(int id, String statut) throws SQLException {
        String sql = "UPDATE reservation SET statut = ? WHERE id_reservation = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, statut);
            ps.setInt(2, id);
            ps.executeUpdate();
        }
    }

    private Reservation mapResultSet(ResultSet rs) throws SQLException {
        Reservation r = new Reservation();
        r.setIdReservation(rs.getInt("id_reservation"));
        r.setIdClient(rs.getInt("id_client"));
        r.setIdVoiture(rs.getInt("id_voiture"));
        r.setDateDebut(rs.getDate("date_debut"));
        r.setDateFin(rs.getDate("date_fin"));
        r.setMontantTotal(rs.getDouble("montant_total"));
        r.setStatut(rs.getString("statut"));
        r.setDateReservation(rs.getTimestamp("date_reservation"));
        r.setCommentaire(rs.getString("commentaire"));
        r.setNomClient(rs.getString("nom_client"));
        r.setPrenomClient(rs.getString("prenom_client"));
        r.setNomVoiture(rs.getString("nom_voiture"));
        return r;
    }
}

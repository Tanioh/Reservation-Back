package com.reservation.backoffice.model;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * Entité Reservation.
 */
public class Reservation {

    private int idReservation;
    private int idClient;
    private int idVoiture;
    private Date dateDebut;
    private Date dateFin;
    private double montantTotal;
    private String statut;
    private Timestamp dateReservation;
    private String commentaire;

    // Champs transients pour l'affichage
    private String nomClient;
    private String prenomClient;
    private String nomVoiture;

    public Reservation() {}

    public Reservation(int idReservation, int idClient, int idVoiture,
                       Date dateDebut, Date dateFin, double montantTotal,
                       String statut, String commentaire) {
        this.idReservation = idReservation;
        this.idClient = idClient;
        this.idVoiture = idVoiture;
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
        this.montantTotal = montantTotal;
        this.statut = statut;
        this.commentaire = commentaire;
    }

    // Getters & Setters
    public int getIdReservation() { return idReservation; }
    public void setIdReservation(int idReservation) { this.idReservation = idReservation; }

    public int getIdClient() { return idClient; }
    public void setIdClient(int idClient) { this.idClient = idClient; }

    public int getIdVoiture() { return idVoiture; }
    public void setIdVoiture(int idVoiture) { this.idVoiture = idVoiture; }

    public Date getDateDebut() { return dateDebut; }
    public void setDateDebut(Date dateDebut) { this.dateDebut = dateDebut; }

    public Date getDateFin() { return dateFin; }
    public void setDateFin(Date dateFin) { this.dateFin = dateFin; }

    public double getMontantTotal() { return montantTotal; }
    public void setMontantTotal(double montantTotal) { this.montantTotal = montantTotal; }

    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }

    public Timestamp getDateReservation() { return dateReservation; }
    public void setDateReservation(Timestamp dateReservation) { this.dateReservation = dateReservation; }

    public String getCommentaire() { return commentaire; }
    public void setCommentaire(String commentaire) { this.commentaire = commentaire; }

    public String getNomClient() { return nomClient; }
    public void setNomClient(String nomClient) { this.nomClient = nomClient; }

    public String getPrenomClient() { return prenomClient; }
    public void setPrenomClient(String prenomClient) { this.prenomClient = prenomClient; }

    public String getNomVoiture() { return nomVoiture; }
    public void setNomVoiture(String nomVoiture) { this.nomVoiture = nomVoiture; }

    /**
     * Retourne le nom complet du client.
     */
    public String getClientComplet() {
        return prenomClient + " " + nomClient;
    }
}

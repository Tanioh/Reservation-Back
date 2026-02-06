package com.reservation.backoffice.model;

import java.sql.Timestamp;

/**
 * Entité Voiture.
 */
public class Voiture {

    private int idVoiture;
    private String marque;
    private String modele;
    private String immatriculation;
    private String couleur;
    private int nbPlaces;
    private double prixJournalier;
    private boolean disponible;
    private int idHotel;
    private Timestamp dateAjout;

    // Champ transient pour l'affichage
    private String nomHotel;

    public Voiture() {}

    public Voiture(int idVoiture, String marque, String modele, String immatriculation,
                   String couleur, int nbPlaces, double prixJournalier, boolean disponible, int idHotel) {
        this.idVoiture = idVoiture;
        this.marque = marque;
        this.modele = modele;
        this.immatriculation = immatriculation;
        this.couleur = couleur;
        this.nbPlaces = nbPlaces;
        this.prixJournalier = prixJournalier;
        this.disponible = disponible;
        this.idHotel = idHotel;
    }

    // Getters & Setters
    public int getIdVoiture() { return idVoiture; }
    public void setIdVoiture(int idVoiture) { this.idVoiture = idVoiture; }

    public String getMarque() { return marque; }
    public void setMarque(String marque) { this.marque = marque; }

    public String getModele() { return modele; }
    public void setModele(String modele) { this.modele = modele; }

    public String getImmatriculation() { return immatriculation; }
    public void setImmatriculation(String immatriculation) { this.immatriculation = immatriculation; }

    public String getCouleur() { return couleur; }
    public void setCouleur(String couleur) { this.couleur = couleur; }

    public int getNbPlaces() { return nbPlaces; }
    public void setNbPlaces(int nbPlaces) { this.nbPlaces = nbPlaces; }

    public double getPrixJournalier() { return prixJournalier; }
    public void setPrixJournalier(double prixJournalier) { this.prixJournalier = prixJournalier; }

    public boolean isDisponible() { return disponible; }
    public void setDisponible(boolean disponible) { this.disponible = disponible; }

    public int getIdHotel() { return idHotel; }
    public void setIdHotel(int idHotel) { this.idHotel = idHotel; }

    public Timestamp getDateAjout() { return dateAjout; }
    public void setDateAjout(Timestamp dateAjout) { this.dateAjout = dateAjout; }

    public String getNomHotel() { return nomHotel; }
    public void setNomHotel(String nomHotel) { this.nomHotel = nomHotel; }

    /**
     * Retourne le nom complet de la voiture.
     */
    public String getNomComplet() {
        return marque + " " + modele;
    }
}

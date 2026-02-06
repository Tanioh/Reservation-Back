package com.reservation.backoffice.model;

import java.sql.Timestamp;

/**
 * Entité Hotel.
 */
public class Hotel {

    private int idHotel;
    private String nom;
    private String adresse;
    private String ville;
    private String codePostal;
    private String telephone;
    private String email;
    private int nbEtoiles;
    private Timestamp dateCreation;

    public Hotel() {}

    public Hotel(int idHotel, String nom, String adresse, String ville, String codePostal,
                 String telephone, String email, int nbEtoiles) {
        this.idHotel = idHotel;
        this.nom = nom;
        this.adresse = adresse;
        this.ville = ville;
        this.codePostal = codePostal;
        this.telephone = telephone;
        this.email = email;
        this.nbEtoiles = nbEtoiles;
    }

    // Getters & Setters
    public int getIdHotel() { return idHotel; }
    public void setIdHotel(int idHotel) { this.idHotel = idHotel; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getAdresse() { return adresse; }
    public void setAdresse(String adresse) { this.adresse = adresse; }

    public String getVille() { return ville; }
    public void setVille(String ville) { this.ville = ville; }

    public String getCodePostal() { return codePostal; }
    public void setCodePostal(String codePostal) { this.codePostal = codePostal; }

    public String getTelephone() { return telephone; }
    public void setTelephone(String telephone) { this.telephone = telephone; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public int getNbEtoiles() { return nbEtoiles; }
    public void setNbEtoiles(int nbEtoiles) { this.nbEtoiles = nbEtoiles; }

    public Timestamp getDateCreation() { return dateCreation; }
    public void setDateCreation(Timestamp dateCreation) { this.dateCreation = dateCreation; }
}

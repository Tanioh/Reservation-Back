-- ============================================================
-- RESERVATION VOITURE - Base de données PostgreSQL
-- Sprint 1 - Création des tables
-- ============================================================

-- Créer la base de données (à exécuter en tant que superuser)
-- CREATE DATABASE reservation_voiture;

-- ============================================================
-- TABLE : hotel
-- ============================================================
CREATE TABLE IF NOT EXISTS hotel (
    id_hotel        SERIAL PRIMARY KEY,
    nom             VARCHAR(150) NOT NULL,
    adresse         VARCHAR(255),
    ville           VARCHAR(100) NOT NULL,
    code_postal     VARCHAR(10),
    telephone       VARCHAR(20),
    email           VARCHAR(150),
    nb_etoiles      INT DEFAULT 0 CHECK (nb_etoiles >= 0 AND nb_etoiles <= 5),
    date_creation   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- TABLE : client
-- ============================================================
CREATE TABLE IF NOT EXISTS client (
    id_client       SERIAL PRIMARY KEY,
    nom             VARCHAR(100) NOT NULL,
    prenom          VARCHAR(100) NOT NULL,
    email           VARCHAR(150) UNIQUE NOT NULL,
    telephone       VARCHAR(20),
    adresse         VARCHAR(255),
    date_inscription TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- TABLE : voiture
-- ============================================================
CREATE TABLE IF NOT EXISTS voiture (
    id_voiture      SERIAL PRIMARY KEY,
    marque          VARCHAR(80) NOT NULL,
    modele          VARCHAR(80) NOT NULL,
    immatriculation VARCHAR(20) UNIQUE NOT NULL,
    couleur         VARCHAR(50),
    nb_places       INT DEFAULT 5,
    prix_journalier NUMERIC(10, 2) NOT NULL,
    disponible      BOOLEAN DEFAULT TRUE,
    id_hotel        INT REFERENCES hotel(id_hotel) ON DELETE SET NULL,
    date_ajout      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- TABLE : reservation
-- ============================================================
CREATE TABLE IF NOT EXISTS reservation (
    id_reservation  SERIAL PRIMARY KEY,
    id_client       INT NOT NULL REFERENCES client(id_client) ON DELETE CASCADE,
    id_voiture      INT NOT NULL REFERENCES voiture(id_voiture) ON DELETE CASCADE,
    date_debut      DATE NOT NULL,
    date_fin        DATE NOT NULL,
    montant_total   NUMERIC(10, 2),
    statut          VARCHAR(30) DEFAULT 'EN_ATTENTE' 
                    CHECK (statut IN ('EN_ATTENTE', 'CONFIRMEE', 'ANNULEE', 'TERMINEE')),
    date_reservation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    commentaire     TEXT,

    CONSTRAINT chk_dates CHECK (date_fin >= date_debut)
);

-- ============================================================
-- INDEX pour optimiser les filtres par date
-- ============================================================
CREATE INDEX IF NOT EXISTS idx_reservation_date_debut ON reservation(date_debut);
CREATE INDEX IF NOT EXISTS idx_reservation_date_fin ON reservation(date_fin);
CREATE INDEX IF NOT EXISTS idx_reservation_statut ON reservation(statut);
CREATE INDEX IF NOT EXISTS idx_voiture_hotel ON voiture(id_hotel);

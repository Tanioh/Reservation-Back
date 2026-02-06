-- ============================================================
-- SCRIPT D'INSERTION - HOTELS
-- Sprint 1 - Données initiales
-- ============================================================

INSERT INTO hotel (nom, adresse, ville, code_postal, telephone, email, nb_etoiles) VALUES
('Hôtel Le Royal', '12 Avenue des Champs-Élysées', 'Paris', '75008', '+33 1 42 56 78 90', 'contact@leroyal.fr', 5),
('Hôtel Bella Vista', '45 Rue de la République', 'Lyon', '69001', '+33 4 72 34 56 78', 'info@bellavista-lyon.fr', 4),
('Hôtel du Port', '8 Quai des Belges', 'Marseille', '13001', '+33 4 91 23 45 67', 'reservation@hotelduport.fr', 3),
('Hôtel Les Alpes', '23 Rue du Mont-Blanc', 'Chamonix', '74400', '+33 4 50 12 34 56', 'contact@lesalpes-chamonix.fr', 4),
('Hôtel Océan', '56 Boulevard de la Plage', 'Biarritz', '64200', '+33 5 59 67 89 01', 'info@hotel-ocean.fr', 3),
('Hôtel de la Gare', '3 Place de la Gare', 'Strasbourg', '67000', '+33 3 88 45 67 89', 'accueil@hotelgare-strasbourg.fr', 2),
('Hôtel Le Provençal', '18 Cours Mirabeau', 'Aix-en-Provence', '13100', '+33 4 42 78 90 12', 'contact@leprovencal.fr', 4),
('Hôtel Atlantique', '77 Rue Crébillon', 'Nantes', '44000', '+33 2 40 56 78 90', 'info@hotel-atlantique.fr', 3),
('Hôtel du Château', '5 Rue du Château', 'Bordeaux', '33000', '+33 5 56 34 56 78', 'reservation@hotelduchateau.fr', 5),
('Hôtel Le Jardin', '29 Avenue Jean Jaurès', 'Toulouse', '31000', '+33 5 61 23 45 67', 'contact@lejardin-toulouse.fr', 3);

-- ============================================================
-- SCRIPT D'INSERTION - CLIENTS (données de test)
-- ============================================================

INSERT INTO client (nom, prenom, email, telephone, adresse) VALUES
('Dupont', 'Jean', 'jean.dupont@email.com', '+33 6 12 34 56 78', '15 Rue de Rivoli, Paris'),
('Martin', 'Marie', 'marie.martin@email.com', '+33 6 23 45 67 89', '8 Rue Victor Hugo, Lyon'),
('Bernard', 'Pierre', 'pierre.bernard@email.com', '+33 6 34 56 78 90', '22 Avenue de la Liberté, Marseille'),
('Petit', 'Sophie', 'sophie.petit@email.com', '+33 6 45 67 89 01', '10 Rue Pasteur, Bordeaux'),
('Moreau', 'Luc', 'luc.moreau@email.com', '+33 6 56 78 90 12', '6 Boulevard Gambetta, Toulouse');

-- ============================================================
-- SCRIPT D'INSERTION - VOITURES
-- ============================================================

INSERT INTO voiture (marque, modele, immatriculation, couleur, nb_places, prix_journalier, disponible, id_hotel) VALUES
('Renault', 'Clio', 'AA-123-BB', 'Blanche', 5, 35.00, TRUE, 1),
('Peugeot', '308', 'CC-456-DD', 'Noire', 5, 45.00, TRUE, 1),
('Citroën', 'C3', 'EE-789-FF', 'Rouge', 5, 30.00, TRUE, 2),
('Toyota', 'Yaris', 'GG-012-HH', 'Grise', 5, 40.00, TRUE, 2),
('BMW', 'Serie 3', 'II-345-JJ', 'Bleue', 5, 85.00, TRUE, 3),
('Mercedes', 'Classe A', 'KK-678-LL', 'Noire', 5, 90.00, TRUE, 4),
('Volkswagen', 'Golf', 'MM-901-NN', 'Blanche', 5, 50.00, TRUE, 5),
('Audi', 'A3', 'OO-234-PP', 'Grise', 5, 75.00, TRUE, 6),
('Ford', 'Focus', 'QQ-567-RR', 'Rouge', 5, 42.00, TRUE, 7),
('Renault', 'Megane', 'SS-890-TT', 'Bleue', 5, 48.00, TRUE, 8),
('Peugeot', '208', 'UU-123-VV', 'Blanche', 5, 32.00, TRUE, 9),
('Fiat', '500', 'WW-456-XX', 'Jaune', 4, 28.00, TRUE, 10);

-- ============================================================
-- SCRIPT D'INSERTION - RESERVATIONS (données de test)
-- ============================================================

INSERT INTO reservation (id_client, id_voiture, date_debut, date_fin, montant_total, statut, commentaire) VALUES
(1, 1, '2026-02-10', '2026-02-15', 175.00, 'CONFIRMEE', 'Reservation pour voyage d''affaires'),
(2, 3, '2026-02-12', '2026-02-14', 60.00, 'EN_ATTENTE', 'Week-end a Lyon'),
(3, 5, '2026-02-20', '2026-02-25', 425.00, 'CONFIRMEE', 'Vacances a Marseille'),
(4, 7, '2026-03-01', '2026-03-05', 200.00, 'EN_ATTENTE', NULL),
(5, 9, '2026-03-10', '2026-03-12', 84.00, 'CONFIRMEE', 'Déplacement professionnel'),
(1, 6, '2026-03-15', '2026-03-20', 450.00, 'EN_ATTENTE', 'Sejour a Chamonix'),
(2, 11, '2026-02-08', '2026-02-10', 64.00, 'TERMINEE', 'Visite Bordeaux'),
(3, 2, '2026-01-25', '2026-01-28', 135.00, 'TERMINEE', NULL),
(4, 4, '2026-01-15', '2026-01-18', 120.00, 'ANNULEE', 'Annule pour raisons personnelles'),
(5, 8, '2026-02-05', '2026-02-07', 150.00, 'CONFIRMEE', 'Voyage Strasbourg');

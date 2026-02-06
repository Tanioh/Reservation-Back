# Tests Manuel - Reservation Voiture Sprint 1

## 1. Test Base de Données PostgreSQL

**Connectez-vous à PostgreSQL et exécutez :**
```bash
psql -U postgres -d reservation_voiture
```

**Puis exécuter le script de test :**
```sql
\i 'C:/Users/Mana/Desktop/S5 Steve/ReservationSprint/sql/test_complet.sql'
```

**Résultat attendu :**
- ✅ 10 hôtels insérés
- ✅ 5 clients insérés  
- ✅ 12 voitures insérées
- ✅ 10 réservations insérées
- ✅ Test filtre par date (février 2026) : doit retourner quelques réservations

---

## 2. Test FrontOffice (Spring Boot + Vue.js)

**URL :** http://localhost:8080

### Page d'accueil
- ✅ Liste des voitures disponibles
- ✅ Bouton "Réserver maintenant"
- ✅ Navigation : Accueil | Mes Réservations | Réserver

### Page Réservations (/reservations)
- ✅ Filtres par date (début/fin) + statut
- ✅ Tableau des réservations avec Vue.js (réactif)
- ✅ Badges colorés pour les statuts
- ✅ Bouton "Rechercher" et "Reset"

### Page Nouvelle Réservation (/nouvelle-reservation)  
- ✅ Sélection Client (dropdown)
- ✅ Sélection Voiture (dropdown avec prix)
- ✅ Dates début/fin
- ✅ Calcul automatique du montant (Vue.js)
- ✅ Créer la réservation via API REST

### API REST à tester
- `GET /api/reservations` → toutes les réservations
- `GET /api/reservations?dateDebut=2026-02-01&dateFin=2026-02-28` → filtre
- `POST /api/reservations` → créer nouvelle réservation
- `GET /api/reservations/clients` → liste clients
- `GET /api/reservations/voitures` → voitures disponibles

---

## 3. Test BackOffice (jframework MVC) 

**⚠️ Le BackOffice nécessite un serveur d'application (Tomcat/Jetty)**

### Déployement
1. Compiler : `mvn clean package`
2. Déployer `target/reservation-backoffice.war` sur Tomcat
3. URL : http://localhost:8080/reservation-backoffice

### Fonctionnalités à tester
- ✅ `/reservations` → Liste avec filtres date + statut
- ✅ `/reservations/new` → Formulaire création
- ✅ `/reservations/edit?id=X` → Modification
- ✅ `/reservations/detail?id=X` → Détail + changement statut
- ✅ `/hotels` → Gestion des hôtels

---

## 4. Vérifications techniques

### Base de données partagée ✅
- BackOffice et FrontOffice utilisent la même DB `reservation_voiture`
- Tables : `hotel`, `client`, `voiture`, `reservation`

### Branches Git ✅
- BackOffice : https://github.com/Tanioh/Reservation-Back
- FrontOffice : https://github.com/Tanioh/Reservation-front
- 3 branches : `master`, `staging`, `release`

### Configuration
- BackOffice : `database.properties` (PostgreSQL JDBC)
- FrontOffice : `application.properties` (Spring Boot JPA)

---

## 5. Test Scénario Complet

1. **Insérer données** via `test_complet.sql`
2. **FrontOffice** : Consulter les réservations avec filtre par date
3. **FrontOffice** : Créer une nouvelle réservation
4. **BackOffice** : Voir la nouvelle réservation et changer son statut
5. **FrontOffice** : Vérifier que le statut a changé

🎯 **Objectif Sprint 1 :** Script d'insertion hôtels + Liste réservations avec filtre par date → ✅
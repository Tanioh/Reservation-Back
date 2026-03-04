# 🚗 Projet Reservation Voiture - Sprint 1

Système de réservation de voitures avec BackOffice (administration) et FrontOffice (public).

## 📋 Prérequis

- **Java 17+**
- **Maven 3.8+**
- **PostgreSQL 14+** (base: `reservation_voiture`)
- **Apache Tomcat 11** (installé dans `C:\apache-tomcat-11.0.14`)

## 🚀 Lancement Rapide

### Option 1: Script Automatique (Recommandé)

Double-cliquez sur **`lancer_projet.bat`** à la racine du projet.

Le script:
1. Nettoie les processus Java existants
2. Compile et déploie le BackOffice sur Tomcat
3. Démarre le FrontOffice Spring Boot
4. Ouvre automatiquement les navigateurs

### Option 2: Lancement Manuel

#### BackOffice (Tomcat - Port 8080)
```bash
cd reservation-backoffice
mvn clean package
# Copier le WAR dans Tomcat/webapps
# Démarrer Tomcat
```

#### FrontOffice (Spring Boot - Port 8081)
```bash
cd reservation-frontoffice
mvn clean spring-boot:run
```

## 🌐 URLs d'Accès

| Service | URL | Description |
|---------|-----|-------------|
| **FrontOffice** | http://localhost:8081/ | Interface publique (Vue.js + Spring Boot) |
| **Réservations** | http://localhost:8081/reservations | Liste des réservations avec filtres |
| **Nouvelle Réservation** | http://localhost:8081/nouvelle-reservation | Formulaire de réservation |
| **API REST** | http://localhost:8081/api/reservations | API JSON pour Vue.js |
| **Tomcat** | http://localhost:8080/ | Serveur Tomcat (BackOffice) |

## 📊 Base de Données

### Connexion PostgreSQL
- **Host**: localhost:5432
- **Database**: `reservation_voiture`
- **User**: `postgres`
- **Password**: `postgres`

### Initialisation de la base

1. **Créer la base** (si pas déjà fait):
```bash
psql -U postgres
CREATE DATABASE reservation_voiture;
```

2. **Exécuter le script complet**:
```bash
psql -U postgres -d reservation_voiture -f sql/test_complet.sql
```

Le script contient:
- 10 hôtels
- 5 clients
- 12 voitures
- 10 réservations de test

## 🏗️ Architecture

### BackOffice (jframework MVC)
```
reservation-backoffice/
├── src/main/java/
│   └── mg/itu/reservation/
│       ├── controller/     # Contrôleurs MVC
│       ├── dao/            # Accès base de données
│       └── model/          # Modèles métier
├── webapp/
│   ├── WEB-INF/
│   │   └── views/          # Vues JSP
│   └── assets/             # CSS/JS
└── pom.xml
```

### FrontOffice (Spring Boot + Vue.js)
```
reservation-frontoffice/
├── src/main/java/
│   └── com/reservation/frontoffice/
│       ├── controller/     # Controllers REST + Views
│       ├── model/          # JPA Entities
│       ├── repository/     # Spring Data JPA
│       └── service/        # Business Logic
├── src/main/resources/
│   ├── templates/          # Thymeleaf + Vue.js
│   └── application.properties
└── pom.xml
```

## ✨ Fonctionnalités Implémentées

### Sprint 1 - Objectifs Atteints ✅

1. **Script d'insertion hôtel** ✅
   - 10 hôtels insérés dans `sql/test_complet.sql`
   - Vérifiable dans les deux interfaces

2. **Liste réservations avec filtre par date** ✅
   - BackOffice: Filtres JSP classiques
   - FrontOffice: Filtres Vue.js réactifs
   - API REST: `/api/reservations?dateDebut=2026-02-01&dateFin=2026-02-28`

3. **Interfaces complètes**
   - BackOffice: CRUD complet pour hotels, clients, voitures, réservations
   - FrontOffice: Page d'accueil, liste réservations, formulaire de création

## 🔧 Dépannage

### Le FrontOffice ne démarre pas
- Vérifiez que PostgreSQL tourne: `Get-Service postgresql*`
- Vérifiez la base: `psql -U postgres -l | findstr reservation`
- Vérifiez les logs dans la console Spring Boot

### Port 8081 déjà utilisé
Modifiez `reservation-frontoffice/src/main/resources/application.properties`:
```properties
server.port=8082
```

### Erreur de connexion PostgreSQL
Vérifiez les credentials dans `application.properties`:
```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/reservation_voiture
spring.datasource.username=postgres
spring.datasource.password=postgres
```

## 📦 Repositories GitHub

- **FrontOffice**: https://github.com/Tanioh/Reservation-front
- **BackOffice**: https://github.com/Tanioh/Reservation-Back

Branches disponibles:
- `master`: Version stable
- `staging`: Tests avant production
- `release`: Version de production

## 📝 Documentation Technique

### Corrections Appliquées (04/03/2026)

1. **Port configuration**: `server.port=8081` dans `application.properties`
2. **Database name**: Corrigé vers `reservation_voiture`
3. **JPA annotations**: Suppression `precision/scale` sur `Double`
4. **Lazy loading**: `Hotel` passé en `EAGER` avec `@JsonIgnoreProperties`
5. **Date reservation**: Auto-set avec `LocalDateTime.now()`
6. **API casting**: Safe casting `((Number)...).intValue()`

### Tests Manuels

Consultez `TESTS_MANUEL.md` pour les procédures de test complètes.

## 👥 Équipe

- **Sprint 1**: Système de réservation de base
- **Date**: Mars 2026

---

💡 **Astuce**: Pour arrêter le projet, fermez la fenêtre du script batch ET la fenêtre "FrontOffice Spring Boot".

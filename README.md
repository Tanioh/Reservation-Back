# Reservation BackOffice

## Description
Application de gestion des réservations de voitures — **BackOffice** (protégé).  
Utilise **jframework.jar** (MVC) avec une base de données **PostgreSQL**.

## Prérequis
- Java 17+
- PostgreSQL 14+
- Maven 3.8+

## Configuration
Modifier le fichier `src/main/resources/database.properties` avec vos identifiants PostgreSQL.

## Build & Run
```bash
mvn clean package
java -jar target/reservation-backoffice.jar
```

## Branches
- `release` → déploiement en production
- `staging` → déploiement local / développement

## Structure
```
reservation-backoffice/
├── src/main/java/com/reservation/backoffice/
│   ├── controller/       # Contrôleurs MVC
│   ├── model/            # Entités / modèles
│   ├── dao/              # Accès aux données (DAO)
│   ├── service/          # Logique métier
│   └── config/           # Configuration
├── src/main/resources/
│   ├── templates/        # Vues HTML (jframework)
│   └── database.properties
├── lib/
│   └── jframework.jar
└── pom.xml
```

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détail Réservation #${reservation.idReservation} - BackOffice</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="bi bi-car-front-fill"></i> Réservation Voiture - BackOffice
            </a>
        </div>
    </nav>

    <div class="container mt-4">
        <h2><i class="bi bi-info-circle"></i> Réservation #${reservation.idReservation}</h2>

        <div class="card mt-3">
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <h5>Informations</h5>
                        <table class="table">
                            <tr><th>Client</th><td>${reservation.prenomClient} ${reservation.nomClient}</td></tr>
                            <tr><th>Voiture</th><td>${reservation.nomVoiture}</td></tr>
                            <tr><th>Date début</th><td>${reservation.dateDebut}</td></tr>
                            <tr><th>Date fin</th><td>${reservation.dateFin}</td></tr>
                            <tr><th>Montant</th><td>${reservation.montantTotal} €</td></tr>
                            <tr>
                                <th>Statut</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${reservation.statut == 'CONFIRMEE'}">
                                            <span class="badge bg-success">${reservation.statut}</span>
                                        </c:when>
                                        <c:when test="${reservation.statut == 'EN_ATTENTE'}">
                                            <span class="badge bg-warning text-dark">${reservation.statut}</span>
                                        </c:when>
                                        <c:when test="${reservation.statut == 'ANNULEE'}">
                                            <span class="badge bg-danger">${reservation.statut}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">${reservation.statut}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr><th>Commentaire</th><td>${reservation.commentaire}</td></tr>
                            <tr><th>Date réservation</th><td>${reservation.dateReservation}</td></tr>
                        </table>
                    </div>
                    <div class="col-md-6">
                        <h5>Changer le statut</h5>
                        <form method="post" action="${pageContext.request.contextPath}/reservations/statut" class="d-flex gap-2">
                            <input type="hidden" name="id" value="${reservation.idReservation}">
                            <select name="statut" class="form-select">
                                <option value="EN_ATTENTE">En attente</option>
                                <option value="CONFIRMEE">Confirmée</option>
                                <option value="ANNULEE">Annulée</option>
                                <option value="TERMINEE">Terminée</option>
                            </select>
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check"></i> Appliquer
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="mt-3 d-flex gap-2">
            <a href="${pageContext.request.contextPath}/reservations/edit?id=${reservation.idReservation}" 
               class="btn btn-warning">
                <i class="bi bi-pencil"></i> Modifier
            </a>
            <a href="${pageContext.request.contextPath}/reservations" class="btn btn-secondary">
                <i class="bi bi-arrow-left"></i> Retour à la liste
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

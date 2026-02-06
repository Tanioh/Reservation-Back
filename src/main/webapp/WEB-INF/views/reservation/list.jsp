<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Réservations - BackOffice</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="bi bi-car-front-fill"></i> Réservation Voiture - BackOffice
            </a>
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/hotels">Hôtels</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/reservations">Réservations</a>
                </li>
            </ul>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="bi bi-calendar-check"></i> Liste des Réservations</h2>
            <a href="${pageContext.request.contextPath}/reservations/new" class="btn btn-primary">
                <i class="bi bi-plus-lg"></i> Nouvelle Réservation
            </a>
        </div>

        <!-- Filtres par date -->
        <div class="card mb-4">
            <div class="card-header bg-light">
                <i class="bi bi-funnel"></i> Filtres
            </div>
            <div class="card-body">
                <form method="get" action="${pageContext.request.contextPath}/reservations" class="row g-3">
                    <div class="col-md-3">
                        <label for="dateDebut" class="form-label">Date début (à partir de)</label>
                        <input type="date" class="form-control" id="dateDebut" name="dateDebut" 
                               value="${dateDebut}">
                    </div>
                    <div class="col-md-3">
                        <label for="dateFin" class="form-label">Date fin (jusqu'à)</label>
                        <input type="date" class="form-control" id="dateFin" name="dateFin" 
                               value="${dateFin}">
                    </div>
                    <div class="col-md-3">
                        <label for="statut" class="form-label">Statut</label>
                        <select class="form-select" id="statut" name="statut">
                            <option value="">-- Tous --</option>
                            <option value="EN_ATTENTE" ${statut == 'EN_ATTENTE' ? 'selected' : ''}>En attente</option>
                            <option value="CONFIRMEE" ${statut == 'CONFIRMEE' ? 'selected' : ''}>Confirmée</option>
                            <option value="ANNULEE" ${statut == 'ANNULEE' ? 'selected' : ''}>Annulée</option>
                            <option value="TERMINEE" ${statut == 'TERMINEE' ? 'selected' : ''}>Terminée</option>
                        </select>
                    </div>
                    <div class="col-md-3 d-flex align-items-end gap-2">
                        <button type="submit" class="btn btn-outline-primary">
                            <i class="bi bi-search"></i> Filtrer
                        </button>
                        <a href="${pageContext.request.contextPath}/reservations" class="btn btn-outline-secondary">
                            <i class="bi bi-x-lg"></i> Réinitialiser
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <!-- Tableau des réservations -->
        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>#</th>
                        <th>Client</th>
                        <th>Voiture</th>
                        <th>Date début</th>
                        <th>Date fin</th>
                        <th>Montant (€)</th>
                        <th>Statut</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="r" items="${reservations}">
                        <tr>
                            <td>${r.idReservation}</td>
                            <td>${r.prenomClient} ${r.nomClient}</td>
                            <td>${r.nomVoiture}</td>
                            <td>${r.dateDebut}</td>
                            <td>${r.dateFin}</td>
                            <td>${r.montantTotal}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${r.statut == 'CONFIRMEE'}">
                                        <span class="badge bg-success">${r.statut}</span>
                                    </c:when>
                                    <c:when test="${r.statut == 'EN_ATTENTE'}">
                                        <span class="badge bg-warning text-dark">${r.statut}</span>
                                    </c:when>
                                    <c:when test="${r.statut == 'ANNULEE'}">
                                        <span class="badge bg-danger">${r.statut}</span>
                                    </c:when>
                                    <c:when test="${r.statut == 'TERMINEE'}">
                                        <span class="badge bg-secondary">${r.statut}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-info">${r.statut}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/reservations/detail?id=${r.idReservation}" 
                                   class="btn btn-sm btn-info" title="Détail">
                                    <i class="bi bi-eye"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/reservations/edit?id=${r.idReservation}" 
                                   class="btn btn-sm btn-warning" title="Modifier">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <form method="post" action="${pageContext.request.contextPath}/reservations/delete" 
                                      style="display:inline;" 
                                      onsubmit="return confirm('Supprimer cette réservation ?')">
                                    <input type="hidden" name="id" value="${r.idReservation}">
                                    <button type="submit" class="btn btn-sm btn-danger" title="Supprimer">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty reservations}">
                        <tr>
                            <td colspan="8" class="text-center text-muted py-4">
                                <i class="bi bi-inbox"></i> Aucune réservation trouvée
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <div class="text-muted mt-2">
            <small>Total : ${reservations.size()} réservation(s)</small>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

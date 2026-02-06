<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${reservation != null ? 'Modifier' : 'Nouvelle'} Réservation - BackOffice</title>
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
        <h2>
            <i class="bi bi-${reservation != null ? 'pencil-square' : 'plus-circle'}"></i>
            ${reservation != null ? 'Modifier la' : 'Nouvelle'} Réservation
        </h2>

        <div class="card mt-3">
            <div class="card-body">
                <form method="post" 
                      action="${pageContext.request.contextPath}/reservations/${reservation != null ? 'update' : 'create'}">

                    <c:if test="${reservation != null}">
                        <input type="hidden" name="idReservation" value="${reservation.idReservation}">
                    </c:if>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="idClient" class="form-label">Client *</label>
                            <select class="form-select" id="idClient" name="idClient" required>
                                <option value="">-- Sélectionner un client --</option>
                                <c:forEach var="c" items="${clients}">
                                    <option value="${c.idClient}" 
                                        ${reservation != null && reservation.idClient == c.idClient ? 'selected' : ''}>
                                        ${c.prenom} ${c.nom} (${c.email})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="idVoiture" class="form-label">Voiture *</label>
                            <select class="form-select" id="idVoiture" name="idVoiture" required>
                                <option value="">-- Sélectionner une voiture --</option>
                                <c:forEach var="v" items="${voitures}">
                                    <option value="${v.idVoiture}" data-prix="${v.prixJournalier}"
                                        ${reservation != null && reservation.idVoiture == v.idVoiture ? 'selected' : ''}>
                                        ${v.marque} ${v.modele} - ${v.immatriculation} (${v.prixJournalier}€/jour)
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label for="dateDebut" class="form-label">Date début *</label>
                            <input type="date" class="form-control" id="dateDebut" name="dateDebut" 
                                   value="${reservation != null ? reservation.dateDebut : ''}" required>
                        </div>
                        <div class="col-md-4">
                            <label for="dateFin" class="form-label">Date fin *</label>
                            <input type="date" class="form-control" id="dateFin" name="dateFin" 
                                   value="${reservation != null ? reservation.dateFin : ''}" required>
                        </div>
                        <div class="col-md-4">
                            <label for="montantTotal" class="form-label">Montant total (€) *</label>
                            <input type="number" step="0.01" class="form-control" id="montantTotal" 
                                   name="montantTotal" 
                                   value="${reservation != null ? reservation.montantTotal : ''}" required>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label for="statut" class="form-label">Statut *</label>
                            <select class="form-select" id="statut" name="statut" required>
                                <option value="EN_ATTENTE" ${reservation != null && reservation.statut == 'EN_ATTENTE' ? 'selected' : ''}>En attente</option>
                                <option value="CONFIRMEE" ${reservation != null && reservation.statut == 'CONFIRMEE' ? 'selected' : ''}>Confirmée</option>
                                <option value="ANNULEE" ${reservation != null && reservation.statut == 'ANNULEE' ? 'selected' : ''}>Annulée</option>
                                <option value="TERMINEE" ${reservation != null && reservation.statut == 'TERMINEE' ? 'selected' : ''}>Terminée</option>
                            </select>
                        </div>
                        <div class="col-md-8">
                            <label for="commentaire" class="form-label">Commentaire</label>
                            <textarea class="form-control" id="commentaire" name="commentaire" 
                                      rows="2">${reservation != null ? reservation.commentaire : ''}</textarea>
                        </div>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-success">
                            <i class="bi bi-check-lg"></i> ${reservation != null ? 'Mettre à jour' : 'Créer'}
                        </button>
                        <a href="${pageContext.request.contextPath}/reservations" class="btn btn-secondary">
                            <i class="bi bi-arrow-left"></i> Retour
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Calcul automatique du montant
        const dateDebut = document.getElementById('dateDebut');
        const dateFin = document.getElementById('dateFin');
        const voitureSelect = document.getElementById('idVoiture');
        const montantInput = document.getElementById('montantTotal');

        function calculerMontant() {
            const debut = new Date(dateDebut.value);
            const fin = new Date(dateFin.value);
            const selected = voitureSelect.options[voitureSelect.selectedIndex];
            const prixJour = parseFloat(selected.dataset.prix || 0);

            if (debut && fin && prixJour && fin >= debut) {
                const jours = Math.ceil((fin - debut) / (1000 * 60 * 60 * 24));
                montantInput.value = (jours * prixJour).toFixed(2);
            }
        }

        dateDebut.addEventListener('change', calculerMontant);
        dateFin.addEventListener('change', calculerMontant);
        voitureSelect.addEventListener('change', calculerMontant);
    </script>
</body>
</html>

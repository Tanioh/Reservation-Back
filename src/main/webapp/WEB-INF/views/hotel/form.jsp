<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${hotel != null ? 'Modifier' : 'Nouvel'} Hôtel - BackOffice</title>
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
            <i class="bi bi-building"></i>
            ${hotel != null ? 'Modifier l\'hôtel' : 'Nouvel hôtel'}
        </h2>

        <div class="card mt-3">
            <div class="card-body">
                <form method="post" 
                      action="${pageContext.request.contextPath}/hotels/${hotel != null ? 'update' : 'create'}">

                    <c:if test="${hotel != null}">
                        <input type="hidden" name="idHotel" value="${hotel.idHotel}">
                    </c:if>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="nom" class="form-label">Nom *</label>
                            <input type="text" class="form-control" id="nom" name="nom" 
                                   value="${hotel != null ? hotel.nom : ''}" required>
                        </div>
                        <div class="col-md-6">
                            <label for="ville" class="form-label">Ville *</label>
                            <input type="text" class="form-control" id="ville" name="ville" 
                                   value="${hotel != null ? hotel.ville : ''}" required>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-8">
                            <label for="adresse" class="form-label">Adresse</label>
                            <input type="text" class="form-control" id="adresse" name="adresse" 
                                   value="${hotel != null ? hotel.adresse : ''}">
                        </div>
                        <div class="col-md-4">
                            <label for="codePostal" class="form-label">Code postal</label>
                            <input type="text" class="form-control" id="codePostal" name="codePostal" 
                                   value="${hotel != null ? hotel.codePostal : ''}">
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label for="telephone" class="form-label">Téléphone</label>
                            <input type="text" class="form-control" id="telephone" name="telephone" 
                                   value="${hotel != null ? hotel.telephone : ''}">
                        </div>
                        <div class="col-md-4">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" 
                                   value="${hotel != null ? hotel.email : ''}">
                        </div>
                        <div class="col-md-4">
                            <label for="nbEtoiles" class="form-label">Étoiles</label>
                            <select class="form-select" id="nbEtoiles" name="nbEtoiles">
                                <c:forEach begin="0" end="5" var="i">
                                    <option value="${i}" ${hotel != null && hotel.nbEtoiles == i ? 'selected' : ''}>${i}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-success">
                            <i class="bi bi-check-lg"></i> ${hotel != null ? 'Mettre à jour' : 'Créer'}
                        </button>
                        <a href="${pageContext.request.contextPath}/hotels" class="btn btn-secondary">
                            <i class="bi bi-arrow-left"></i> Retour
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

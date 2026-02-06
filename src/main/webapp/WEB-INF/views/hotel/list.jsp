<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hôtels - BackOffice</title>
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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/hotels">Hôtels</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/reservations">Réservations</a>
                </li>
            </ul>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="bi bi-building"></i> Liste des Hôtels</h2>
            <a href="${pageContext.request.contextPath}/hotels/new" class="btn btn-primary">
                <i class="bi bi-plus-lg"></i> Nouvel Hôtel
            </a>
        </div>

        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>#</th>
                        <th>Nom</th>
                        <th>Ville</th>
                        <th>Adresse</th>
                        <th>Téléphone</th>
                        <th>Étoiles</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="h" items="${hotels}">
                        <tr>
                            <td>${h.idHotel}</td>
                            <td>${h.nom}</td>
                            <td>${h.ville}</td>
                            <td>${h.adresse}</td>
                            <td>${h.telephone}</td>
                            <td>
                                <c:forEach begin="1" end="${h.nbEtoiles}">
                                    <i class="bi bi-star-fill text-warning"></i>
                                </c:forEach>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/hotels/edit?id=${h.idHotel}" 
                                   class="btn btn-sm btn-warning">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <form method="post" action="${pageContext.request.contextPath}/hotels/delete" 
                                      style="display:inline;"
                                      onsubmit="return confirm('Supprimer cet hôtel ?')">
                                    <input type="hidden" name="id" value="${h.idHotel}">
                                    <button type="submit" class="btn btn-sm btn-danger">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

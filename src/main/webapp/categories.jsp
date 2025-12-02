<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Categories</title>
  <link rel="stylesheet" href="./libraries/bootstrap/bootstrap.min.css">
</head>
<body>

<%@include file="navbar.jsp" %>

<div class="container py-4">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="h4 mb-0">Liste des catégories</h1>
    <a href="/servlet-jsp-gr3/categories/create" class="btn btn-primary">Ajouter</a>
  </div>

  <c:if test="${empty requestScope.categories}">
    <div class="alert alert-info">Aucune catégorie disponible.</div>
  </c:if>

  <c:if test="${not empty requestScope.categories}">
    <div class="table-responsive">
      <table class="table table-striped table-bordered align-middle">
        <thead class="table-light">
          <tr>
            <th style="width: 20%;">Nom</th>
            <th style="width: 40%;">Description</th>
            <th style="width: 20%;">Actions</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="category" items="${requestScope.categories}">
            <tr>
              <td><strong>${category.name}</strong></td>
              <td>${category.description}</td>

              <td>
                <div class="btn-group" role="group">
                  <!-- Replace name with your actual unique identifier if available -->
                  <a href="/servlet-jsp-gr3/categories/edit?name=${category.name}" class="btn btn-sm btn-outline-secondary">Modifier</a>
                  <a href="/servlet-jsp-gr3/categories/delete?name=${category.name}" class="btn btn-sm btn-outline-danger"
                     onclick="return confirm('Supprimer la catégorie ${category.name} ?');">Supprimer</a>
                </div>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </c:if>
</div>
</body>
</html>
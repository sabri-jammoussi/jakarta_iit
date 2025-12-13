<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <html>

      <head>
        <title>Produits</title>
        <link rel="stylesheet" href="./libraries/bootstrap/bootstrap.min.css">
      </head>

      <body>

        <%@include file="navbar.jsp" %>

          <div class="container py-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
              <h1 class="h4 mb-0">
                <c:choose>
                  <c:when test="${not empty requestScope.products}">
                    Produits
                  </c:when>
                  <c:otherwise>
                    Liste des produits
                  </c:otherwise>
                </c:choose>
              </h1>
              <a href="/servlet-jsp-gr3/products?action=add" class="btn btn-primary">Ajouter</a>
            </div>

            <c:if test="${empty requestScope.products}">
              <div class="alert alert-info">Aucun produit disponible.</div>
            </c:if>

            <c:if test="${not empty requestScope.products}">
              <div class="table-responsive">
                <table class="table table-striped table-bordered align-middle">
                  <thead class="table-light">
                    <tr>
                      <th style="width: 25%;">Nom</th>
                      <th style="width: 15%;">Prix</th>
                      <th style="width: 40%;">Description</th>
                      <th style="width: 20%;">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="p" items="${requestScope.products}">
                      <tr>
                        <td><strong>${p.name}</strong></td>
                        <td>
                          <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="$" />
                        </td>
                        <td>${p.description}</td>
                        <td>
                          <div class="btn-group" role="group">
                            <a href="/servlet-jsp-gr3/products?action=edit&id=${p.id}"
                              class="btn btn-sm btn-outline-secondary">Modifier</a>
                            <a href="/servlet-jsp-gr3/products?action=delete&id=${p.id}"
                              class="btn btn-sm btn-outline-danger"
                              onclick="return confirm('Supprimer le produit ${p.name} ?');">Supprimer</a>
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
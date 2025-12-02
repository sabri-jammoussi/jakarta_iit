<link rel="stylesheet" href="./libraries/bootstrap/bootstrap.min.css">
<% String fullname = (String) session.getAttribute("fullname"); %>


<nav class="navbar navbar-light bg-light d-flex justify-content-between p-3">
  <a class="navbar-brand" href="/servlet-jsp-gr3/home"><b>IIT Store</b></a>
  <a class="navbar-brand" href="/servlet-jsp-gr3/categories"><b>Category</b></a>
  <a class="navbar-brand" href="/servlet-jsp-gr3/produits"><b>Products</b></a>
  <a class="navbar-brand" href="/servlet-jsp-gr3/promotions"><b>Promotions</b></a>
  <% if (fullname != null) { %>
    <span class="navbar-text"><b><%= fullname %></b></span>
  <% } %>
</nav>
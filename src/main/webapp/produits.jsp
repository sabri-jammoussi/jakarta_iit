<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <!DOCTYPE html>
      <html lang="fr">

      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Products</title>
        <script src="https://cdn.tailwindcss.com"></script>
      </head>

      <body class="bg-gray-50">
        <%@include file="navbar.jsp" %>

          <!-- Header Section -->
          <div class="bg-gradient-to-r from-purple-600 to-pink-600 text-white py-12">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
              <div class="flex justify-between items-center">
                <div>
                  <h1 class="text-4xl font-bold mb-2">Products</h1>
                  <p class="text-purple-100">Manage your product catalog</p>
                </div>
                <a href="/servlet-jsp-gr3/products?action=add"
                  class="bg-white text-purple-600 hover:bg-purple-50 px-6 py-3 rounded-lg font-semibold transition-colors duration-200">
                  <span class="inline-block mr-2">+</span> Add Product
                </a>
              </div>
            </div>
          </div>

          <!-- Main Content -->
          <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
            <c:if test="${empty requestScope.products}">
              <div class="bg-blue-50 border border-blue-200 rounded-lg p-8 text-center">
                <p class="text-blue-800 text-lg">No products available. Create one to get started!</p>
              </div>
            </c:if>

            <c:if test="${not empty requestScope.products}">
              <div class="bg-white rounded-xl shadow-lg overflow-hidden">
                <div class="overflow-x-auto">
                  <table class="w-full">
                    <thead class="bg-gray-100 border-b border-gray-200">
                      <tr>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">Name</th>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">Price</th>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">Description</th>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">Actions</th>
                      </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200">
                      <c:forEach var="p" items="${requestScope.products}">
                        <tr class="hover:bg-gray-50 transition-colors duration-150">
                          <td class="px-6 py-4 text-sm font-medium text-gray-900">${p.name}</td>
                          <td class="px-6 py-4 text-sm font-semibold text-green-600">
                            <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="$" />
                          </td>
                          <td class="px-6 py-4 text-sm text-gray-600 max-w-md truncate">${p.description}</td>
                          <td class="px-6 py-4 text-sm space-x-2">
                            <a href="/servlet-jsp-gr3/products?action=edit&id=${p.id}"
                              class="inline-block bg-blue-600 hover:bg-blue-700 text-white px-3 py-2 rounded text-xs font-medium transition-colors duration-200">Edit</a>
                            <a href="/servlet-jsp-gr3/products?action=delete&id=${p.id}"
                              onclick="return confirm('Delete product ${p.name}?');"
                              class="inline-block bg-red-600 hover:bg-red-700 text-white px-3 py-2 rounded text-xs font-medium transition-colors duration-200">Delete</a>
                          </td>
                        </tr>
                      </c:forEach>
                    </tbody>
                  </table>
                </div>
              </div>
            </c:if>
          </div>
      </body>

      </html>
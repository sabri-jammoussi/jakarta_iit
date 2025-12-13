<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="fr">

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Categories</title>
      <script src="https://cdn.tailwindcss.com"></script>
    </head>

    <body class="bg-gray-50">
      <%@include file="navbar.jsp" %>

        <!-- Header Section -->
        <div class="bg-gradient-to-r from-green-600 to-teal-600 text-white py-12">
          <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center">
              <div>
                <h1 class="text-4xl font-bold mb-2">Categories</h1>
                <p class="text-green-100">Manage your product categories</p>
              </div>
              <a href="/servlet-jsp-gr3/categories/create"
                class="bg-white text-green-600 hover:bg-green-50 px-6 py-3 rounded-lg font-semibold transition-colors duration-200">
                <span class="inline-block mr-2">+</span> Add Category
              </a>
            </div>
          </div>
        </div>

        <!-- Main Content -->
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
          <c:if test="${empty requestScope.categories}">
            <div class="bg-blue-50 border border-blue-200 rounded-lg p-8 text-center">
              <p class="text-blue-800 text-lg">No categories available. Create one to get started!</p>
            </div>
          </c:if>

          <c:if test="${not empty requestScope.categories}">
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
              <c:forEach var="category" items="${requestScope.categories}">
                <div
                  class="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-xl transition-shadow duration-300">
                  <div class="bg-gradient-to-r from-green-500 to-teal-500 h-2"></div>
                  <div class="p-6">
                    <h3 class="text-xl font-bold text-gray-800 mb-2">${category.name}</h3>
                    <p class="text-gray-600 text-sm mb-6 line-clamp-3">${category.description}</p>
                    <div class="flex gap-3 justify-between pt-4 border-t border-gray-200">
                      <a href="/servlet-jsp-gr3/categories/edit?name=${category.name}"
                        class="flex-1 text-center bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg text-sm font-medium transition-colors duration-200">Edit</a>
                      <a href="/servlet-jsp-gr3/categories/delete?name=${category.name}"
                        onclick="return confirm('Delete category ${category.name}?');"
                        class="flex-1 text-center bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-lg text-sm font-medium transition-colors duration-200">Delete</a>
                    </div>
                  </div>
                </div>
              </c:forEach>
            </div>
          </c:if>
        </div>
    </body>

    </html>
<script src="https://cdn.tailwindcss.com"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

  <nav class="bg-white shadow-lg border-b border-gray-200">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <div class="flex justify-between items-center h-16">
        <!-- Logo -->
        <a href="/servlet-jsp-gr3/home" class="flex-shrink-0 flex items-center">
          <span
            class="text-2xl font-bold bg-gradient-to-r from-purple-600 to-pink-600 bg-clip-text text-transparent">IIT
            Store</span>
        </a>

        <!-- Navigation Links -->
        <div class="hidden md:flex space-x-8">
          <a href="/servlet-jsp-gr3/home"
            class="text-gray-700 hover:text-purple-600 px-3 py-2 text-sm font-medium transition-colors duration-200">Home</a>
          <a href="/servlet-jsp-gr3/categories"
            class="text-gray-700 hover:text-purple-600 px-3 py-2 text-sm font-medium transition-colors duration-200">Categories</a>
          <a href="/servlet-jsp-gr3/products"
            class="text-gray-700 hover:text-purple-600 px-3 py-2 text-sm font-medium transition-colors duration-200">Products</a>
          <a href="/servlet-jsp-gr3/promotions"
            class="text-gray-700 hover:text-purple-600 px-3 py-2 text-sm font-medium transition-colors duration-200">Promotions</a>
        </div>

        <!-- User Info -->
        <c:choose>
          <c:when test="${not empty sessionScope.fullname}">
            <div class="flex items-center space-x-4">
              <span class="text-gray-700 font-semibold">${sessionScope.fullname}</span>
              <a href="/servlet-jsp-gr3/logout"
                class="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-lg text-sm font-medium transition-colors duration-200">Logout</a>
            </div>
          </c:when>
          <c:otherwise>
            <a href="/servlet-jsp-gr3/login"
              class="bg-purple-600 hover:bg-purple-700 text-white px-4 py-2 rounded-lg text-sm font-medium transition-colors duration-200">Login</a>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </nav>
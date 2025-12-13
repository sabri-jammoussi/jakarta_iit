<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Manage Products - Admin</title>
                <script src="https://cdn.tailwindcss.com"></script>
            </head>

            <body class="bg-gray-100 min-h-screen">
                <%@ include file="/includes/admin-navbar.jsp" %>

                    <!-- Header Section -->
                    <div class="bg-gradient-to-r from-blue-600 to-blue-800 text-white py-8">
                        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                            <div class="flex justify-between items-center">
                                <div>
                                    <h1 class="text-3xl font-bold mb-2">Products Management</h1>
                                    <p class="text-blue-100">Manage your product catalog</p>
                                </div>
                                <a href="${pageContext.request.contextPath}/admin/products?action=add"
                                    class="bg-white text-blue-600 hover:bg-blue-50 px-6 py-3 rounded-lg font-semibold transition-colors duration-200">
                                    <span class="inline-block mr-2">+</span> Add Product
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Main Content -->
                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
                        <!-- Filter -->
                        <div class="bg-white rounded-xl shadow p-4 mb-6">
                            <div class="flex flex-wrap gap-4 items-center">
                                <select id="categoryFilter" class="px-4 py-2 border rounded-lg bg-white"
                                    onchange="filterByCategory()">
                                    <option value="">All Categories</option>
                                    <c:forEach var="cat" items="${categories}">
                                        <option value="${cat.id}">${cat.name}</option>
                                    </c:forEach>
                                </select>
                                <input type="text" id="searchFilter" placeholder="Search products..."
                                    class="px-4 py-2 border rounded-lg flex-1" onkeyup="filterProducts()" />
                            </div>
                        </div>

                        <c:if test="${empty products}">
                            <div class="bg-blue-50 border border-blue-200 rounded-lg p-8 text-center">
                                <p class="text-blue-800 text-lg">No products available. Create one to get started!</p>
                            </div>
                        </c:if>

                        <c:if test="${not empty products}">
                            <div class="bg-white rounded-xl shadow-lg overflow-hidden">
                                <div class="overflow-x-auto">
                                    <table class="w-full" id="productsTable">
                                        <thead class="bg-gray-100 border-b border-gray-200">
                                            <tr>
                                                <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">
                                                    Image</th>
                                                <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">Name
                                                </th>
                                                <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">
                                                    Price</th>
                                                <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">
                                                    Category</th>
                                                <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">
                                                    Description</th>
                                                <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">
                                                    Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody class="divide-y divide-gray-200">
                                            <c:forEach var="p" items="${products}">
                                                <tr class="hover:bg-gray-50 transition-colors duration-150"
                                                    data-category="${p.categoryId}">
                                                    <td class="px-6 py-4">
                                                        <c:choose>
                                                            <c:when test="${not empty p.imageUrl}">
                                                                <img src="${p.imageUrl}" alt="${p.name}"
                                                                    class="h-12 w-12 object-cover rounded" />
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div
                                                                    class="h-12 w-12 bg-gray-100 flex items-center justify-center text-gray-400 rounded">
                                                                    <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                                                                        stroke="currentColor">
                                                                        <path stroke-linecap="round"
                                                                            stroke-linejoin="round" stroke-width="2"
                                                                            d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                                                    </svg>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="px-6 py-4 text-sm font-medium text-gray-900">${p.name}
                                                    </td>
                                                    <td class="px-6 py-4 text-sm font-semibold text-blue-600">
                                                        <fmt:formatNumber value="${p.price}" type="currency"
                                                            currencySymbol="$" />
                                                    </td>
                                                    <td class="px-6 py-4 text-sm text-gray-600">
                                                        <c:forEach var="cat" items="${categories}">
                                                            <c:if test="${cat.id == p.categoryId}">
                                                                <span
                                                                    class="px-2 py-1 bg-gray-100 rounded-full text-xs">${cat.name}</span>
                                                            </c:if>
                                                        </c:forEach>
                                                    </td>
                                                    <td class="px-6 py-4 text-sm text-gray-600 max-w-xs truncate">
                                                        ${p.description}</td>
                                                    <td class="px-6 py-4 text-sm space-x-2">
                                                        <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${p.id}"
                                                            class="inline-block bg-blue-600 hover:bg-blue-700 text-white px-3 py-2 rounded text-xs font-medium transition-colors duration-200">
                                                            Edit
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/admin/products?action=delete&id=${p.id}"
                                                            onclick="return confirm('Delete product ${p.name}?');"
                                                            class="inline-block bg-red-600 hover:bg-red-700 text-white px-3 py-2 rounded text-xs font-medium transition-colors duration-200">
                                                            Delete
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </c:if>
                    </div>

                    <script>
                        function filterByCategory() {
                            const catId = document.getElementById('categoryFilter').value;
                            const rows = document.querySelectorAll('#productsTable tbody tr');
                            rows.forEach(row => {
                                if (!catId || row.dataset.category === catId) {
                                    row.style.display = '';
                                } else {
                                    row.style.display = 'none';
                                }
                            });
                        }

                        function filterProducts() {
                            const query = document.getElementById('searchFilter').value.toLowerCase();
                            const rows = document.querySelectorAll('#productsTable tbody tr');
                            rows.forEach(row => {
                                const text = row.textContent.toLowerCase();
                                row.style.display = text.includes(query) ? '' : 'none';
                            });
                        }
                    </script>
            </body>

            </html>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Admin Dashboard - IIT Store</title>
                <script src="https://cdn.tailwindcss.com"></script>
            </head>

            <body class="bg-gray-100 min-h-screen">
                <%@ include file="/includes/admin-navbar.jsp" %>

                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
                        <!-- Welcome Header -->
                        <div class="mb-8">
                            <h1 class="text-3xl font-bold text-gray-800">Dashboard</h1>
                            <p class="text-gray-600">Welcome back, ${sessionScope.fullname}!</p>
                        </div>

                        <!-- Stats Cards -->
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                            <!-- Products Card -->
                            <div class="bg-white rounded-xl shadow-lg p-6 border-l-4 border-blue-500">
                                <div class="flex items-center justify-between">
                                    <div>
                                        <p class="text-gray-500 text-sm font-medium">Total Products</p>
                                        <p class="text-3xl font-bold text-gray-800">${productCount}</p>
                                    </div>
                                    <div class="bg-blue-100 rounded-full p-3">
                                        <svg class="h-8 w-8 text-blue-500" fill="none" viewBox="0 0 24 24"
                                            stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
                                        </svg>
                                    </div>
                                </div>
                                <a href="${pageContext.request.contextPath}/admin/products"
                                    class="text-blue-500 hover:text-blue-700 text-sm mt-4 inline-block">
                                    View all →
                                </a>
                            </div>

                            <!-- Categories Card -->
                            <div class="bg-white rounded-xl shadow-lg p-6 border-l-4 border-green-500">
                                <div class="flex items-center justify-between">
                                    <div>
                                        <p class="text-gray-500 text-sm font-medium">Total Categories</p>
                                        <p class="text-3xl font-bold text-gray-800">${categoryCount}</p>
                                    </div>
                                    <div class="bg-green-100 rounded-full p-3">
                                        <svg class="h-8 w-8 text-green-500" fill="none" viewBox="0 0 24 24"
                                            stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" />
                                        </svg>
                                    </div>
                                </div>
                                <a href="${pageContext.request.contextPath}/admin/categories"
                                    class="text-green-500 hover:text-green-700 text-sm mt-4 inline-block">
                                    View all →
                                </a>
                            </div>

                            <!-- Promotions Card -->
                            <div class="bg-white rounded-xl shadow-lg p-6 border-l-4 border-orange-500">
                                <div class="flex items-center justify-between">
                                    <div>
                                        <p class="text-gray-500 text-sm font-medium">Total Promotions</p>
                                        <p class="text-3xl font-bold text-gray-800">${promotionCount}</p>
                                    </div>
                                    <div class="bg-orange-100 rounded-full p-3">
                                        <svg class="h-8 w-8 text-orange-500" fill="none" viewBox="0 0 24 24"
                                            stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M12 8v13m0-13V6a2 2 0 112 2h-2zm0 0V5.5A2.5 2.5 0 109.5 8H12zm-7 4h14M5 12a2 2 0 110-4h14a2 2 0 110 4M5 12v7a2 2 0 002 2h10a2 2 0 002-2v-7" />
                                        </svg>
                                    </div>
                                </div>
                                <a href="${pageContext.request.contextPath}/admin/promotions"
                                    class="text-orange-500 hover:text-orange-700 text-sm mt-4 inline-block">
                                    View all →
                                </a>
                            </div>

                            <!-- Active Promotions Card -->
                            <div class="bg-white rounded-xl shadow-lg p-6 border-l-4 border-purple-500">
                                <div class="flex items-center justify-between">
                                    <div>
                                        <p class="text-gray-500 text-sm font-medium">Active Promotions</p>
                                        <p class="text-3xl font-bold text-gray-800">${activePromotionCount}</p>
                                    </div>
                                    <div class="bg-purple-100 rounded-full p-3">
                                        <svg class="h-8 w-8 text-purple-500" fill="none" viewBox="0 0 24 24"
                                            stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                                        </svg>
                                    </div>
                                </div>
                                <span class="text-purple-500 text-sm mt-4 inline-block">
                                    Currently running
                                </span>
                            </div>
                        </div>

                        <!-- Quick Actions -->
                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                            <!-- Quick Actions Card -->
                            <div class="bg-white rounded-xl shadow-lg p-6">
                                <h2 class="text-xl font-bold text-gray-800 mb-6">Quick Actions</h2>
                                <div class="grid grid-cols-2 gap-4">
                                    <a href="${pageContext.request.contextPath}/admin/products?action=add"
                                        class="flex items-center p-4 bg-blue-50 hover:bg-blue-100 rounded-lg transition-colors duration-200">
                                        <div class="bg-blue-500 rounded-full p-2 mr-3">
                                            <svg class="h-5 w-5 text-white" fill="none" viewBox="0 0 24 24"
                                                stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M12 4v16m8-8H4" />
                                            </svg>
                                        </div>
                                        <span class="font-medium text-gray-800">Add Product</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/categories?action=add"
                                        class="flex items-center p-4 bg-green-50 hover:bg-green-100 rounded-lg transition-colors duration-200">
                                        <div class="bg-green-500 rounded-full p-2 mr-3">
                                            <svg class="h-5 w-5 text-white" fill="none" viewBox="0 0 24 24"
                                                stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M12 4v16m8-8H4" />
                                            </svg>
                                        </div>
                                        <span class="font-medium text-gray-800">Add Category</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/promotions?action=add"
                                        class="flex items-center p-4 bg-orange-50 hover:bg-orange-100 rounded-lg transition-colors duration-200">
                                        <div class="bg-orange-500 rounded-full p-2 mr-3">
                                            <svg class="h-5 w-5 text-white" fill="none" viewBox="0 0 24 24"
                                                stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M12 4v16m8-8H4" />
                                            </svg>
                                        </div>
                                        <span class="font-medium text-gray-800">Add Promotion</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/client/home"
                                        class="flex items-center p-4 bg-purple-50 hover:bg-purple-100 rounded-lg transition-colors duration-200">
                                        <div class="bg-purple-500 rounded-full p-2 mr-3">
                                            <svg class="h-5 w-5 text-white" fill="none" viewBox="0 0 24 24"
                                                stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                            </svg>
                                        </div>
                                        <span class="font-medium text-gray-800">View Store</span>
                                    </a>
                                </div>
                            </div>

                            <!-- Recent Products -->
                            <div class="bg-white rounded-xl shadow-lg p-6">
                                <h2 class="text-xl font-bold text-gray-800 mb-6">Recent Products</h2>
                                <c:choose>
                                    <c:when test="${not empty recentProducts}">
                                        <div class="space-y-4">
                                            <c:forEach var="product" items="${recentProducts}">
                                                <div
                                                    class="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
                                                    <div class="flex items-center">
                                                        <div
                                                            class="w-10 h-10 bg-gray-200 rounded-lg mr-3 flex items-center justify-center overflow-hidden">
                                                            <c:choose>
                                                                <c:when test="${not empty product.imageUrl}">
                                                                    <img src="${product.imageUrl}" alt="${product.name}"
                                                                        class="w-full h-full object-cover" />
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <svg class="h-5 w-5 text-gray-400" fill="none"
                                                                        viewBox="0 0 24 24" stroke="currentColor">
                                                                        <path stroke-linecap="round"
                                                                            stroke-linejoin="round" stroke-width="2"
                                                                            d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                                                    </svg>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <div>
                                                            <p class="font-medium text-gray-800">${product.name}</p>
                                                            <p class="text-sm text-gray-500">
                                                                <fmt:formatNumber value="${product.price}"
                                                                    type="currency" currencySymbol="$" />
                                                            </p>
                                                        </div>
                                                    </div>
                                                    <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${product.id}"
                                                        class="text-blue-500 hover:text-blue-700">
                                                        <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24"
                                                            stroke="currentColor">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2"
                                                                d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                                                        </svg>
                                                    </a>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="text-gray-500 text-center py-4">No products yet</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
            </body>

            </html>
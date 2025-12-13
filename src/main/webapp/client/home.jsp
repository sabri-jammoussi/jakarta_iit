<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>IIT Store - Home</title>
                <script src="https://cdn.tailwindcss.com"></script>
            </head>

            <body class="bg-gray-50 min-h-screen flex flex-col">
                <%@ include file="/includes/client-navbar.jsp" %>

                    <!-- Promotion Banner (if active promotions exist) -->
                    <c:if test="${not empty bestPromotion}">
                        <div class="bg-gradient-to-r from-red-500 via-orange-500 to-yellow-500 text-white py-3">
                            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                                <p class="text-lg font-semibold animate-pulse">
                                    🎉 SPECIAL OFFER: Get
                                    <fmt:formatNumber value="${bestPromotion.promotionValeur}" maxFractionDigits="0" />%
                                    OFF on all products!
                                    <span class="text-sm opacity-90">
                                        Valid until
                                        <fmt:formatDate value="${bestPromotion.datePromotionFin}"
                                            pattern="dd MMM yyyy" />
                                    </span>
                                </p>
                            </div>
                        </div>
                    </c:if>

                    <!-- Hero Section -->
                    <div class="bg-gradient-to-r from-purple-600 via-pink-600 to-red-600 text-white">
                        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-20">
                            <div class="text-center max-w-3xl mx-auto">
                                <h1 class="text-5xl md:text-6xl font-bold mb-6">Welcome to IIT Store</h1>
                                <p class="text-xl md:text-2xl text-purple-100 mb-10">Discover premium products with
                                    amazing discounts</p>
                                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                                    <a href="#products"
                                        class="bg-white text-purple-600 hover:bg-purple-50 px-8 py-3 rounded-lg font-bold text-lg transition-all duration-200 shadow-lg">
                                        Shop Now
                                    </a>
                                    <a href="${pageContext.request.contextPath}/client/cart"
                                        class="border-2 border-white text-white hover:bg-white hover:text-purple-600 px-8 py-3 rounded-lg font-bold text-lg transition-all duration-200">
                                        View Cart
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Active Promotions Display -->
                    <c:if test="${not empty activePromotions}">
                        <div class="bg-gradient-to-r from-orange-100 to-red-100 py-8">
                            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                                <h2 class="text-2xl font-bold text-gray-800 mb-6 text-center">🔥 Active Promotions</h2>
                                <div class="flex flex-wrap justify-center gap-4">
                                    <c:forEach var="promo" items="${activePromotions}">
                                        <div
                                            class="bg-white rounded-xl shadow-lg p-4 border-2 border-orange-300 transform hover:scale-105 transition-transform duration-200">
                                            <div class="text-center">
                                                <span class="text-3xl font-bold text-orange-600">
                                                    <fmt:formatNumber value="${promo.promotionValeur}"
                                                        maxFractionDigits="0" />%
                                                </span>
                                                <span class="text-lg text-gray-600 block">OFF</span>
                                                <p class="text-sm text-gray-500 mt-2">
                                                    <fmt:formatDate value="${promo.datePromotionDebut}"
                                                        pattern="dd/MM" /> -
                                                    <fmt:formatDate value="${promo.datePromotionFin}"
                                                        pattern="dd/MM/yyyy" />
                                                </p>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Category Filter -->
                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
                        <div class="flex flex-wrap items-center justify-between gap-4">
                            <h2 class="text-3xl font-bold text-gray-800">Our Products</h2>
                            <div class="flex gap-2 flex-wrap">
                                <a href="${pageContext.request.contextPath}/client/home"
                                    class="px-4 py-2 rounded-full text-sm font-medium transition-colors duration-200 
                          ${empty selectedCategory ? 'bg-purple-600 text-white' : 'bg-gray-200 text-gray-700 hover:bg-gray-300'}">
                                    All
                                </a>
                                <c:forEach var="cat" items="${categories}">
                                    <a href="${pageContext.request.contextPath}/client/home?category=${cat.id}"
                                        class="px-4 py-2 rounded-full text-sm font-medium transition-colors duration-200
                              ${selectedCategory == cat.id ? 'bg-purple-600 text-white' : 'bg-gray-200 text-gray-700 hover:bg-gray-300'}">
                                        ${cat.name}
                                    </a>
                                </c:forEach>
                            </div>
                        </div>
                    </div>

                    <!-- Products Grid -->
                    <div id="products" class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pb-16">
                        <c:if test="${empty products}">
                            <div class="bg-blue-50 border border-blue-200 rounded-lg p-12 text-center">
                                <svg class="mx-auto h-16 w-16 text-blue-400 mb-4" fill="none" viewBox="0 0 24 24"
                                    stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4" />
                                </svg>
                                <p class="text-blue-800 text-lg">No products available at the moment.</p>
                            </div>
                        </c:if>

                        <c:if test="${not empty products}">
                            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                                <c:forEach var="product" items="${products}">
                                    <div
                                        class="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-2xl transition-all duration-300 transform hover:-translate-y-1 flex flex-col">
                                        <!-- Product Image -->
                                        <div class="relative h-48 bg-gradient-to-br from-gray-100 to-gray-200">
                                            <c:choose>
                                                <c:when test="${not empty product.imageUrl}">
                                                    <img src="${product.imageUrl}" alt="${product.name}"
                                                        class="w-full h-full object-cover" />
                                                </c:when>
                                                <c:otherwise>
                                                    <div
                                                        class="w-full h-full flex items-center justify-center text-gray-400">
                                                        <svg class="h-16 w-16" fill="none" viewBox="0 0 24 24"
                                                            stroke="currentColor">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2"
                                                                d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                                        </svg>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>

                                            <!-- Promotion Badge -->
                                            <c:if test="${not empty bestPromotion}">
                                                <span
                                                    class="absolute top-2 right-2 bg-red-500 text-white text-xs font-bold px-2 py-1 rounded-full">
                                                    -
                                                    <fmt:formatNumber value="${bestPromotion.promotionValeur}"
                                                        maxFractionDigits="0" />%
                                                </span>
                                            </c:if>
                                        </div>

                                        <!-- Product Info -->
                                        <div class="p-4 flex-1 flex flex-col">
                                            <!-- Category Badge -->
                                            <c:forEach var="cat" items="${categories}">
                                                <c:if test="${cat.id == product.categoryId}">
                                                    <span
                                                        class="inline-block px-2 py-1 bg-purple-100 text-purple-700 text-xs font-medium rounded-full mb-2 w-fit">
                                                        ${cat.name}
                                                    </span>
                                                </c:if>
                                            </c:forEach>

                                            <h3 class="text-lg font-semibold text-gray-800 mb-2 line-clamp-2">
                                                ${product.name}</h3>

                                            <p class="text-gray-600 text-sm mb-4 line-clamp-2 flex-1">
                                                ${product.description}</p>

                                            <!-- Price -->
                                            <div class="mb-4">
                                                <c:choose>
                                                    <c:when test="${not empty bestPromotion}">
                                                        <span class="text-gray-400 line-through text-sm">
                                                            <fmt:formatNumber value="${product.price}" type="currency"
                                                                currencySymbol="$" />
                                                        </span>
                                                        <span class="text-2xl font-bold text-green-600 ml-2">
                                                            <fmt:formatNumber
                                                                value="${product.price * (1 - bestPromotion.promotionValeur/100)}"
                                                                type="currency" currencySymbol="$" />
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-2xl font-bold text-purple-600">
                                                            <fmt:formatNumber value="${product.price}" type="currency"
                                                                currencySymbol="$" />
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                            <!-- Actions -->
                                            <div class="flex gap-2">
                                                <a href="${pageContext.request.contextPath}/client/product?action=view&id=${product.id}"
                                                    class="flex-1 text-center bg-gray-100 hover:bg-gray-200 text-gray-700 px-4 py-2 rounded-lg text-sm font-medium transition-colors duration-200">
                                                    View Details
                                                </a>
                                                <form action="${pageContext.request.contextPath}/client/cart"
                                                    method="post" class="flex-1">
                                                    <input type="hidden" name="action" value="add" />
                                                    <input type="hidden" name="productId" value="${product.id}" />
                                                    <input type="hidden" name="quantity" value="1" />
                                                    <button type="submit"
                                                        class="w-full bg-purple-600 hover:bg-purple-700 text-white px-4 py-2 rounded-lg text-sm font-medium transition-colors duration-200 flex items-center justify-center gap-2">
                                                        <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24"
                                                            stroke="currentColor">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2"
                                                                d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
                                                        </svg>
                                                        Add to Cart
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:if>
                    </div>

                    <%@ include file="/includes/footer.jsp" %>
            </body>

            </html>
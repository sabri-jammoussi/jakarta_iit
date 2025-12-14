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

            <body class="bg-slate-50 min-h-screen flex flex-col">
                <%@ include file="/includes/client-navbar.jsp" %>

                    <!-- Promotion Banner -->
                    <c:if test="${not empty bestPromotion}">
                        <div class="bg-amber-50 border-b border-amber-100">
                            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-3 text-center">
                                <p class="text-amber-800 text-sm font-medium">
                                    <span class="inline-flex items-center">
                                        <svg class="h-4 w-4 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M12 8v13m0-13V6a2 2 0 112 2h-2zm0 0V5.5A2.5 2.5 0 109.5 8H12zm-7 4h14M5 12a2 2 0 110-4h14a2 2 0 110 4M5 12v7a2 2 0 002 2h10a2 2 0 002-2v-7" />
                                        </svg>
                                        Special offer:
                                        <fmt:formatNumber value="${bestPromotion.promotionValeur}"
                                            maxFractionDigits="0" />% off all products
                                        <span class="text-amber-600 ml-2">
                                            &bull; Until
                                            <fmt:formatDate value="${bestPromotion.datePromotionFin}"
                                                pattern="MMM dd" />
                                        </span>
                                    </span>
                                </p>
                            </div>
                        </div>
                    </c:if>

                    <!-- Hero Section -->
                    <!-- <div class="bg-white border-b border-gray-100">
                        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
                            <div class="text-center max-w-2xl mx-auto">
                                <h1 class="text-3xl md:text-4xl font-semibold text-gray-900 mb-4">Welcome to IIT Store
                                </h1>
                                <p class="text-gray-500 text-base leading-relaxed mb-8">
                                    Discover our curated collection of quality products at great prices.
                                </p>
                                <div class="flex flex-col sm:flex-row gap-3 justify-center">
                                    <a href="#products"
                                        class="bg-indigo-600 hover:bg-indigo-700 text-white px-6 py-3 rounded-lg text-sm font-medium">
                                        Browse Products
                                    </a>
                                    <a href="${pageContext.request.contextPath}/client/cart"
                                        class="border border-gray-300 hover:border-gray-400 text-gray-700 px-6 py-3 rounded-lg text-sm font-medium">
                                        View Cart
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div> -->

                    <!-- Active Promotions -->
                    <!-- <c:if test="${not empty activePromotions}">
                        <div class="bg-emerald-50 border-b border-emerald-100">
                            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6">
                                <div class="flex flex-wrap justify-center gap-4">
                                    <c:forEach var="promo" items="${activePromotions}">
                                        <div
                                            class="bg-white rounded-lg border border-emerald-200 px-4 py-3 text-center">
                                            <span class="text-2xl font-semibold text-emerald-600">
                                                <fmt:formatNumber value="${promo.promotionValeur}"
                                                    maxFractionDigits="0" />%
                                            </span>
                                            <span class="text-gray-500 text-sm block">off</span>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </c:if> -->

                    <!-- Category Filter -->
                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
                        <div class="flex flex-wrap items-center justify-between gap-4">
                            <h2 class="text-2xl font-semibold text-gray-900">Products</h2>
                            <div class="flex gap-2 flex-wrap">
                                <a href="${pageContext.request.contextPath}/client/home"
                                    class="px-4 py-2 rounded-lg text-sm font-medium ${empty selectedCategory ? 'bg-indigo-600 text-white' : 'bg-white border border-gray-200 text-gray-600 hover:border-gray-300'}">
                                    All
                                </a>
                                <c:forEach var="cat" items="${categories}">
                                    <a href="${pageContext.request.contextPath}/client/home?category=${cat.id}"
                                        class="px-4 py-2 rounded-lg text-sm font-medium ${selectedCategory == cat.id ? 'bg-indigo-600 text-white' : 'bg-white border border-gray-200 text-gray-600 hover:border-gray-300'}">
                                        ${cat.name}
                                    </a>
                                </c:forEach>
                            </div>
                        </div>
                    </div>

                    <!-- Products Grid -->
                    <div id="products" class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pb-16 flex-1">
                        <c:if test="${empty products}">
                            <div class="bg-white border border-gray-200 rounded-lg p-12 text-center">
                                <p class="text-gray-500">No products available at the moment.</p>
                            </div>
                        </c:if>

                        <c:if test="${not empty products}">
                            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                                <c:forEach var="product" items="${products}">
                                    <div
                                        class="bg-white rounded-lg border border-gray-200 overflow-hidden hover:shadow-md transition-shadow duration-200 flex flex-col">
                                        <!-- Product Image -->
                                        <div class="relative h-48 bg-gray-100">
                                            <c:choose>
                                                <c:when test="${not empty product.imageUrl}">
                                                    <img src="${product.imageUrl}" alt="${product.name}"
                                                        class="w-full h-full object-cover" />
                                                </c:when>
                                                <c:otherwise>
                                                    <div
                                                        class="w-full h-full flex items-center justify-center text-gray-300">
                                                        <svg class="h-12 w-12" fill="none" viewBox="0 0 24 24"
                                                            stroke="currentColor">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="1.5"
                                                                d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                                        </svg>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                            <c:if test="${not empty bestPromotion}">
                                                <span
                                                    class="absolute top-2 right-2 bg-emerald-500 text-white text-xs font-medium px-2 py-1 rounded">
                                                    -
                                                    <fmt:formatNumber value="${bestPromotion.promotionValeur}"
                                                        maxFractionDigits="0" />%
                                                </span>
                                            </c:if>
                                        </div>

                                        <!-- Product Info -->
                                        <div class="p-4 flex-1 flex flex-col">
                                            <!-- Category -->
                                            <c:forEach var="cat" items="${categories}">
                                                <c:if test="${cat.id == product.categoryId}">
                                                    <span class="text-xs text-gray-400 mb-1">${cat.name}</span>
                                                </c:if>
                                            </c:forEach>

                                            <h3 class="text-sm font-medium text-gray-900 mb-2 line-clamp-2">
                                                ${product.name}</h3>

                                            <p class="text-gray-500 text-xs mb-4 line-clamp-2 flex-1">
                                                ${product.description}</p>

                                            <!-- Price -->
                                            <div class="mb-4">
                                                <c:choose>
                                                    <c:when test="${not empty bestPromotion}">
                                                        <span class="text-gray-400 line-through text-xs">
                                                            <fmt:formatNumber value="${product.price}" type="currency"
                                                                currencySymbol="$" />
                                                        </span>
                                                        <span class="text-lg font-semibold text-gray-900 ml-1">
                                                            <fmt:formatNumber
                                                                value="${product.price * (1 - bestPromotion.promotionValeur/100)}"
                                                                type="currency" currencySymbol="$" />
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-lg font-semibold text-gray-900">
                                                            <fmt:formatNumber value="${product.price}" type="currency"
                                                                currencySymbol="$" />
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                            <!-- Actions -->
                                            <div class="flex gap-2">
                                                <a href="${pageContext.request.contextPath}/client/product?action=view&id=${product.id}"
                                                    class="flex-1 text-center border border-gray-200 hover:border-gray-300 text-gray-600 px-3 py-2 rounded-lg text-sm font-medium">
                                                    Details
                                                </a>
                                                <form action="${pageContext.request.contextPath}/client/cart"
                                                    method="post" class="flex-1">
                                                    <input type="hidden" name="action" value="add" />
                                                    <input type="hidden" name="productId" value="${product.id}" />
                                                    <input type="hidden" name="quantity" value="1" />
                                                    <button type="submit"
                                                        class="w-full bg-indigo-600 hover:bg-indigo-700 text-white px-3 py-2 rounded-lg text-sm font-medium">
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
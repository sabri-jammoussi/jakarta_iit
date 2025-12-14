<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Products - IIT Store</title>
                <script src="https://cdn.tailwindcss.com"></script>
            </head>

            <body class="bg-slate-50 min-h-screen flex flex-col">
                <%@ include file="/includes/client-navbar.jsp" %>

                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10 flex-1">
                        <!-- Page Header -->
                        <div class="mb-8">
                            <h1 class="text-2xl font-semibold text-gray-900">Products</h1>
                            <p class="text-gray-500 text-sm mt-1">Browse our collection</p>
                        </div>

                        <!-- Category Filter -->
                        <div class="mb-8">
                            <div class="flex flex-wrap gap-2">
                                <a href="${pageContext.request.contextPath}/client/products"
                                    class="px-4 py-2 rounded-lg text-sm font-medium transition-colors
                    ${empty selectedCategory ? 'bg-indigo-600 text-white' : 'bg-white border border-gray-200 text-gray-600 hover:border-gray-300'}">
                                    All
                                </a>
                                <c:forEach var="cat" items="${categories}">
                                    <a href="${pageContext.request.contextPath}/client/products?category=${cat.id}"
                                        class="px-4 py-2 rounded-lg text-sm font-medium transition-colors
                        ${selectedCategory == cat.id ? 'bg-indigo-600 text-white' : 'bg-white border border-gray-200 text-gray-600 hover:border-gray-300'}">
                                        ${cat.name}
                                    </a>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Empty State -->
                        <c:if test="${empty products}">
                            <div class="bg-white border border-gray-200 rounded-lg p-12 text-center">
                                <svg class="h-12 w-12 text-gray-300 mx-auto mb-4" fill="none" viewBox="0 0 24 24"
                                    stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1"
                                        d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
                                </svg>
                                <p class="text-gray-500">No products available in this category.</p>
                            </div>
                        </c:if>

                        <!-- Products Grid -->
                        <c:if test="${not empty products}">
                            <div class="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-6">
                                <c:forEach var="product" items="${products}">
                                    <div
                                        class="bg-white border border-gray-200 rounded-lg overflow-hidden hover:shadow-md transition-shadow">
                                        <!-- Product Image -->
                                        <a href="${pageContext.request.contextPath}/client/product?action=view&id=${product.id}"
                                            class="block">
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
                                                                    stroke-width="1"
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
                                        </a>

                                        <!-- Product Info -->
                                        <div class="p-4">
                                            <!-- Category -->
                                            <c:forEach var="cat" items="${categories}">
                                                <c:if test="${cat.id == product.categoryId}">
                                                    <span
                                                        class="text-xs text-gray-400 uppercase tracking-wide">${cat.name}</span>
                                                </c:if>
                                            </c:forEach>

                                            <a href="${pageContext.request.contextPath}/client/product?action=view&id=${product.id}"
                                                class="block mt-1 mb-2">
                                                <h3
                                                    class="text-sm font-medium text-gray-900 line-clamp-2 hover:text-indigo-600 transition-colors">
                                                    ${product.name}</h3>
                                            </a>

                                            <!-- Price -->
                                            <div class="mb-3">
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

                                            <!-- Add to Cart -->
                                            <form action="${pageContext.request.contextPath}/client/cart" method="post">
                                                <input type="hidden" name="action" value="add" />
                                                <input type="hidden" name="productId" value="${product.id}" />
                                                <input type="hidden" name="quantity" value="1" />
                                                <button type="submit"
                                                    class="w-full bg-indigo-600 hover:bg-indigo-700 text-white py-2 rounded-lg text-sm font-medium transition-colors">
                                                    Add to Cart
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:if>
                    </div>

                    <%@ include file="/includes/footer.jsp" %>
            </body>

            </html>
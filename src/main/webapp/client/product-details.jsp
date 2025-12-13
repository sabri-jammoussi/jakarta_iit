<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>${product.name} - IIT Store</title>
                <script src="https://cdn.tailwindcss.com"></script>
            </head>

            <body class="bg-gray-50 min-h-screen flex flex-col">
                <%@ include file="/includes/client-navbar.jsp" %>

                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 flex-1">
                        <!-- Breadcrumb -->
                        <nav class="mb-8">
                            <ol class="flex items-center space-x-2 text-sm text-gray-500">
                                <li><a href="${pageContext.request.contextPath}/client/home"
                                        class="hover:text-purple-600">Home</a></li>
                                <li><span>/</span></li>
                                <li><a href="${pageContext.request.contextPath}/client/products"
                                        class="hover:text-purple-600">Products</a></li>
                                <li><span>/</span></li>
                                <li class="text-gray-800 font-medium">${product.name}</li>
                            </ol>
                        </nav>

                        <div class="bg-white rounded-2xl shadow-lg overflow-hidden">
                            <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                                <!-- Product Image -->
                                <div class="relative h-96 lg:h-full bg-gradient-to-br from-gray-100 to-gray-200">
                                    <c:choose>
                                        <c:when test="${not empty product.imageUrl}">
                                            <img src="${product.imageUrl}" alt="${product.name}"
                                                class="w-full h-full object-cover" />
                                        </c:when>
                                        <c:otherwise>
                                            <div class="w-full h-full flex items-center justify-center text-gray-400">
                                                <svg class="h-32 w-32" fill="none" viewBox="0 0 24 24"
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
                                            class="absolute top-4 right-4 bg-red-500 text-white text-lg font-bold px-4 py-2 rounded-full shadow-lg">
                                            -
                                            <fmt:formatNumber value="${bestPromotion.promotionValeur}"
                                                maxFractionDigits="0" />% OFF
                                        </span>
                                    </c:if>
                                </div>

                                <!-- Product Details -->
                                <div class="p-8 lg:p-12">
                                    <!-- Category -->
                                    <c:if test="${not empty category}">
                                        <span
                                            class="inline-block px-3 py-1 bg-purple-100 text-purple-700 text-sm font-medium rounded-full mb-4">
                                            ${category.name}
                                        </span>
                                    </c:if>

                                    <h1 class="text-3xl lg:text-4xl font-bold text-gray-800 mb-4">${product.name}</h1>

                                    <!-- Price -->
                                    <div class="mb-6">
                                        <c:choose>
                                            <c:when test="${not empty bestPromotion}">
                                                <div class="flex items-center gap-4">
                                                    <span class="text-gray-400 line-through text-xl">
                                                        <fmt:formatNumber value="${product.price}" type="currency"
                                                            currencySymbol="$" />
                                                    </span>
                                                    <span class="text-4xl font-bold text-green-600">
                                                        <fmt:formatNumber
                                                            value="${product.price * (1 - bestPromotion.promotionValeur/100)}"
                                                            type="currency" currencySymbol="$" />
                                                    </span>
                                                </div>
                                                <p class="text-green-600 text-sm mt-2">
                                                    You save:
                                                    <fmt:formatNumber
                                                        value="${product.price * bestPromotion.promotionValeur/100}"
                                                        type="currency" currencySymbol="$" />
                                                </p>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-4xl font-bold text-purple-600">
                                                    <fmt:formatNumber value="${product.price}" type="currency"
                                                        currencySymbol="$" />
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <!-- Description -->
                                    <div class="mb-8">
                                        <h3 class="text-lg font-semibold text-gray-800 mb-2">Description</h3>
                                        <p class="text-gray-600 leading-relaxed">
                                            <c:choose>
                                                <c:when test="${not empty product.description}">
                                                    ${product.description}
                                                </c:when>
                                                <c:otherwise>
                                                    No description available for this product.
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>

                                    <!-- Quantity Selector -->
                                    <form action="${pageContext.request.contextPath}/client/cart" method="post"
                                        class="mb-6">
                                        <input type="hidden" name="action" value="add" />
                                        <input type="hidden" name="productId" value="${product.id}" />

                                        <div class="flex items-center gap-4 mb-6">
                                            <label class="text-gray-700 font-medium">Quantity:</label>
                                            <div class="flex items-center border border-gray-300 rounded-lg">
                                                <button type="button" onclick="decrementQty()"
                                                    class="px-4 py-2 text-gray-600 hover:bg-gray-100 transition-colors">-</button>
                                                <input type="number" name="quantity" id="quantity" value="1" min="1"
                                                    max="99"
                                                    class="w-16 text-center border-x border-gray-300 py-2 focus:outline-none" />
                                                <button type="button" onclick="incrementQty()"
                                                    class="px-4 py-2 text-gray-600 hover:bg-gray-100 transition-colors">+</button>
                                            </div>
                                        </div>

                                        <button type="submit"
                                            class="w-full bg-purple-600 hover:bg-purple-700 text-white py-4 rounded-xl text-lg font-semibold transition-colors duration-200 flex items-center justify-center gap-3">
                                            <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
                                            </svg>
                                            Add to Cart
                                        </button>
                                    </form>

                                    <!-- Additional Info -->
                                    <div class="border-t border-gray-200 pt-6">
                                        <div class="grid grid-cols-2 gap-4 text-sm">
                                            <div class="flex items-center text-gray-600">
                                                <svg class="h-5 w-5 mr-2 text-green-500" fill="none" viewBox="0 0 24 24"
                                                    stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2" d="M5 13l4 4L19 7" />
                                                </svg>
                                                In Stock
                                            </div>
                                            <div class="flex items-center text-gray-600">
                                                <svg class="h-5 w-5 mr-2 text-blue-500" fill="none" viewBox="0 0 24 24"
                                                    stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
                                                </svg>
                                                Free Shipping
                                            </div>
                                            <div class="flex items-center text-gray-600">
                                                <svg class="h-5 w-5 mr-2 text-purple-500" fill="none"
                                                    viewBox="0 0 24 24" stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
                                                </svg>
                                                Quality Guaranteed
                                            </div>
                                            <div class="flex items-center text-gray-600">
                                                <svg class="h-5 w-5 mr-2 text-orange-500" fill="none"
                                                    viewBox="0 0 24 24" stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
                                                </svg>
                                                30-Day Returns
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Back Button -->
                        <div class="mt-8">
                            <a href="${pageContext.request.contextPath}/client/home"
                                class="inline-flex items-center text-purple-600 hover:text-purple-700 font-medium">
                                <svg class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                                </svg>
                                Back to Products
                            </a>
                        </div>
                    </div>

                    <%@ include file="/includes/footer.jsp" %>

                        <script>
                            function incrementQty() {
                                const input = document.getElementById('quantity');
                                if (parseInt(input.value) < 99) {
                                    input.value = parseInt(input.value) + 1;
                                }
                            }
                            function decrementQty() {
                                const input = document.getElementById('quantity');
                                if (parseInt(input.value) > 1) {
                                    input.value = parseInt(input.value) - 1;
                                }
                            }
                        </script>
            </body>

            </html>
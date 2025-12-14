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

            <body class="bg-slate-50 min-h-screen flex flex-col">
                <%@ include file="/includes/client-navbar.jsp" %>

                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10 flex-1">
                        <!-- Breadcrumb -->
                        <nav class="mb-6">
                            <ol class="flex items-center space-x-2 text-sm text-gray-500">
                                <li><a href="${pageContext.request.contextPath}/client/home"
                                        class="hover:text-indigo-600">Home</a></li>
                                <li><span class="text-gray-300">/</span></li>
                                <li><a href="${pageContext.request.contextPath}/client/products"
                                        class="hover:text-indigo-600">Products</a></li>
                                <li><span class="text-gray-300">/</span></li>
                                <li class="text-gray-900">${product.name}</li>
                            </ol>
                        </nav>

                        <div class="bg-white border border-gray-200 rounded-lg overflow-hidden">
                            <div class="grid grid-cols-1 lg:grid-cols-2">
                                <!-- Product Image -->
                                <div class="relative bg-gray-100 h-80 lg:h-auto">
                                    <c:choose>
                                        <c:when test="${not empty product.imageUrl}">
                                            <img src="${product.imageUrl}" alt="${product.name}"
                                                class="w-full h-full object-cover" />
                                        </c:when>
                                        <c:otherwise>
                                            <div class="w-full h-full flex items-center justify-center text-gray-300">
                                                <svg class="h-24 w-24" fill="none" viewBox="0 0 24 24"
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
                                            class="absolute top-4 right-4 bg-emerald-500 text-white text-sm font-medium px-3 py-1 rounded-lg">
                                            -
                                            <fmt:formatNumber value="${bestPromotion.promotionValeur}"
                                                maxFractionDigits="0" />% off
                                        </span>
                                    </c:if>
                                </div>

                                <!-- Product Details -->
                                <div class="p-8 lg:p-10">
                                    <!-- Category -->
                                    <c:if test="${not empty category}">
                                        <span
                                            class="text-xs text-gray-400 uppercase tracking-wide">${category.name}</span>
                                    </c:if>

                                    <h1 class="text-2xl font-semibold text-gray-900 mt-2 mb-4">${product.name}</h1>

                                    <!-- Price -->
                                    <div class="mb-6">
                                        <c:choose>
                                            <c:when test="${not empty bestPromotion}">
                                                <div class="flex items-baseline gap-3">
                                                    <span class="text-gray-400 line-through text-lg">
                                                        <fmt:formatNumber value="${product.price}" type="currency"
                                                            currencySymbol="$" />
                                                    </span>
                                                    <span class="text-3xl font-semibold text-gray-900">
                                                        <fmt:formatNumber
                                                            value="${product.price * (1 - bestPromotion.promotionValeur/100)}"
                                                            type="currency" currencySymbol="$" />
                                                    </span>
                                                </div>
                                                <p class="text-emerald-600 text-sm mt-1">
                                                    You save
                                                    <fmt:formatNumber
                                                        value="${product.price * bestPromotion.promotionValeur/100}"
                                                        type="currency" currencySymbol="$" />
                                                </p>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-3xl font-semibold text-gray-900">
                                                    <fmt:formatNumber value="${product.price}" type="currency"
                                                        currencySymbol="$" />
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <!-- Description -->
                                    <div class="mb-8">
                                        <h3 class="text-sm font-medium text-gray-900 mb-2">Description</h3>
                                        <p class="text-gray-500 text-sm leading-relaxed">
                                            <c:choose>
                                                <c:when test="${not empty product.description}">${product.description}
                                                </c:when>
                                                <c:otherwise>No description available for this product.</c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>

                                    <!-- Add to Cart Form -->
                                    <form action="${pageContext.request.contextPath}/client/cart" method="post">
                                        <input type="hidden" name="action" value="add" />
                                        <input type="hidden" name="productId" value="${product.id}" />

                                        <div class="flex items-center gap-4 mb-6">
                                            <label class="text-gray-700 text-sm font-medium">Quantity:</label>
                                            <div class="flex items-center border border-gray-200 rounded-lg">
                                                <button type="button" onclick="decrementQty()"
                                                    class="px-3 py-2 text-gray-500 hover:bg-gray-50">-</button>
                                                <input type="number" name="quantity" id="quantity" value="1" min="1"
                                                    max="99"
                                                    class="w-14 text-center border-x border-gray-200 py-2 text-sm focus:outline-none" />
                                                <button type="button" onclick="incrementQty()"
                                                    class="px-3 py-2 text-gray-500 hover:bg-gray-50">+</button>
                                            </div>
                                        </div>

                                        <button type="submit"
                                            class="w-full bg-indigo-600 hover:bg-indigo-700 text-white py-3 rounded-lg font-medium text-sm flex items-center justify-center gap-2">
                                            <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
                                            </svg>
                                            Add to Cart
                                        </button>
                                    </form>

                                    <!-- Extra Info -->
                                    <div class="mt-8 pt-6 border-t border-gray-100">
                                        <div class="grid grid-cols-2 gap-4 text-sm">
                                            <div class="flex items-center text-gray-500">
                                                <svg class="h-4 w-4 mr-2 text-gray-400" fill="none" viewBox="0 0 24 24"
                                                    stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M5 8h14M5 8a2 2 0 110-4h14a2 2 0 110 4M5 8v10a2 2 0 002 2h10a2 2 0 002-2V8m-9 4h4" />
                                                </svg>
                                                Free shipping
                                            </div>
                                            <div class="flex items-center text-gray-500">
                                                <svg class="h-4 w-4 mr-2 text-gray-400" fill="none" viewBox="0 0 24 24"
                                                    stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
                                                </svg>
                                                Secure payment
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%@ include file="/includes/footer.jsp" %>

                        <script>
                            function incrementQty() {
                                var qty = document.getElementById('quantity');
                                if (parseInt(qty.value) < 99) qty.value = parseInt(qty.value) + 1;
                            }
                            function decrementQty() {
                                var qty = document.getElementById('quantity');
                                if (parseInt(qty.value) > 1) qty.value = parseInt(qty.value) - 1;
                            }
                        </script>
            </body>

            </html>
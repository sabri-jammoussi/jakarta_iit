<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Shopping Cart - IIT Store</title>
                <script src="https://cdn.tailwindcss.com"></script>
            </head>

            <body class="bg-gray-50 min-h-screen flex flex-col">
                <%@ include file="/includes/client-navbar.jsp" %>

                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 flex-1">
                        <h1 class="text-3xl font-bold text-gray-800 mb-8">Shopping Cart</h1>

                        <c:choose>
                            <c:when test="${empty cartItems}">
                                <!-- Empty Cart -->
                                <div class="bg-white rounded-2xl shadow-lg p-12 text-center">
                                    <svg class="mx-auto h-24 w-24 text-gray-300 mb-6" fill="none" viewBox="0 0 24 24"
                                        stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
                                    </svg>
                                    <h2 class="text-2xl font-semibold text-gray-700 mb-4">Your cart is empty</h2>
                                    <p class="text-gray-500 mb-8">Looks like you haven't added anything to your cart
                                        yet.</p>
                                    <a href="${pageContext.request.contextPath}/client/home"
                                        class="inline-block bg-purple-600 hover:bg-purple-700 text-white px-8 py-3 rounded-lg font-semibold transition-colors duration-200">
                                        Continue Shopping
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                                    <!-- Cart Items -->
                                    <div class="lg:col-span-2">
                                        <div class="bg-white rounded-2xl shadow-lg overflow-hidden">
                                            <div class="divide-y divide-gray-200">
                                                <c:forEach var="item" items="${cartItems}">
                                                    <div class="p-6 flex items-center gap-6">
                                                        <!-- Product Image -->
                                                        <div
                                                            class="flex-shrink-0 w-24 h-24 bg-gray-100 rounded-lg overflow-hidden">
                                                            <c:choose>
                                                                <c:when test="${not empty item.product.imageUrl}">
                                                                    <img src="${item.product.imageUrl}"
                                                                        alt="${item.product.name}"
                                                                        class="w-full h-full object-cover" />
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <div
                                                                        class="w-full h-full flex items-center justify-center text-gray-400">
                                                                        <svg class="h-8 w-8" fill="none"
                                                                            viewBox="0 0 24 24" stroke="currentColor">
                                                                            <path stroke-linecap="round"
                                                                                stroke-linejoin="round" stroke-width="2"
                                                                                d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                                                        </svg>
                                                                    </div>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>

                                                        <!-- Product Info -->
                                                        <div class="flex-1 min-w-0">
                                                            <h3 class="text-lg font-semibold text-gray-800 truncate">
                                                                ${item.product.name}</h3>
                                                            <p class="text-purple-600 font-medium">
                                                                <fmt:formatNumber value="${item.product.price}"
                                                                    type="currency" currencySymbol="$" />
                                                            </p>
                                                        </div>

                                                        <!-- Quantity -->
                                                        <form action="${pageContext.request.contextPath}/client/cart"
                                                            method="post" class="flex items-center gap-2">
                                                            <input type="hidden" name="action" value="update" />
                                                            <input type="hidden" name="productId"
                                                                value="${item.product.id}" />
                                                            <div
                                                                class="flex items-center border border-gray-300 rounded-lg">
                                                                <button type="submit" name="quantity"
                                                                    value="${item.quantity - 1}"
                                                                    class="px-3 py-1 text-gray-600 hover:bg-gray-100">-</button>
                                                                <span
                                                                    class="px-4 py-1 border-x border-gray-300">${item.quantity}</span>
                                                                <button type="submit" name="quantity"
                                                                    value="${item.quantity + 1}"
                                                                    class="px-3 py-1 text-gray-600 hover:bg-gray-100">+</button>
                                                            </div>
                                                        </form>

                                                        <!-- Item Total -->
                                                        <div class="text-right">
                                                            <p class="text-lg font-semibold text-gray-800">
                                                                <fmt:formatNumber value="${item.itemTotal}"
                                                                    type="currency" currencySymbol="$" />
                                                            </p>
                                                        </div>

                                                        <!-- Remove Button -->
                                                        <a href="${pageContext.request.contextPath}/client/cart?action=remove&productId=${item.product.id}"
                                                            class="text-red-500 hover:text-red-700 transition-colors duration-200">
                                                            <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                                                                stroke="currentColor">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    stroke-width="2"
                                                                    d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                                                            </svg>
                                                        </a>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>

                                        <!-- Clear Cart -->
                                        <div class="mt-4 flex justify-between items-center">
                                            <a href="${pageContext.request.contextPath}/client/home"
                                                class="text-purple-600 hover:text-purple-700 font-medium flex items-center">
                                                <svg class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24"
                                                    stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                                                </svg>
                                                Continue Shopping
                                            </a>
                                            <a href="${pageContext.request.contextPath}/client/cart?action=clear"
                                                onclick="return confirm('Are you sure you want to clear your cart?');"
                                                class="text-red-500 hover:text-red-700 font-medium">
                                                Clear Cart
                                            </a>
                                        </div>
                                    </div>

                                    <!-- Order Summary -->
                                    <div class="lg:col-span-1">
                                        <div class="bg-white rounded-2xl shadow-lg p-6 sticky top-24">
                                            <h2 class="text-xl font-bold text-gray-800 mb-6">Order Summary</h2>

                                            <div class="space-y-4 mb-6">
                                                <div class="flex justify-between text-gray-600">
                                                    <span>Subtotal</span>
                                                    <span>
                                                        <fmt:formatNumber value="${subtotal}" type="currency"
                                                            currencySymbol="$" />
                                                    </span>
                                                </div>

                                                <c:if test="${discount > 0}">
                                                    <div class="flex justify-between text-green-600">
                                                        <span>Discount (
                                                            <fmt:formatNumber value="${bestPromotion.promotionValeur}"
                                                                maxFractionDigits="0" />%)
                                                        </span>
                                                        <span>-
                                                            <fmt:formatNumber value="${discount}" type="currency"
                                                                currencySymbol="$" />
                                                        </span>
                                                    </div>
                                                </c:if>

                                                <div class="flex justify-between text-gray-600">
                                                    <span>Shipping</span>
                                                    <span class="text-green-600">Free</span>
                                                </div>

                                                <hr class="border-gray-200" />

                                                <div class="flex justify-between text-xl font-bold text-gray-800">
                                                    <span>Total</span>
                                                    <span>
                                                        <fmt:formatNumber value="${total}" type="currency"
                                                            currencySymbol="$" />
                                                    </span>
                                                </div>
                                            </div>

                                            <!-- Promotion Notice -->
                                            <c:if test="${not empty bestPromotion}">
                                                <div class="bg-green-50 border border-green-200 rounded-lg p-4 mb-6">
                                                    <div class="flex items-center">
                                                        <svg class="h-5 w-5 text-green-500 mr-2" fill="none"
                                                            viewBox="0 0 24 24" stroke="currentColor">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2"
                                                                d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                                                        </svg>
                                                        <span class="text-green-700 text-sm font-medium">
                                                            <fmt:formatNumber value="${bestPromotion.promotionValeur}"
                                                                maxFractionDigits="0" />% promotion applied!
                                                        </span>
                                                    </div>
                                                </div>
                                            </c:if>

                                            <form action="${pageContext.request.contextPath}/client/checkout"
                                                method="post">
                                                <button type="submit"
                                                    class="w-full bg-purple-600 hover:bg-purple-700 text-white py-4 rounded-xl font-semibold text-lg transition-colors duration-200">
                                                    Proceed to Checkout
                                                </button>
                                            </form>

                                            <p class="text-center text-gray-500 text-sm mt-4">
                                                Secure checkout powered by SSL
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <%@ include file="/includes/footer.jsp" %>
            </body>

            </html>
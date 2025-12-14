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

            <body class="bg-slate-50 min-h-screen flex flex-col">
                <%@ include file="/includes/client-navbar.jsp" %>

                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10 flex-1">
                        <h1 class="text-2xl font-semibold text-gray-900 mb-8">Shopping Cart</h1>

                        <c:choose>
                            <c:when test="${empty cartItems}">
                                <!-- Empty Cart -->
                                <div class="bg-white border border-gray-200 rounded-lg p-12 text-center">
                                    <svg class="mx-auto h-16 w-16 text-gray-300 mb-4" fill="none" viewBox="0 0 24 24"
                                        stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                            d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
                                    </svg>
                                    <h2 class="text-lg font-medium text-gray-900 mb-2">Your cart is empty</h2>
                                    <p class="text-gray-500 text-sm mb-6">Start adding products to your cart.</p>
                                    <a href="${pageContext.request.contextPath}/client/home"
                                        class="inline-block bg-indigo-600 hover:bg-indigo-700 text-white px-6 py-2 rounded-lg text-sm font-medium">
                                        Continue Shopping
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                                    <!-- Cart Items -->
                                    <div class="lg:col-span-2">
                                        <div class="bg-white border border-gray-200 rounded-lg overflow-hidden">
                                            <!-- Table Header -->
                                            <div
                                                class="hidden md:grid grid-cols-12 gap-4 px-6 py-3 bg-gray-50 border-b border-gray-200 text-xs font-medium text-gray-500 uppercase">
                                                <div class="col-span-6">Product</div>
                                                <div class="col-span-2 text-center">Quantity</div>
                                                <div class="col-span-2 text-right">Price</div>
                                                <div class="col-span-2 text-right">Total</div>
                                            </div>

                                            <div class="divide-y divide-gray-100">
                                                <c:forEach var="item" items="${cartItems}">
                                                    <div
                                                        class="p-6 grid grid-cols-1 md:grid-cols-12 gap-4 items-center">
                                                        <!-- Product -->
                                                        <div class="md:col-span-6 flex items-center gap-4">
                                                            <div
                                                                class="w-16 h-16 bg-gray-100 rounded-lg overflow-hidden flex-shrink-0">
                                                                <c:choose>
                                                                    <c:when test="${not empty item.product.imageUrl}">
                                                                        <img src="${item.product.imageUrl}"
                                                                            alt="${item.product.name}"
                                                                            class="w-full h-full object-cover" />
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div
                                                                            class="w-full h-full flex items-center justify-center text-gray-300">
                                                                            <svg class="h-6 w-6" fill="none"
                                                                                viewBox="0 0 24 24"
                                                                                stroke="currentColor">
                                                                                <path stroke-linecap="round"
                                                                                    stroke-linejoin="round"
                                                                                    stroke-width="1.5"
                                                                                    d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                                                            </svg>
                                                                        </div>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                            <div class="min-w-0 flex-1">
                                                                <h3 class="text-sm font-medium text-gray-900 truncate">
                                                                    ${item.product.name}</h3>
                                                                <a href="${pageContext.request.contextPath}/client/cart?action=remove&productId=${item.product.id}"
                                                                    class="text-xs text-red-500 hover:text-red-600">Remove</a>
                                                            </div>
                                                        </div>

                                                        <!-- Quantity -->
                                                        <div class="md:col-span-2">
                                                            <form
                                                                action="${pageContext.request.contextPath}/client/cart"
                                                                method="post" class="flex items-center justify-center">
                                                                <input type="hidden" name="action" value="update" />
                                                                <input type="hidden" name="productId"
                                                                    value="${item.product.id}" />
                                                                <div
                                                                    class="flex items-center border border-gray-200 rounded-lg">
                                                                    <button type="submit" name="quantity"
                                                                        value="${item.quantity - 1}"
                                                                        class="px-2 py-1 text-gray-500 hover:bg-gray-50 text-sm">-</button>
                                                                    <span
                                                                        class="px-3 py-1 text-sm text-gray-900 border-x border-gray-200">${item.quantity}</span>
                                                                    <button type="submit" name="quantity"
                                                                        value="${item.quantity + 1}"
                                                                        class="px-2 py-1 text-gray-500 hover:bg-gray-50 text-sm">+</button>
                                                                </div>
                                                            </form>
                                                        </div>

                                                        <!-- Price -->
                                                        <div class="md:col-span-2 text-right">
                                                            <span class="text-sm text-gray-500">
                                                                <fmt:formatNumber value="${item.product.price}"
                                                                    type="currency" currencySymbol="$" />
                                                            </span>
                                                        </div>

                                                        <!-- Total -->
                                                        <div class="md:col-span-2 text-right">
                                                            <span class="text-sm font-medium text-gray-900">
                                                                <fmt:formatNumber value="${item.itemTotal}"
                                                                    type="currency" currencySymbol="$" />
                                                            </span>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>

                                        <!-- Actions -->
                                        <div class="mt-4 flex justify-between items-center">
                                            <a href="${pageContext.request.contextPath}/client/home"
                                                class="text-indigo-600 hover:text-indigo-700 text-sm font-medium flex items-center">
                                                <svg class="h-4 w-4 mr-1" fill="none" viewBox="0 0 24 24"
                                                    stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                                                </svg>
                                                Continue Shopping
                                            </a>
                                            <a href="${pageContext.request.contextPath}/client/cart?action=clear"
                                                onclick="return confirm('Clear all items from cart?');"
                                                class="text-gray-500 hover:text-red-500 text-sm font-medium">
                                                Clear Cart
                                            </a>
                                        </div>
                                    </div>

                                    <!-- Order Summary -->
                                    <div class="lg:col-span-1">
                                        <div class="bg-white border border-gray-200 rounded-lg p-6 sticky top-24">
                                            <h2 class="text-lg font-semibold text-gray-900 mb-4">Order Summary</h2>

                                            <div class="space-y-3 text-sm">
                                                <div class="flex justify-between text-gray-600">
                                                    <span>Subtotal</span>
                                                    <span>
                                                        <fmt:formatNumber value="${subtotal}" type="currency"
                                                            currencySymbol="$" />
                                                    </span>
                                                </div>

                                                <c:if test="${discount > 0}">
                                                    <div class="flex justify-between text-emerald-600">
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
                                                    <span class="text-emerald-600">Free</span>
                                                </div>

                                                <hr class="border-gray-200" />

                                                <div class="flex justify-between text-base font-semibold text-gray-900">
                                                    <span>Total</span>
                                                    <span>
                                                        <fmt:formatNumber value="${total}" type="currency"
                                                            currencySymbol="$" />
                                                    </span>
                                                </div>
                                            </div>

                                            <c:if test="${not empty bestPromotion}">
                                                <div
                                                    class="bg-emerald-50 border border-emerald-100 rounded-lg p-3 mt-4">
                                                    <p class="text-emerald-700 text-xs font-medium flex items-center">
                                                        <svg class="h-4 w-4 mr-1" fill="none" viewBox="0 0 24 24"
                                                            stroke="currentColor">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2"
                                                                d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                                                        </svg>
                                                        <fmt:formatNumber value="${bestPromotion.promotionValeur}"
                                                            maxFractionDigits="0" />% discount applied
                                                    </p>
                                                </div>
                                            </c:if>

                                            <form action="${pageContext.request.contextPath}/client/checkout"
                                                method="post" class="mt-6">
                                                <button type="submit"
                                                    class="w-full bg-indigo-600 hover:bg-indigo-700 text-white py-3 rounded-lg font-medium text-sm">
                                                    Proceed to Checkout
                                                </button>
                                            </form>

                                            <p class="text-center text-gray-400 text-xs mt-3">Secure checkout</p>
                                        </div>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <%@ include file="/includes/footer.jsp" %>
            </body>

            </html>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>My Orders - IIT Store</title>
                <script src="https://cdn.tailwindcss.com"></script>
            </head>

            <body class="bg-gray-50 min-h-screen flex flex-col">
                <%@ include file="/includes/client-navbar.jsp" %>

                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 flex-1">
                        <h1 class="text-3xl font-bold text-gray-800 mb-8">My Orders</h1>

                        <!-- Success Message -->
                        <c:if test="${not empty sessionScope.orderSuccess}">
                            <div class="bg-green-50 border border-green-200 rounded-lg p-4 mb-6 flex items-center">
                                <svg class="h-5 w-5 text-green-500 mr-3" fill="none" viewBox="0 0 24 24"
                                    stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                                </svg>
                                <span class="text-green-700 font-medium">${sessionScope.orderSuccess}</span>
                            </div>
                            <c:remove var="orderSuccess" scope="session" />
                        </c:if>

                        <c:choose>
                            <c:when test="${empty orders}">
                                <!-- No Orders -->
                                <div class="bg-white rounded-2xl shadow-lg p-12 text-center">
                                    <svg class="mx-auto h-24 w-24 text-gray-300 mb-6" fill="none" viewBox="0 0 24 24"
                                        stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                                    </svg>
                                    <h2 class="text-2xl font-semibold text-gray-700 mb-4">No orders yet</h2>
                                    <p class="text-gray-500 mb-8">You haven't placed any orders. Start shopping now!</p>
                                    <a href="${pageContext.request.contextPath}/client/home"
                                        class="inline-block bg-purple-600 hover:bg-purple-700 text-white px-8 py-3 rounded-lg font-semibold transition-colors duration-200">
                                        Start Shopping
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <!-- Orders List -->
                                <div class="space-y-6">
                                    <c:forEach var="order" items="${orders}">
                                        <div class="bg-white rounded-2xl shadow-lg overflow-hidden">
                                            <!-- Order Header -->
                                            <div
                                                class="bg-gray-50 px-6 py-4 border-b border-gray-200 flex flex-wrap justify-between items-center gap-4">
                                                <div class="flex items-center gap-6">
                                                    <div>
                                                        <p class="text-sm text-gray-500">Order</p>
                                                        <p class="font-bold text-gray-800">#${order.id}</p>
                                                    </div>
                                                    <div>
                                                        <p class="text-sm text-gray-500">Date</p>
                                                        <p class="font-medium text-gray-800">
                                                            <fmt:formatDate value="${order.createdAt}"
                                                                pattern="dd MMM yyyy, HH:mm" />
                                                        </p>
                                                    </div>
                                                    <div>
                                                        <p class="text-sm text-gray-500">Items</p>
                                                        <p class="font-medium text-gray-800">${order.itemCount}</p>
                                                    </div>
                                                </div>
                                                <div class="flex items-center gap-4">
                                                    <!-- Status Badge -->
                                                    <c:choose>
                                                        <c:when test="${order.status == 'PENDING'}">
                                                            <span
                                                                class="px-3 py-1 rounded-full text-sm font-medium bg-yellow-100 text-yellow-800">
                                                                Pending
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'CONFIRMED'}">
                                                            <span
                                                                class="px-3 py-1 rounded-full text-sm font-medium bg-blue-100 text-blue-800">
                                                                Confirmed
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'SHIPPED'}">
                                                            <span
                                                                class="px-3 py-1 rounded-full text-sm font-medium bg-purple-100 text-purple-800">
                                                                Shipped
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'DELIVERED'}">
                                                            <span
                                                                class="px-3 py-1 rounded-full text-sm font-medium bg-green-100 text-green-800">
                                                                Delivered
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'CANCELLED'}">
                                                            <span
                                                                class="px-3 py-1 rounded-full text-sm font-medium bg-red-100 text-red-800">
                                                                Cancelled
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span
                                                                class="px-3 py-1 rounded-full text-sm font-medium bg-gray-100 text-gray-800">
                                                                ${order.status}
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <div class="text-right">
                                                        <p class="text-sm text-gray-500">Total</p>
                                                        <p class="text-xl font-bold text-purple-600">
                                                            <fmt:formatNumber value="${order.total}" type="currency"
                                                                currencySymbol="$" />
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Order Items -->
                                            <div class="px-6 py-4">
                                                <div class="divide-y divide-gray-100">
                                                    <c:forEach var="item" items="${order.items}">
                                                        <div class="py-3 flex justify-between items-center">
                                                            <div class="flex items-center gap-4">
                                                                <div
                                                                    class="w-12 h-12 bg-gray-100 rounded-lg flex items-center justify-center">
                                                                    <svg class="h-6 w-6 text-gray-400" fill="none"
                                                                        viewBox="0 0 24 24" stroke="currentColor">
                                                                        <path stroke-linecap="round"
                                                                            stroke-linejoin="round" stroke-width="2"
                                                                            d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
                                                                    </svg>
                                                                </div>
                                                                <div>
                                                                    <p class="font-medium text-gray-800">
                                                                        ${item.productName}</p>
                                                                    <p class="text-sm text-gray-500">
                                                                        <fmt:formatNumber value="${item.productPrice}"
                                                                            type="currency" currencySymbol="$" />
                                                                        × ${item.quantity}
                                                                    </p>
                                                                </div>
                                                            </div>
                                                            <p class="font-medium text-gray-800">
                                                                <fmt:formatNumber value="${item.itemTotal}"
                                                                    type="currency" currencySymbol="$" />
                                                            </p>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </div>

                                            <!-- Order Summary -->
                                            <div class="bg-gray-50 px-6 py-4 border-t border-gray-200">
                                                <div class="flex justify-end gap-8 text-sm">
                                                    <div class="text-right">
                                                        <p class="text-gray-500">Subtotal</p>
                                                        <p class="font-medium">
                                                            <fmt:formatNumber value="${order.subtotal}" type="currency"
                                                                currencySymbol="$" />
                                                        </p>
                                                    </div>
                                                    <c:if test="${order.discount > 0}">
                                                        <div class="text-right">
                                                            <p class="text-gray-500">Discount</p>
                                                            <p class="font-medium text-green-600">
                                                                -
                                                                <fmt:formatNumber value="${order.discount}"
                                                                    type="currency" currencySymbol="$" />
                                                            </p>
                                                        </div>
                                                    </c:if>
                                                    <div class="text-right">
                                                        <p class="text-gray-500">Total</p>
                                                        <p class="font-bold text-lg text-purple-600">
                                                            <fmt:formatNumber value="${order.total}" type="currency"
                                                                currencySymbol="$" />
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <%@ include file="/includes/footer.jsp" %>
            </body>

            </html>
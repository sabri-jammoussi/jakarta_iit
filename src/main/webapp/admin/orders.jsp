<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Orders - Admin</title>
                <script src="https://cdn.tailwindcss.com"></script>
            </head>

            <body class="bg-gray-50 min-h-screen flex flex-col">
                <%@ include file="/includes/admin-navbar.jsp" %>

                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 flex-1">
                        <h1 class="text-3xl font-bold text-gray-800 mb-8">All Orders</h1>

                        <c:choose>
                            <c:when test="${empty commandes}">
                                <div class="bg-white rounded-2xl shadow-lg p-12 text-center">
                                    <p class="text-gray-500">No orders found.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="space-y-6">
                                    <c:forEach var="order" items="${commandes}">
                                        <div class="bg-white rounded-2xl shadow-lg overflow-hidden">
                                            <div
                                                class="px-6 py-4 border-b border-gray-200 flex justify-between items-center">
                                                <div>
                                                    <p class="text-sm text-gray-500">Order</p>
                                                    <p class="font-bold text-gray-800">#${order.id}</p>
                                                </div>
                                                <div class="text-right">
                                                    <p class="text-sm text-gray-500">Customer</p>
                                                    <p class="font-medium text-gray-800">${order.userFullname}
                                                        &lt;${order.userEmail}&gt;</p>
                                                </div>
                                                <div class="text-right">
                                                    <p class="text-sm text-gray-500">Total</p>
                                                    <p class="font-bold text-purple-600">
                                                        <fmt:formatNumber value="${order.total}" type="currency"
                                                            currencySymbol="$" />
                                                    </p>
                                                </div>
                                                <div>
                                                    <p class="text-sm text-gray-500">Status</p>
                                                    <p class="font-medium">${order.status}</p>
                                                </div>
                                            </div>

                                            <div class="px-6 py-4">
                                                <div class="divide-y divide-gray-100">
                                                    <c:forEach var="item" items="${order.items}">
                                                        <div class="py-3 flex justify-between items-center">
                                                            <div>
                                                                <p class="font-medium text-gray-800">${item.productName}
                                                                </p>
                                                                <p class="text-sm text-gray-500">Qty: ${item.quantity} •
                                                                    <fmt:formatNumber value="${item.productPrice}"
                                                                        type="currency" currencySymbol="$" />
                                                                </p>
                                                            </div>
                                                            <p class="font-medium text-gray-800">
                                                                <fmt:formatNumber value="${item.itemTotal}"
                                                                    type="currency" currencySymbol="$" />
                                                            </p>
                                                        </div>
                                                    </c:forEach>
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
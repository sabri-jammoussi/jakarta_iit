<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Manage Promotions - Admin</title>
                <script src="https://cdn.tailwindcss.com"></script>
            </head>

            <body class="bg-gray-100 min-h-screen">
                <%@ include file="/includes/admin-navbar.jsp" %>

                    <!-- Header Section -->
                    <div class="bg-gradient-to-r from-orange-600 to-red-600 text-white py-8">
                        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                            <div class="flex justify-between items-center">
                                <div>
                                    <h1 class="text-3xl font-bold mb-2">Promotions Management</h1>
                                    <p class="text-orange-100">Manage your promotional campaigns</p>
                                </div>
                                <a href="${pageContext.request.contextPath}/admin/promotions?action=add"
                                    class="bg-white text-orange-600 hover:bg-orange-50 px-6 py-3 rounded-lg font-semibold transition-colors duration-200">
                                    <span class="inline-block mr-2">+</span> Add Promotion
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Main Content -->
                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
                        <c:if test="${empty promotions}">
                            <div class="bg-blue-50 border border-blue-200 rounded-lg p-8 text-center">
                                <p class="text-blue-800 text-lg">No promotions available. Create one to boost sales!</p>
                            </div>
                        </c:if>

                        <c:if test="${not empty promotions}">
                            <div class="bg-white rounded-xl shadow-lg overflow-hidden">
                                <div class="overflow-x-auto">
                                    <table class="w-full">
                                        <thead class="bg-gray-100 border-b border-gray-200">
                                            <tr>
                                                <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">ID
                                                </th>
                                                <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">
                                                    Start Date</th>
                                                <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">End
                                                    Date</th>
                                                <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">
                                                    Discount</th>
                                                <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">
                                                    Status</th>
                                                <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">
                                                    Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody class="divide-y divide-gray-200">
                                            <c:forEach var="promo" items="${promotions}">
                                                <tr class="hover:bg-gray-50 transition-colors duration-150">
                                                    <td class="px-6 py-4 text-sm text-gray-500">#${promo.id}</td>
                                                    <td class="px-6 py-4 text-sm text-gray-700">
                                                        <fmt:formatDate value="${promo.datePromotionDebut}"
                                                            pattern="dd/MM/yyyy" />
                                                    </td>
                                                    <td class="px-6 py-4 text-sm text-gray-700">
                                                        <fmt:formatDate value="${promo.datePromotionFin}"
                                                            pattern="dd/MM/yyyy" />
                                                    </td>
                                                    <td class="px-6 py-4">
                                                        <span class="text-2xl font-bold text-orange-600">
                                                            <fmt:formatNumber value="${promo.promotionValeur}"
                                                                maxFractionDigits="0" />%
                                                        </span>
                                                    </td>
                                                    <td class="px-6 py-4 text-sm">
                                                        <jsp:useBean id="now" class="java.util.Date" />
                                                        <c:choose>
                                                            <c:when
                                                                test="${promo.datePromotionDebut <= now && promo.datePromotionFin >= now}">
                                                                <span
                                                                    class="inline-block px-3 py-1 rounded-full text-xs font-semibold bg-green-100 text-green-800">
                                                                    Active
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${promo.datePromotionDebut > now}">
                                                                <span
                                                                    class="inline-block px-3 py-1 rounded-full text-xs font-semibold bg-blue-100 text-blue-800">
                                                                    Upcoming
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span
                                                                    class="inline-block px-3 py-1 rounded-full text-xs font-semibold bg-gray-100 text-gray-800">
                                                                    Expired
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="px-6 py-4 text-sm space-x-2">
                                                        <a href="${pageContext.request.contextPath}/admin/promotions?action=edit&id=${promo.id}"
                                                            class="inline-block bg-blue-600 hover:bg-blue-700 text-white px-3 py-2 rounded text-xs font-medium transition-colors duration-200">
                                                            Edit
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/admin/promotions?action=delete&id=${promo.id}"
                                                            onclick="return confirm('Delete this promotion?');"
                                                            class="inline-block bg-red-600 hover:bg-red-700 text-white px-3 py-2 rounded text-xs font-medium transition-colors duration-200">
                                                            Delete
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </c:if>
                    </div>
            </body>

            </html>
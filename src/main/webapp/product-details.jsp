<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <!DOCTYPE html>
            <html lang="fr">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Product Details</title>
                <script src="https://cdn.tailwindcss.com"></script>
            </head>

            <body class="bg-gray-50">
                <%@ include file="navbar.jsp" %>

                    <!-- Header Section -->
                    <div class="bg-gradient-to-r from-indigo-600 to-purple-600 text-white py-12 mb-12">
                        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                            <h1 class="text-4xl font-bold mb-2">Product Details</h1>
                            <p class="text-indigo-100">View complete product information</p>
                        </div>
                    </div>

                    <!-- Content -->
                    <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 pb-12">
                        <div class="bg-white rounded-xl shadow-lg p-8">
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                                <!-- Product Image Placeholder -->
                                <div class="md:col-span-1">
                                    <div
                                        class="w-full h-64 bg-gradient-to-br from-purple-200 to-pink-200 rounded-lg flex items-center justify-center">
                                        <svg class="w-24 h-24 text-purple-400" fill="none" stroke="currentColor"
                                            viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z">
                                            </path>
                                        </svg>
                                    </div>
                                </div>

                                <!-- Product Info -->
                                <div class="md:col-span-2">
                                    <h1 class="text-4xl font-bold text-gray-800 mb-4">${product.name}</h1>

                                    <div class="mb-6">
                                        <span class="text-5xl font-bold text-green-600">$
                                            <fmt:formatNumber value="${product.price}" type="number"
                                                minFractionDigits="2" maxFractionDigits="2" />
                                        </span>
                                    </div>

                                    <div class="mb-6 pb-6 border-b border-gray-200">
                                        <p class="text-gray-600 mb-2"><span class="font-semibold">Category ID:</span>
                                            ${product.categoryId}</p>
                                    </div>

                                    <div class="mb-8">
                                        <h3 class="text-xl font-semibold text-gray-800 mb-3">Description</h3>
                                        <p class="text-gray-700 leading-relaxed">${product.description}</p>
                                    </div>

                                    <!-- Quantity Selector (Disabled for View Only) -->
                                    <div class="mb-8">
                                        <div class="flex items-center gap-4">
                                            <span class="text-gray-600 font-semibold">Availability:</span>
                                            <span
                                                class="inline-block px-4 py-2 bg-green-100 text-green-800 rounded-full font-semibold text-sm">In
                                                Stock</span>
                                        </div>
                                    </div>

                                    <!-- Action Buttons -->
                                    <div class="flex gap-3 pt-6 border-t border-gray-200">
                                        <a href="/servlet-jsp-gr3/products?action=edit&id=${product.id}"
                                            class="flex-1 text-center bg-blue-600 hover:bg-blue-700 text-white px-6 py-3 rounded-lg font-semibold transition-colors duration-200">
                                            Edit Product
                                        </a>
                                        <a href="/servlet-jsp-gr3/products?action=list"
                                            class="flex-1 text-center border border-gray-300 bg-white text-gray-700 hover:bg-gray-50 px-6 py-3 rounded-lg font-semibold transition-colors duration-200">
                                            Back to List
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
            </body>

            </html>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Edit Product</title>
            <script src="https://cdn.tailwindcss.com"></script>
        </head>

        <body class="bg-gray-50">
            <%@ include file="navbar.jsp" %>

                <!-- Header Section -->
                <div class="bg-gradient-to-r from-blue-600 to-indigo-600 text-white py-12 mb-12">
                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                        <h1 class="text-4xl font-bold mb-2">Edit Product</h1>
                        <p class="text-blue-100">Update your product details</p>
                    </div>
                </div>

                <!-- Form Container -->
                <div class="max-w-2xl mx-auto px-4 sm:px-6 lg:px-8 pb-12">
                    <div class="bg-white rounded-xl shadow-lg p-8">
                        <c:if test="${not empty requestScope.errorMessage}">
                            <div class="mb-6 p-4 bg-red-100 border border-red-400 text-red-700 rounded-lg">
                                ${requestScope.errorMessage}
                            </div>
                        </c:if>

                        <form action="/servlet-jsp-gr3/products?action=edit" method="post">
                            <input type="hidden" name="id" value="${product.id}" />

                            <!-- Product Information Section -->
                            <div class="mb-8">
                                <div class="flex items-center gap-3 mb-6 pb-4 border-b-2 border-gray-200">
                                    <div
                                        class="w-10 h-10 rounded-lg bg-gradient-to-r from-blue-600 to-indigo-600 flex items-center justify-center text-white">
                                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z">
                                            </path>
                                        </svg>
                                    </div>
                                    <h3 class="text-xl font-semibold text-gray-800">Edit Product</h3>
                                </div>

                                <!-- Product Name -->
                                <div class="mb-6">
                                    <label class="block text-sm font-semibold text-gray-700 mb-2">Product Name</label>
                                    <input name="name" type="text"
                                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                        value="${product.name}" required>
                                </div>

                                <!-- Price -->
                                <div class="mb-6">
                                    <label class="block text-sm font-semibold text-gray-700 mb-2">Price (USD)</label>
                                    <div class="relative">
                                        <span class="absolute left-4 top-3 text-gray-600 font-semibold">$</span>
                                        <input name="price" type="number" step="0.01"
                                            class="w-full pl-8 pr-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                            value="${product.price}" required>
                                    </div>
                                </div>

                                <!-- Category -->
                                <div class="mb-6">
                                    <label class="block text-sm font-semibold text-gray-700 mb-2">Category</label>
                                    <select name="categoryId"
                                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white">
                                        <option value="">-- Select Category --</option>
                                        <c:forEach var="cat" items="${requestScope.categories}">
                                            <option value="${cat.id}" ${cat.id==product.categoryId ? 'selected' : '' }>
                                                ${cat.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- Description -->
                                <div class="mb-6">
                                    <label class="block text-sm font-semibold text-gray-700 mb-2">Description</label>
                                    <textarea name="description" rows="5"
                                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none">${product.description}</textarea>
                                </div>

                                <!-- Image URL -->
                                <div class="mb-6">
                                    <label class="block text-sm font-semibold text-gray-700 mb-2">Image URL</label>
                                    <input name="imageUrl" type="url"
                                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                        value="${product.imageUrl}" placeholder="https://example.com/image.jpg">
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="flex gap-3 justify-end pt-6 border-t border-gray-200">
                                <a href="/servlet-jsp-gr3/products?action=list"
                                    class="px-6 py-3 border border-gray-300 text-gray-700 font-semibold rounded-lg hover:bg-gray-50 transition-colors duration-200">Cancel</a>
                                <button type="submit"
                                    class="px-6 py-3 bg-gradient-to-r from-blue-600 to-indigo-600 text-white font-semibold rounded-lg hover:from-blue-700 hover:to-indigo-700 transition-all duration-200 shadow-lg">Save
                                    Changes</button>
                            </div>
                        </form>
                    </div>
                </div>
        </body>

        </html>
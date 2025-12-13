<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Edit Category - Admin</title>
            <script src="https://cdn.tailwindcss.com"></script>
        </head>

        <body class="bg-gray-100 min-h-screen">
            <%@ include file="/includes/admin-navbar.jsp" %>

                <div class="max-w-2xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
                    <div class="mb-6">
                        <a href="${pageContext.request.contextPath}/admin/categories"
                            class="text-green-600 hover:text-green-700 flex items-center">
                            <svg class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                            </svg>
                            Back to Categories
                        </a>
                    </div>

                    <div class="bg-white rounded-xl shadow-lg p-8">
                        <h1 class="text-2xl font-bold text-gray-800 mb-6">Edit Category</h1>

                        <c:if test="${not empty errorMessage}">
                            <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg mb-6">
                                ${errorMessage}
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/admin/categories" method="post"
                            class="space-y-6">
                            <input type="hidden" name="action" value="edit" />
                            <input type="hidden" name="id" value="${category.id}" />

                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">Category Name *</label>
                                <input type="text" name="name" required value="${category.name}"
                                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-green-500" />
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">Description</label>
                                <textarea name="description" rows="4"
                                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-green-500">${category.description}</textarea>
                            </div>

                            <div class="flex gap-4 pt-4">
                                <button type="submit"
                                    class="flex-1 bg-green-600 hover:bg-green-700 text-white py-3 rounded-lg font-semibold transition-colors duration-200">
                                    Update Category
                                </button>
                                <a href="${pageContext.request.contextPath}/admin/categories"
                                    class="flex-1 text-center bg-gray-200 hover:bg-gray-300 text-gray-700 py-3 rounded-lg font-semibold transition-colors duration-200">
                                    Cancel
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
        </body>

        </html>
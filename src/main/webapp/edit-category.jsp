<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <jsp:include page="navbar.jsp" />
        <!DOCTYPE html>
        <html>

        <head>
            <title>Edit Category</title>
        </head>

        <body class="bg-gray-50 min-h-screen py-8">
            <div class="max-w-3xl mx-auto">
                <h1 class="text-2xl font-semibold mb-4">Edit Category</h1>

                <c:if test="${not empty errorMessage}">
                    <div class="mb-4 text-red-600">${errorMessage}</div>
                </c:if>

                <form action="/servlet-jsp-gr3/categories?action=edit" method="post"
                    class="bg-white p-6 rounded shadow space-y-4">
                    <input type="hidden" name="id" value="${category.id}" />

                    <div>
                        <label class="block text-sm font-medium text-gray-700">Name</label>
                        <input name="name" value="${category.name}" required
                            class="mt-1 block w-full rounded border-gray-300 shadow-sm" />
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700">Description</label>
                        <textarea name="description" rows="4"
                            class="mt-1 block w-full rounded border-gray-300 shadow-sm">${category.description}</textarea>
                    </div>

                    <div class="flex items-center space-x-3">
                        <button type="submit" class="px-4 py-2 bg-green-600 text-white rounded">Save</button>
                        <a href="/servlet-jsp-gr3/categories?action=list" class="text-sm text-gray-600">Cancel</a>
                    </div>
                </form>
            </div>
        </body>

        </html>
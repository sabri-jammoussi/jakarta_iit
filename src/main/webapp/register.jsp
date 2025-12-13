<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1" />
            <title>Create account</title>
            <script src="https://cdn.tailwindcss.com"></script>
            <style>
                body {
                    font-family: Inter, ui-sans-serif, system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial
                }
            </style>
        </head>

        <body class="bg-gradient-to-br from-indigo-50 to-white min-h-screen flex items-center justify-center">
            <div class="max-w-lg w-full bg-white rounded-2xl shadow-xl p-10">
                <div class="text-center mb-6">
                    <h1 class="text-3xl font-bold">Create your account</h1>
                    <p class="text-sm text-gray-500">Join us — manage products and track orders.</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="mb-4 text-sm text-red-600">${error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/auth?action=register" method="post" class="space-y-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700">Full name</label>
                        <input name="fullname" type="text" required
                            class="mt-1 w-full px-4 py-3 border rounded-lg focus:ring-2 focus:ring-indigo-500" />
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700">Email</label>
                        <input name="email" type="email" required
                            class="mt-1 w-full px-4 py-3 border rounded-lg focus:ring-2 focus:ring-indigo-500" />
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700">Password</label>
                        <input name="password" type="password" required
                            class="mt-1 w-full px-4 py-3 border rounded-lg focus:ring-2 focus:ring-indigo-500" />
                    </div>
                    <div class="flex items-center justify-between">
                        <div class="text-sm"><a href="/servlet-jsp-gr3/auth?action=login"
                                class="text-indigo-600 hover:underline">Already have an account?</a></div>
                        <button type="submit" class="px-5 py-3 bg-indigo-600 text-white rounded-lg font-semibold">Create
                            account</button>
                    </div>
                </form>
            </div>
        </body>

        </html>
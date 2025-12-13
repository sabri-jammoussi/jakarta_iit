<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Login - IIT Store</title>
            <script src="https://cdn.tailwindcss.com"></script>
        </head>

        <body
            class="bg-gradient-to-br from-purple-600 via-pink-600 to-red-600 min-h-screen flex items-center justify-center p-4">
            <div class="max-w-md w-full">
                <!-- Back to store -->
                <a href="${pageContext.request.contextPath}/client/home"
                    class="inline-flex items-center text-white hover:text-purple-200 mb-6 transition-colors">
                    <svg class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                    </svg>
                    Back to Store
                </a>

                <div class="bg-white rounded-2xl shadow-2xl p-8">
                    <div class="text-center mb-8">
                        <h1
                            class="text-3xl font-bold bg-gradient-to-r from-purple-600 to-pink-600 bg-clip-text text-transparent">
                            IIT Store
                        </h1>
                        <p class="text-gray-500 mt-2">Sign in to your account</p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg mb-6 text-sm">
                            ${error}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/auth?action=login" method="post" class="space-y-6">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Email</label>
                            <input type="email" name="email" required
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500 transition-shadow"
                                placeholder="you@example.com" />
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Password</label>
                            <input type="password" name="password" required
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500 transition-shadow"
                                placeholder="••••••••" />
                        </div>

                        <button type="submit"
                            class="w-full bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-700 hover:to-pink-700 text-white py-3 rounded-lg font-semibold transition-all duration-200 shadow-lg hover:shadow-xl">
                            Sign In
                        </button>
                    </form>

                    <div class="mt-6 text-center">
                        <p class="text-gray-600 text-sm">
                            Don't have an account?
                            <a href="${pageContext.request.contextPath}/auth?action=register"
                                class="text-purple-600 hover:text-purple-700 font-medium">
                                Create one
                            </a>
                        </p>
                    </div>
                </div>

                <p class="text-center text-white/70 text-sm mt-6">
                    &copy; 2025 IIT Store. All rights reserved.
                </p>
            </div>
        </body>

        </html>
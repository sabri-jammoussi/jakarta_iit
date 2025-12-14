<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Create Account - IIT Store</title>
            <script src="https://cdn.tailwindcss.com"></script>
        </head>

        <body class="bg-slate-50 min-h-screen flex items-center justify-center p-4">
            <div class="max-w-sm w-full">
                <!-- Back to store -->
                <a href="${pageContext.request.contextPath}/client/home"
                    class="inline-flex items-center text-gray-500 hover:text-indigo-600 mb-6 text-sm">
                    <svg class="h-4 w-4 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                    </svg>
                    Back to Store
                </a>

                <div class="bg-white border border-gray-200 rounded-lg p-8">
                    <div class="text-center mb-8">
                        <h1 class="text-xl font-semibold text-gray-900">IIT Store</h1>
                        <p class="text-gray-500 text-sm mt-1">Create your account</p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="bg-red-50 border border-red-100 text-red-600 px-4 py-3 rounded-lg mb-6 text-sm">
                            ${error}
                        </div>
                    </c:if>

                    <c:if test="${not empty success}">
                        <div
                            class="bg-emerald-50 border border-emerald-100 text-emerald-600 px-4 py-3 rounded-lg mb-6 text-sm">
                            ${success}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/auth?action=register" method="post"
                        class="space-y-5">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1.5">Full Name</label>
                            <input type="text" name="fullname" required
                                class="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none"
                                placeholder="John Doe" />
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1.5">Email</label>
                            <input type="email" name="email" required
                                class="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none"
                                placeholder="you@example.com" />
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1.5">Password</label>
                            <input type="password" name="password" required minlength="6"
                                class="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none"
                                placeholder="••••••••" />
                            <p class="text-xs text-gray-400 mt-1">Must be at least 6 characters</p>
                        </div>

                        <button type="submit"
                            class="w-full bg-indigo-600 hover:bg-indigo-700 text-white py-2.5 rounded-lg text-sm font-medium">
                            Create Account
                        </button>
                    </form>

                    <div class="mt-6 text-center">
                        <p class="text-gray-500 text-sm">
                            Already have an account?
                            <a href="${pageContext.request.contextPath}/auth?action=login"
                                class="text-indigo-600 hover:text-indigo-700 font-medium">
                                Sign in
                            </a>
                        </p>
                    </div>
                </div>

                <p class="text-center text-gray-400 text-xs mt-6">
                    &copy; 2025 IIT Store. All rights reserved.
                </p>
            </div>
        </body>

        </html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!-- Admin Navbar - For admin dashboard pages -->
    <script src="https://cdn.tailwindcss.com"></script>

    <nav class="bg-gray-900 shadow-lg sticky top-0 z-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
                <!-- Logo -->
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="flex-shrink-0 flex items-center">
                    <span class="text-2xl font-bold text-white">
                        IIT Store <span class="text-orange-400">Admin</span>
                    </span>
                </a>

                <!-- Navigation Links -->
                <div class="hidden md:flex space-x-6">
                    <a href="${pageContext.request.contextPath}/admin/dashboard"
                        class="text-gray-300 hover:text-white px-3 py-2 text-sm font-medium transition-colors duration-200 flex items-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-1" fill="none" viewBox="0 0 24 24"
                            stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
                        </svg>
                        Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/products"
                        class="text-gray-300 hover:text-white px-3 py-2 text-sm font-medium transition-colors duration-200 flex items-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-1" fill="none" viewBox="0 0 24 24"
                            stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
                        </svg>
                        Products
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/categories"
                        class="text-gray-300 hover:text-white px-3 py-2 text-sm font-medium transition-colors duration-200 flex items-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-1" fill="none" viewBox="0 0 24 24"
                            stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" />
                        </svg>
                        Categories
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/promotions"
                        class="text-gray-300 hover:text-white px-3 py-2 text-sm font-medium transition-colors duration-200 flex items-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-1" fill="none" viewBox="0 0 24 24"
                            stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M12 8v13m0-13V6a2 2 0 112 2h-2zm0 0V5.5A2.5 2.5 0 109.5 8H12zm-7 4h14M5 12a2 2 0 110-4h14a2 2 0 110 4M5 12v7a2 2 0 002 2h10a2 2 0 002-2v-7" />
                        </svg>
                        Promotions
                    </a>
                </div>

                <!-- Right Side: User & Client Link -->
                <div class="flex items-center space-x-4">
                    <a href="${pageContext.request.contextPath}/client/home"
                        class="text-gray-300 hover:text-white text-sm font-medium transition-colors duration-200 flex items-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-1" fill="none" viewBox="0 0 24 24"
                            stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                        </svg>
                        View Store
                    </a>

                    <c:if test="${not empty sessionScope.fullname}">
                        <div class="flex items-center space-x-3">
                            <span class="text-gray-300 font-medium text-sm">
                                <span class="text-orange-400">Admin:</span> ${sessionScope.fullname}
                            </span>
                            <a href="${pageContext.request.contextPath}/logout"
                                class="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-lg text-sm font-medium transition-colors duration-200">
                                Logout
                            </a>
                        </div>
                    </c:if>
                </div>

                <!-- Mobile menu button -->
                <div class="md:hidden flex items-center">
                    <button id="admin-mobile-menu-btn" class="text-gray-300 hover:text-white">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                            stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M4 6h16M4 12h16M4 18h16" />
                        </svg>
                    </button>
                </div>
            </div>

            <!-- Mobile Menu -->
            <div id="admin-mobile-menu" class="hidden md:hidden pb-4">
                <div class="flex flex-col space-y-2">
                    <a href="${pageContext.request.contextPath}/admin/dashboard"
                        class="text-gray-300 hover:text-white px-3 py-2 text-sm font-medium">Dashboard</a>
                    <a href="${pageContext.request.contextPath}/admin/products"
                        class="text-gray-300 hover:text-white px-3 py-2 text-sm font-medium">Products</a>
                    <a href="${pageContext.request.contextPath}/admin/categories"
                        class="text-gray-300 hover:text-white px-3 py-2 text-sm font-medium">Categories</a>
                    <a href="${pageContext.request.contextPath}/admin/promotions"
                        class="text-gray-300 hover:text-white px-3 py-2 text-sm font-medium">Promotions</a>
                    <hr class="border-gray-700">
                    <a href="${pageContext.request.contextPath}/client/home"
                        class="text-orange-400 hover:text-orange-300 px-3 py-2 text-sm font-medium">View Store</a>
                </div>
            </div>
        </div>
    </nav>

    <script>
        // Mobile menu toggle
        document.getElementById('admin-mobile-menu-btn')?.addEventListener('click', function () {
            document.getElementById('admin-mobile-menu').classList.toggle('hidden');
        });
    </script>
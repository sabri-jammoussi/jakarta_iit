<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!-- Client Navbar - For customer-facing pages -->
    <script src="https://cdn.tailwindcss.com"></script>

    <nav class="bg-white shadow-lg border-b border-gray-200 sticky top-0 z-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
                <!-- Logo -->
                <a href="${pageContext.request.contextPath}/client/home" class="flex-shrink-0 flex items-center">
                    <span
                        class="text-2xl font-bold bg-gradient-to-r from-purple-600 to-pink-600 bg-clip-text text-transparent">
                        IIT Store
                    </span>
                </a>

                <!-- Navigation Links -->
                <div class="hidden md:flex space-x-8">
                    <a href="${pageContext.request.contextPath}/client/home"
                        class="text-gray-700 hover:text-purple-600 px-3 py-2 text-sm font-medium transition-colors duration-200">
                        Home
                    </a>
                    <a href="${pageContext.request.contextPath}/client/products"
                        class="text-gray-700 hover:text-purple-600 px-3 py-2 text-sm font-medium transition-colors duration-200">
                        Products
                    </a>
                    <c:if test="${not empty sessionScope.email}">
                        <a href="${pageContext.request.contextPath}/client/orders"
                            class="text-gray-700 hover:text-purple-600 px-3 py-2 text-sm font-medium transition-colors duration-200">
                            My Orders
                        </a>
                    </c:if>
                </div>

                <!-- Right Side: Cart & User -->
                <div class="flex items-center space-x-4">
                    <!-- Shopping Cart -->
                    <a href="${pageContext.request.contextPath}/client/cart"
                        class="relative text-gray-700 hover:text-purple-600 transition-colors duration-200">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                            stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
                        </svg>
                        <!-- Cart Count Badge -->
                        <c:if test="${sessionScope.cartCount != null && sessionScope.cartCount > 0}">
                            <span id="cart-badge"
                                class="absolute -top-2 -right-2 bg-red-500 text-white text-xs font-bold rounded-full h-5 w-5 flex items-center justify-center">
                                ${sessionScope.cartCount}
                            </span>
                        </c:if>
                        <c:if test="${sessionScope.cartCount == null || sessionScope.cartCount == 0}">
                            <span id="cart-badge"
                                class="absolute -top-2 -right-2 bg-red-500 text-white text-xs font-bold rounded-full h-5 w-5 flex items-center justify-center hidden">
                                0
                            </span>
                        </c:if>
                    </a>

                    <!-- User Info / Login -->
                    <c:choose>
                        <c:when test="${not empty sessionScope.fullname}">
                            <div class="flex items-center space-x-3">
                                <span class="text-gray-700 font-medium text-sm">${sessionScope.fullname}</span>
                                <c:if test="${sessionScope.role == 'ADMIN' || sessionScope.role == 'ROLE_ADMIN'}">
                                    <a href="${pageContext.request.contextPath}/admin/dashboard"
                                        class="bg-purple-100 text-purple-700 hover:bg-purple-200 px-3 py-1 rounded-lg text-xs font-medium transition-colors duration-200">
                                        Admin
                                    </a>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/logout"
                                    class="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-lg text-sm font-medium transition-colors duration-200">
                                    Logout
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/auth?action=login"
                                class="bg-purple-600 hover:bg-purple-700 text-white px-4 py-2 rounded-lg text-sm font-medium transition-colors duration-200">
                                Login
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Mobile menu button -->
                <div class="md:hidden flex items-center">
                    <button id="mobile-menu-btn" class="text-gray-700 hover:text-purple-600">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                            stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M4 6h16M4 12h16M4 18h16" />
                        </svg>
                    </button>
                </div>
            </div>

            <!-- Mobile Menu -->
            <div id="mobile-menu" class="hidden md:hidden pb-4">
                <div class="flex flex-col space-y-2">
                    <a href="${pageContext.request.contextPath}/client/home"
                        class="text-gray-700 hover:text-purple-600 px-3 py-2 text-sm font-medium">Home</a>
                    <a href="${pageContext.request.contextPath}/client/products"
                        class="text-gray-700 hover:text-purple-600 px-3 py-2 text-sm font-medium">Products</a>
                    <a href="${pageContext.request.contextPath}/client/cart"
                        class="text-gray-700 hover:text-purple-600 px-3 py-2 text-sm font-medium">Cart</a>
                    <c:if test="${not empty sessionScope.email}">
                        <a href="${pageContext.request.contextPath}/client/orders"
                            class="text-gray-700 hover:text-purple-600 px-3 py-2 text-sm font-medium">My Orders</a>
                    </c:if>
                </div>
            </div>
        </div>
    </nav>

    <script>
        // Mobile menu toggle
        document.getElementById('mobile-menu-btn')?.addEventListener('click', function () {
            document.getElementById('mobile-menu').classList.toggle('hidden');
        });
    </script>
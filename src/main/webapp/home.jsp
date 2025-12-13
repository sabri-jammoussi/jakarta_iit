<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>IIT Store - Home</title>
            <script src="https://cdn.tailwindcss.com"></script>
        </head>

        <body class="bg-gray-50">
            <%@include file="navbar.jsp" %>

                <!-- Hero Section -->
                <div class="bg-gradient-to-r from-purple-600 via-pink-600 to-red-600 text-white">
                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-24">
                        <div class="text-center max-w-3xl mx-auto">
                            <h1 class="text-5xl md:text-6xl font-bold mb-6">Welcome to IIT Store</h1>
                            <p class="text-xl md:text-2xl text-purple-100 mb-10">Discover premium products with amazing
                                discounts</p>
                            <div class="flex flex-col sm:flex-row gap-4 justify-center">
                                <a href="/servlet-jsp-gr3/products"
                                    class="bg-white text-purple-600 hover:bg-purple-50 px-8 py-3 rounded-lg font-bold text-lg transition-all duration-200 shadow-lg">
                                    Shop Now
                                </a>
                                <a href="/servlet-jsp-gr3/promotions"
                                    class="border-2 border-white text-white hover:bg-white hover:text-purple-600 px-8 py-3 rounded-lg font-bold text-lg transition-all duration-200">
                                    View Promotions
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Featured Categories Section -->
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
                    <div class="text-center mb-12">
                        <h2 class="text-4xl font-bold text-gray-800 mb-4">Browse Categories</h2>
                        <p class="text-gray-600 text-lg">Find what you're looking for in our carefully curated
                            categories</p>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                        <!-- Category Cards -->
                        <div
                            class="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-xl transition-all duration-300 transform hover:-translate-y-1">
                            <div class="h-40 bg-gradient-to-br from-blue-400 to-blue-600"></div>
                            <div class="p-6">
                                <h3 class="text-2xl font-bold text-gray-800 mb-2">Electronics</h3>
                                <p class="text-gray-600 mb-4">Latest gadgets and tech products</p>
                                <a href="/servlet-jsp-gr3/categories"
                                    class="inline-block text-blue-600 hover:text-blue-800 font-semibold">Explore →</a>
                            </div>
                        </div>

                        <div
                            class="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-xl transition-all duration-300 transform hover:-translate-y-1">
                            <div class="h-40 bg-gradient-to-br from-green-400 to-green-600"></div>
                            <div class="p-6">
                                <h3 class="text-2xl font-bold text-gray-800 mb-2">Home & Living</h3>
                                <p class="text-gray-600 mb-4">Quality furniture and home decor</p>
                                <a href="/servlet-jsp-gr3/categories"
                                    class="inline-block text-green-600 hover:text-green-800 font-semibold">Explore →</a>
                            </div>
                        </div>

                        <div
                            class="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-xl transition-all duration-300 transform hover:-translate-y-1">
                            <div class="h-40 bg-gradient-to-br from-orange-400 to-orange-600"></div>
                            <div class="p-6">
                                <h3 class="text-2xl font-bold text-gray-800 mb-2">Fashion</h3>
                                <p class="text-gray-600 mb-4">Trendy clothing and accessories</p>
                                <a href="/servlet-jsp-gr3/categories"
                                    class="inline-block text-orange-600 hover:text-orange-800 font-semibold">Explore
                                    →</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Why Choose Us Section -->
                <div class="bg-white py-16">
                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                        <div class="text-center mb-12">
                            <h2 class="text-4xl font-bold text-gray-800 mb-4">Why Choose IIT Store?</h2>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
                            <div class="text-center">
                                <div
                                    class="w-16 h-16 bg-purple-100 rounded-full flex items-center justify-center mx-auto mb-4">
                                    <svg class="w-8 h-8 text-purple-600" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M13 10V3L4 14h7v7l9-11h-7z"></path>
                                    </svg>
                                </div>
                                <h3 class="text-xl font-bold text-gray-800 mb-2">Fast Shipping</h3>
                                <p class="text-gray-600">Quick delivery to your doorstep</p>
                            </div>

                            <div class="text-center">
                                <div
                                    class="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
                                    <svg class="w-8 h-8 text-green-600" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M9 12l2 2 4-4m7 0a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                    </svg>
                                </div>
                                <h3 class="text-xl font-bold text-gray-800 mb-2">Quality Guaranteed</h3>
                                <p class="text-gray-600">All products are verified</p>
                            </div>

                            <div class="text-center">
                                <div
                                    class="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center mx-auto mb-4">
                                    <svg class="w-8 h-8 text-blue-600" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M18.364 5.636l-3.536 3.536m0 5.656l3.536 3.536M9.172 9.172L5.636 5.636m3.536 9.192l-3.536 3.536M21 12a9 9 0 11-18 0 9 9 0 0118 0zm-5 0a4 4 0 11-8 0 4 4 0 018 0z">
                                        </path>
                                    </svg>
                                </div>
                                <h3 class="text-xl font-bold text-gray-800 mb-2">24/7 Support</h3>
                                <p class="text-gray-600">Customer service always available</p>
                            </div>

                            <div class="text-center">
                                <div
                                    class="w-16 h-16 bg-orange-100 rounded-full flex items-center justify-center mx-auto mb-4">
                                    <svg class="w-8 h-8 text-orange-600" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z">
                                        </path>
                                    </svg>
                                </div>
                                <h3 class="text-xl font-bold text-gray-800 mb-2">Best Prices</h3>
                                <p class="text-gray-600">Competitive pricing guaranteed</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Call to Action Section -->
                <div class="bg-gradient-to-r from-purple-600 to-pink-600 text-white py-16">
                    <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                        <h2 class="text-4xl font-bold mb-6">Ready to Shop?</h2>
                        <p class="text-xl mb-8 text-purple-100">Browse our collection and find your favorite products
                        </p>
                        <a href="/servlet-jsp-gr3/products"
                            class="inline-block bg-white text-purple-600 hover:bg-purple-50 px-8 py-4 rounded-lg font-bold text-lg transition-all duration-200 shadow-lg">
                            Start Shopping Now
                        </a>
                    </div>
                </div>

                <!-- Footer -->
                <footer class="bg-gray-800 text-gray-300 py-12">
                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-8">
                            <div>
                                <h3 class="text-white font-bold text-lg mb-4">IIT Store</h3>
                                <p class="text-sm">Your trusted online shopping destination for quality products at
                                    great prices.</p>
                            </div>
                            <div>
                                <h4 class="text-white font-bold mb-4">Quick Links</h4>
                                <ul class="space-y-2 text-sm">
                                    <li><a href="/servlet-jsp-gr3/products" class="hover:text-white">Products</a></li>
                                    <li><a href="/servlet-jsp-gr3/categories" class="hover:text-white">Categories</a>
                                    </li>
                                    <li><a href="/servlet-jsp-gr3/promotions" class="hover:text-white">Promotions</a>
                                    </li>
                                </ul>
                            </div>
                            <div>
                                <h4 class="text-white font-bold mb-4">Contact</h4>
                                <p class="text-sm">Email: support@iitstore.com</p>
                                <p class="text-sm">Phone: +1 (555) 123-4567</p>
                            </div>
                        </div>
                        <div class="border-t border-gray-700 pt-8 text-center text-sm">
                            <p>&copy; 2025 IIT Store. All rights reserved.</p>
                        </div>
                    </div>
                </footer>
        </body>

        </html>
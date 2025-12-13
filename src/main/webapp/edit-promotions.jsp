<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Promotion #${promotion.id}</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
    <%@ include file="navbar.jsp" %>
    
    <!-- Header Section -->
    <div class="bg-gradient-to-r from-red-600 to-orange-600 text-white py-12 mb-12">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
            <h1 class="text-4xl font-bold mb-2">Edit Promotion #${promotion.id}</h1>
            <p class="text-red-100">Update your promotional campaign</p>
        </div>
    </div>

    <!-- Form Container -->
    <div class="max-w-2xl mx-auto px-4 sm:px-6 lg:px-8 pb-12">
        <div class="bg-white rounded-xl shadow-lg p-8">
            <form action="/servlet-jsp-gr3/promotions?action=edit" method="post" id="promotionForm">
                <input type="hidden" name="id" value="${promotion.id}" />
                
                <!-- Dates Section -->
                <div class="mb-8">
                    <div class="flex items-center gap-3 mb-6 pb-4 border-b-2 border-gray-200">
                        <div class="w-10 h-10 rounded-lg bg-gradient-to-r from-red-600 to-orange-600 flex items-center justify-center text-white">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold text-gray-800">Promotion Dates</h3>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Start Date</label>
                            <input type="date" name="dateDebut" id="dateDebut" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500 focus:border-transparent" value="<fmt:formatDate value='${promotion.datePromotionDebut}' pattern='yyyy-MM-dd' />" required>
                        </div>
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">End Date</label>
                            <input type="date" name="dateFin" id="dateFin" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500 focus:border-transparent" value="<fmt:formatDate value='${promotion.datePromotionFin}' pattern='yyyy-MM-dd' />" required>
                        </div>
                    </div>
                </div>

                <!-- Discount Section -->
                <div class="mb-8">
                    <div class="flex items-center gap-3 mb-6 pb-4 border-b-2 border-gray-200">
                        <div class="w-10 h-10 rounded-lg bg-gradient-to-r from-red-600 to-orange-600 flex items-center justify-center text-white">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold text-gray-800">Discount Value</h3>
                    </div>

                    <div class="bg-gradient-to-br from-red-50 to-orange-50 rounded-lg p-8">
                        <div class="text-center mb-6">
                            <div class="text-5xl font-bold text-red-600" id="discountDisplay">${promotion.promotionValeur}</div>
                            <div class="text-lg text-gray-600">Discount Percentage</div>
                        </div>
                        
                        <div class="mb-6">
                            <input type="range" name="promotionValeur" id="promotionValeur" min="0" max="100" value="${promotion.promotionValeur}" class="w-full h-3 bg-gray-300 rounded-lg appearance-none cursor-pointer accent-red-600" oninput="updateDiscountDisplay(this.value)">
                        </div>

                        <div class="flex justify-between gap-2 mb-4">
                            <button type="button" onclick="setDiscount(5)" class="px-3 py-2 bg-white border border-gray-300 rounded-lg hover:bg-red-50 font-medium text-sm transition-colors">5%</button>
                            <button type="button" onclick="setDiscount(10)" class="px-3 py-2 bg-white border border-gray-300 rounded-lg hover:bg-red-50 font-medium text-sm transition-colors">10%</button>
                            <button type="button" onclick="setDiscount(15)" class="px-3 py-2 bg-white border border-gray-300 rounded-lg hover:bg-red-50 font-medium text-sm transition-colors">15%</button>
                            <button type="button" onclick="setDiscount(20)" class="px-3 py-2 bg-white border border-gray-300 rounded-lg hover:bg-red-50 font-medium text-sm transition-colors">20%</button>
                            <button type="button" onclick="setDiscount(30)" class="px-3 py-2 bg-white border border-gray-300 rounded-lg hover:bg-red-50 font-medium text-sm transition-colors">30%</button>
                            <button type="button" onclick="setDiscount(50)" class="px-3 py-2 bg-white border border-gray-300 rounded-lg hover:bg-red-50 font-medium text-sm transition-colors">50%</button>
                        </div>

                        <div class="text-center text-sm text-gray-600">
                            <p>Drag the slider to set a custom discount value</p>
                        </div>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="flex gap-3 justify-end pt-6 border-t border-gray-200">
                    <a href="/servlet-jsp-gr3/promotions" class="px-6 py-3 border border-gray-300 text-gray-700 font-semibold rounded-lg hover:bg-gray-50 transition-colors duration-200">Cancel</a>
                    <button type="submit" class="px-6 py-3 bg-gradient-to-r from-red-600 to-orange-600 text-white font-semibold rounded-lg hover:from-red-700 hover:to-orange-700 transition-all duration-200 shadow-lg">Save Changes</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function updateDiscountDisplay(value) {
            document.getElementById('discountDisplay').textContent = value;
        }

        function setDiscount(value) {
            document.getElementById('promotionValeur').value = value;
            updateDiscountDisplay(value);
        }

        document.addEventListener('DOMContentLoaded', () => {
            document.getElementById('dateDebut').focus();
        });
    </script>
</body>
</html>

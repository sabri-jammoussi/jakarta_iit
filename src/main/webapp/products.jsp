<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <!DOCTYPE html>
      <html lang="fr">

      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Products</title>
        <script src="https://cdn.tailwindcss.com"></script>
      </head>

      <body class="bg-gray-50">
        <%@ include file="navbar.jsp" %>

          <!-- Header Section -->
          <div class="bg-gradient-to-r from-orange-600 to-red-600 text-white py-12">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
              <div class="flex justify-between items-center">
                <div>
                  <h1 class="text-4xl font-bold mb-2">Products</h1>
                  <p class="text-purple-100">Manage your product catalog</p>
                </div>
                <a href="/servlet-jsp-gr3/products?action=add"
                  class="bg-white text-orange-600 hover:bg-orange-50 px-6 py-3 rounded-lg font-semibold transition-colors duration-200">
                  <span class="inline-block mr-2">+</span> Add Product
                </a>
              </div>
            </div>
          </div>

          <!-- Main Content -->
          <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
            <div class="mb-6">
              <div class="flex flex-col md:flex-row md:items-end gap-4 md:gap-6">
                <div class="flex-1">
                  <label class="text-sm font-medium text-gray-700">Search</label>
                  <input id="prodFilterName" type="text" placeholder="Search by name..."
                    class="mt-1 w-full px-3 py-2 border rounded" />
                </div>
                <div>
                  <label class="text-sm font-medium text-gray-700">Category</label>
                  <select id="prodFilterCategory" class="mt-1 px-3 py-2 border rounded bg-white">
                    <option value="">All</option>
                    <c:forEach var="cat" items="${requestScope.categories}">
                      <option value="${cat.id}">${cat.name}</option>
                    </c:forEach>
                  </select>
                </div>
                <div class="flex items-center gap-2">
                  <div>
                    <label class="text-sm font-medium text-gray-700">Min Price</label>
                    <input id="prodFilterMin" type="number" step="0.01" placeholder="0.00"
                      class="mt-1 px-3 py-2 border rounded w-28" />
                  </div>
                  <div>
                    <label class="text-sm font-medium text-gray-700">Max Price</label>
                    <input id="prodFilterMax" type="number" step="0.01" placeholder="9999.99"
                      class="mt-1 px-3 py-2 border rounded w-28" />
                  </div>
                </div>
                <div class="flex items-center">
                  <button id="prodFilterClear" class="mt-1 px-4 py-2 bg-gray-200 rounded">Clear</button>
                </div>
              </div>
            </div>
            <c:if test="${empty requestScope.products}">
              <div class="bg-blue-50 border border-blue-200 rounded-lg p-8 text-center">
                <p class="text-blue-800 text-lg">No products available. Create one to get started!</p>
              </div>
            </c:if>

            <c:choose>
              <c:when
                test="${sessionScope.role != null && (sessionScope.role == 'ADMIN' || sessionScope.role == 'ROLE_ADMIN')}">
                <c:if test="${not empty requestScope.products}">
                  <div class="bg-white rounded-xl shadow-lg overflow-hidden">
                    <div class="overflow-x-auto">
                      <table class="w-full">
                        <thead class="bg-gray-100 border-b border-gray-200">
                          <tr>
                            <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">Name</th>
                            <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">Price</th>
                            <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">Description</th>
                            <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">Image</th>
                            <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">Actions</th>
                          </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200">
                          <c:forEach var="p" items="${requestScope.products}">
                            <tr class="hover:bg-gray-50 transition-colors duration-150" data-category="${p.categoryId}">
                              <td class="px-6 py-4 text-sm font-medium text-gray-900">${p.name}</td>
                              <td class="px-6 py-4 text-sm font-semibold text-orange-600">
                                <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="$" />
                              </td>
                              <td class="px-6 py-4 text-sm text-gray-600 max-w-md truncate">${p.description}</td>
                              <td class="px-6 py-4 text-sm text-gray-600">
                                <c:choose>
                                  <c:when test="${not empty p.imageUrl}">
                                    <img src="${p.imageUrl}" alt="${p.name}" class="h-16 w-16 object-cover rounded" />
                                  </c:when>
                                  <c:otherwise>
                                    <div
                                      class="h-16 w-16 bg-gray-100 flex items-center justify-center text-gray-400 rounded">
                                      No image</div>
                                  </c:otherwise>
                                </c:choose>
                              </td>
                              <td class="px-6 py-4 text-sm space-x-2">
                                <a href="/servlet-jsp-gr3/products?action=edit&id=${p.id}"
                                  class="inline-block bg-blue-600 hover:bg-blue-700 text-white px-3 py-2 rounded text-xs font-medium transition-colors duration-200">Edit</a>
                                <a href="/servlet-jsp-gr3/products?action=delete&id=${p.id}"
                                  onclick="return confirm('Delete product ${p.name}?');"
                                  class="inline-block bg-red-600 hover:bg-red-700 text-white px-3 py-2 rounded text-xs font-medium transition-colors duration-200">Delete</a>
                              </td>
                            </tr>
                          </c:forEach>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </c:if>
              </c:when>
            </c:choose>
            <script>
              (function () {
                const nameInput = document.getElementById('prodFilterName');
                const catSelect = document.getElementById('prodFilterCategory');
                const minInput = document.getElementById('prodFilterMin');
                const maxInput = document.getElementById('prodFilterMax');
                const clearBtn = document.getElementById('prodFilterClear');
                const rows = Array.from(document.querySelectorAll('table tbody tr'));

                function matches(row) {
                  const name = row.querySelector('td').textContent.toLowerCase();
                  const priceText = row.querySelectorAll('td')[1].textContent.replace(/[^0-9.]/g, '');
                  const price = parseFloat(priceText) || 0;
                  const desc = row.querySelectorAll('td')[2].textContent.toLowerCase();
                  const imgCell = row.querySelectorAll('td')[3];
                  const dataCat = row.getAttribute('data-category') || '';

                  const q = nameInput.value.trim().toLowerCase();
                  if (q && !(name.includes(q) || desc.includes(q))) return false;

                  const cat = catSelect.value;
                  if (cat && dataCat !== cat) return false;

                  const min = parseFloat(minInput.value);
                  if (!isNaN(min) && price < min) return false;
                  const max = parseFloat(maxInput.value);
                  if (!isNaN(max) && price > max) return false;

                  return true;
                }

                function applyFilter() {
                  rows.forEach(r => r.style.display = matches(r) ? '' : 'none');
                }

                [nameInput, catSelect, minInput, maxInput].forEach(el => el.addEventListener('input', applyFilter));
                clearBtn.addEventListener('click', function (e) { e.preventDefault(); nameInput.value = ''; catSelect.value = ''; minInput.value = ''; maxInput.value = ''; applyFilter(); });
              })();
            </script>

          </div>
      </body>

      </html>
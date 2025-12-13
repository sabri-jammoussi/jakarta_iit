package org.example.controller.client;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.service.CategoryService;
import org.example.service.ProductService;
import org.example.service.PromotionService;

import java.io.IOException;

/**
 * Client Product Servlet - Handles product viewing for clients
 * NO CRUD operations - only view products and product details
 */
@WebServlet(name = "ClientProductServlet", urlPatterns = {"/client/products", "/client/product"})
public class ClientProductServlet extends HttpServlet {

    private ProductService productService;
    private CategoryService categoryService;
    private PromotionService promotionService;

    @Override
    public void init() throws ServletException {
        super.init();
        productService = new ProductService();
        categoryService = new CategoryService();
        promotionService = new PromotionService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "view":
                viewProduct(request, response);
                break;
            case "list":
            default:
                listProducts(request, response);
                break;
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        var products = productService.getAllProducts();
        var categories = categoryService.getAllCategories();
        var bestPromotion = promotionService.getBestActivePromotion();

        // Category filter
        String categoryParam = request.getParameter("category");
        if (categoryParam != null && !categoryParam.isEmpty()) {
            try {
                int catId = Integer.parseInt(categoryParam);
                var filtered = new java.util.ArrayList<>(products.size());
                for (var p : products) {
                    if (p.getCategoryId() == catId) filtered.add(p);
                }
                request.setAttribute("selectedCategory", catId);
            } catch (NumberFormatException ignored) {}
        }

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("bestPromotion", bestPromotion);
        
        request.getRequestDispatcher("/client/products.jsp").forward(request, response);
    }

    private void viewProduct(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/client/home");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            var product = productService.getProductById(id);
            
            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/client/home");
                return;
            }
            
            // Get category name
            var category = categoryService.getCategoryById(product.getCategoryId());
            var bestPromotion = promotionService.getBestActivePromotion();
            
            request.setAttribute("product", product);
            request.setAttribute("category", category);
            request.setAttribute("bestPromotion", bestPromotion);
            
            request.getRequestDispatcher("/client/product-details.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/client/home");
        }
    }
}

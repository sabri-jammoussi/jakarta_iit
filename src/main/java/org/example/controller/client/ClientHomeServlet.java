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
 * Client Home Servlet - Displays the main client homepage
 * Shows products, categories, and active promotions (NO CRUD operations)
 */
@WebServlet(name = "ClientHomeServlet", urlPatterns = {"/client/home", "/home"})
public class ClientHomeServlet extends HttpServlet {

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
        
        // Load all products for display
        var products = productService.getAllProducts();
        
        // Load categories for filtering
        var categories = categoryService.getAllCategories();
        
        // Load active promotions to display banners
        var activePromotions = promotionService.getActivePromotions();
        
        // Get the best active promotion for highlighting
        var bestPromotion = promotionService.getBestActivePromotion();
        
        // Optional category filter
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
        
        // Set attributes for the JSP
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("activePromotions", activePromotions);
        request.setAttribute("bestPromotion", bestPromotion);
        
        // Forward to client home page
        request.getRequestDispatcher("/client/home.jsp").forward(request, response);
    }
}

package org.example.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.service.CategoryService;
import org.example.service.ProductService;
import org.example.service.PromotionService;

import java.io.IOException;

/**
 * Admin Dashboard Servlet - Displays admin dashboard with overview statistics
 */
@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin", "/admin/dashboard"})
public class AdminDashboardServlet extends HttpServlet {

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
        
        // Check admin role
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        // Load statistics
        var products = productService.getAllProducts();
        var categories = categoryService.getAllCategories();
        var promotions = promotionService.getAllPromotions();
        var activePromotions = promotionService.getActivePromotions();

        request.setAttribute("productCount", products.size());
        request.setAttribute("categoryCount", categories.size());
        request.setAttribute("promotionCount", promotions.size());
        request.setAttribute("activePromotionCount", activePromotions.size());
        request.setAttribute("recentProducts", products.size() > 5 ? products.subList(0, 5) : products);

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return false;
        
        Object roleObj = session.getAttribute("role");
        if (roleObj == null) return false;
        
        String role = roleObj.toString();
        return "ADMIN".equalsIgnoreCase(role) || "ROLE_ADMIN".equalsIgnoreCase(role);
    }
}

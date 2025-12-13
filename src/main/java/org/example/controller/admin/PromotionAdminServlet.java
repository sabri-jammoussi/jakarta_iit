package org.example.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.model.Promotion;
import org.example.service.PromotionService;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Admin Promotion Servlet - Full CRUD operations for promotions (Admin only)
 */
@WebServlet(name = "PromotionAdminServlet", urlPatterns = {"/admin/promotions"})
public class PromotionAdminServlet extends HttpServlet {

    private PromotionService promotionService;
    private SimpleDateFormat dateFormat;

    @Override
    public void init() throws ServletException {
        super.init();
        promotionService = new PromotionService();
        dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check admin role
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deletePromotion(request, response);
                break;
            case "list":
            default:
                listPromotions(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check admin role
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "add":
                    addPromotion(request, response);
                    break;
                case "edit":
                    updatePromotion(request, response);
                    break;
                case "delete":
                    deletePromotion(request, response);
                    break;
                default:
                    listPromotions(request, response);
            }
        } catch (Exception e) {
            throw new ServletException("Error processing request", e);
        }
    }

    private void listPromotions(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        var promotions = promotionService.getAllPromotions();
        request.setAttribute("promotions", promotions);
        request.getRequestDispatcher("/admin/promotions.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.getRequestDispatcher("/admin/add-promotions.jsp").forward(request, response);
    }

    private void addPromotion(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String dateDebutStr = request.getParameter("dateDebut");
            String dateFinStr = request.getParameter("dateFin");
            String valeurStr = request.getParameter("promotionValeur");

            if (dateDebutStr == null || dateDebutStr.trim().isEmpty() ||
                    dateFinStr == null || dateFinStr.trim().isEmpty() ||
                    valeurStr == null || valeurStr.trim().isEmpty()) {

                request.setAttribute("errorMessage", "All fields are required");
                showAddForm(request, response);
                return;
            }

            Date dateDebut = dateFormat.parse(dateDebutStr);
            Date dateFin = dateFormat.parse(dateFinStr);
            double valeur = Double.parseDouble(valeurStr);
            
            boolean success = promotionService.addPromotion(dateDebut, dateFin, valeur);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/promotions?action=list");
            } else {
                request.setAttribute("errorMessage", "Failed to add promotion");
                showAddForm(request, response);
            }

        } catch (ParseException e) {
            request.setAttribute("errorMessage", "Invalid date format. Use yyyy-MM-dd");
            showAddForm(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid promotion value");
            showAddForm(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
            showAddForm(request, response);
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/promotions?action=list");
                return;
            }

            int id = Integer.parseInt(idStr);
            Promotion promotion = promotionService.getPromotionById(id);

            if (promotion == null) {
                request.setAttribute("errorMessage", "Promotion not found");
                response.sendRedirect(request.getContextPath() + "/admin/promotions?action=list");
                return;
            }

            request.setAttribute("promotion", promotion);
            request.getRequestDispatcher("/admin/edit-promotions.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/promotions?action=list");
        }
    }

    private void updatePromotion(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String dateDebutStr = request.getParameter("dateDebut");
            String dateFinStr = request.getParameter("dateFin");
            String valeurStr = request.getParameter("promotionValeur");

            if (dateDebutStr == null || dateDebutStr.trim().isEmpty() ||
                    dateFinStr == null || dateFinStr.trim().isEmpty() ||
                    valeurStr == null || valeurStr.trim().isEmpty()) {

                request.setAttribute("errorMessage", "All fields are required");
                showEditForm(request, response);
                return;
            }

            Date dateDebut = dateFormat.parse(dateDebutStr);
            Date dateFin = dateFormat.parse(dateFinStr);
            double valeur = Double.parseDouble(valeurStr);

            boolean success = promotionService.updatePromotion(id, dateDebut, dateFin, valeur);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/promotions?action=list");
            } else {
                request.setAttribute("errorMessage", "Failed to update promotion");
                showEditForm(request, response);
            }

        } catch (ParseException e) {
            request.setAttribute("errorMessage", "Invalid date format. Use yyyy-MM-dd");
            showEditForm(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid number format");
            showEditForm(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
            showEditForm(request, response);
        }
    }

    private void deletePromotion(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                promotionService.deletePromotion(id);
            } catch (NumberFormatException ignored) {}
        }
        response.sendRedirect(request.getContextPath() + "/admin/promotions?action=list");
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

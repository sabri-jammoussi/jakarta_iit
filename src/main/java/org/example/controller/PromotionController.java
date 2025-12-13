package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.model.Promotion;
import org.example.service.PromotionService;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "PromotionController", urlPatterns = "/promotions")
public class PromotionController extends HttpServlet {

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

        String action = request.getParameter("action");

        // Default action is "list"
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listPromotions(request, response);
                break;

            case "delete":
                deletePromotion(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "view":
                viewPromotion(request, response);
                break;

            default:
                listPromotions(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

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
                    break;
            }
        } catch (Exception e) {
            throw new ServletException("Error processing request", e);
        }
    }

    // Add new promotion
    private void addPromotion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String dateDebutStr = request.getParameter("dateDebut");
            String dateFinStr = request.getParameter("dateFin");
            String valeurStr = request.getParameter("promotionValeur");

            // Validate input
            if (dateDebutStr == null || dateDebutStr.trim().isEmpty() ||
                    dateFinStr == null || dateFinStr.trim().isEmpty() ||
                    valeurStr == null || valeurStr.trim().isEmpty()) {

                request. setAttribute("errorMessage", "All fields are required");
                showAddForm(request, response);
                return;
            }

            Date dateDebut = dateFormat.parse(dateDebutStr);
            Date dateFin = dateFormat. parse(dateFinStr);
            double valeur = Double.parseDouble(valeurStr);
            boolean success = promotionService.addPromotion(dateDebut, dateFin, valeur);

            if (success) {
                request.setAttribute("successMessage", "Promotion added successfully!");
                response.sendRedirect("/servlet-jsp-gr3/promotions?action=list");
            } else {
                request.setAttribute("errorMessage", "Failed to add promotion");
                showAddForm(request, response);
            }

        } catch (ParseException e) {
            request.setAttribute("errorMessage", "Invalid date format.  Use yyyy-MM-dd");
            showAddForm(request, response);
        } catch (NumberFormatException e) {
            request. setAttribute("errorMessage", "Invalid promotion value");
            showAddForm(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e. getMessage());
            showAddForm(request, response);
        }
    }

    // Update existing promotion
    private void updatePromotion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idStr = Integer.parseInt(request.getParameter("id"));

            String dateDebutStr = request.getParameter("dateDebut");
            String dateFinStr = request.getParameter("dateFin");
            String valeurStr = request.getParameter("promotionValeur");

            // Validate input
            if  (   dateDebutStr == null || dateDebutStr.trim().isEmpty() ||
                    dateFinStr == null || dateFinStr.trim().isEmpty() ||
                    valeurStr == null || valeurStr.trim().isEmpty()) {

                request. setAttribute("errorMessage", "All fields are required");
                showEditForm(request, response);
                return;
            }


            Date dateDebut = dateFormat.parse(dateDebutStr);
            Date dateFin = dateFormat.parse(dateFinStr);
            double valeur = Double.parseDouble(valeurStr);

            boolean success = promotionService.updatePromotion(idStr, dateDebut, dateFin, valeur);

            if (success) {
                response.sendRedirect("/servlet-jsp-gr3/promotions?action=list");
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

    // List all promotions
    private void listPromotions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        var promotions = promotionService.getAllPromotions();
        request.setAttribute("promotions", promotions);
        request.getRequestDispatcher("promotions.jsp").forward(request, response);
    }

    // Delete promotion
    private void deletePromotion(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        promotionService.deletePromotion(id);
        response.sendRedirect("/servlet-jsp-gr3/promotions?action=list");
    }
    // Show add promotion form
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("add-promotions.jsp").forward(request, response);
    }
    // Show edit promotion form
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String idStr = request.getParameter("id");

            if (idStr == null || idStr.trim().isEmpty()) {
                response.sendRedirect("/servlet-jsp-gr3/promotions?action=list");
                return;
            }

            int id = Integer.parseInt(idStr);
            Promotion promotion = promotionService.getPromotionById(id);

            if (promotion == null) {
                request.setAttribute("errorMessage", "Promotion not found");
                response.sendRedirect("/servlet-jsp-gr3/promotions?action=list");
                return;
            }

            request.setAttribute("promotion", promotion);
            request.getRequestDispatcher("edit-promotions.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("/servlet-jsp-gr3/promotions?action=list");
        }
    }
    // View single promotion
    private void viewPromotion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        var promotion = promotionService. getPromotionById(id);
        request.setAttribute("promotion", promotion);
        request.getRequestDispatcher("promotion-details.jsp").forward(request, response);
    }
}
package org.example.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.model.Category;
import org.example.service.CategoryService;

import java.io.IOException;

/**
 * Admin Category Servlet - Full CRUD operations for categories (Admin only)
 */
@WebServlet(name = "CategoryAdminServlet", urlPatterns = {"/admin/categories"})
public class CategoryAdminServlet extends HttpServlet {

    private CategoryService categoryService;

    @Override
    public void init() throws ServletException {
        super.init();
        categoryService = new CategoryService();
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
            case "create":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteCategory(request, response);
                break;
            case "list":
            default:
                listCategories(request, response);
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
                case "create":
                    addCategory(request, response);
                    break;
                case "edit":
                    updateCategory(request, response);
                    break;
                case "delete":
                    deleteCategory(request, response);
                    break;
                default:
                    listCategories(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void listCategories(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        var categories = categoryService.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/admin/categories.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.getRequestDispatcher("/admin/add-category.jsp").forward(request, response);
    }

    private void addCategory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String description = request.getParameter("description");

        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Name is required");
            showAddForm(request, response);
            return;
        }

        boolean success = categoryService.addCategory(new Category(name, description, null));
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/categories?action=list");
        } else {
            request.setAttribute("errorMessage", "Failed to add category");
            showAddForm(request, response);
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/categories?action=list");
                return;
            }

            int id = Integer.parseInt(idStr);
            var category = categoryService.getCategoryById(id);
            if (category == null) {
                response.sendRedirect(request.getContextPath() + "/admin/categories?action=list");
                return;
            }

            request.setAttribute("category", category);
            request.getRequestDispatcher("/admin/edit-category.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/categories?action=list");
        }
    }

    private void updateCategory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");

            if (name == null || name.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Name is required");
                showEditForm(request, response);
                return;
            }

            boolean success = categoryService.updateCategory(id, new Category(name, description, null));
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/categories?action=list");
            } else {
                request.setAttribute("errorMessage", "Failed to update category");
                showEditForm(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid ID");
            showEditForm(request, response);
        }
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                categoryService.deleteCategory(id);
            } catch (NumberFormatException ignored) {}
        }
        response.sendRedirect(request.getContextPath() + "/admin/categories?action=list");
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

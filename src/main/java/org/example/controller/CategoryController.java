package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.model.Category;
import org.example.service.CategoryService;

import java.io.IOException;

@WebServlet(name = "CategoryController", urlPatterns = {"/categories", "/categories/*"})
public class CategoryController extends HttpServlet {

    private CategoryService categoryService;

    @Override
    public void init() throws ServletException {
        super.init();
        categoryService = new CategoryService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) {
            String path = request.getPathInfo();
            if (path != null && path.length() > 1) {
                action = path.substring(1);
                if (action.contains("/")) {
                    action = action.substring(0, action.indexOf("/"));
                }
            }
        }
        if (action == null || action.isEmpty()) action = "list";

        switch (action) {
            case "list":
                listCategories(request, response);
                break;
            case "create":
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteCategory(request, response);
                break;
            default:
                listCategories(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) {
            String path = request.getPathInfo();
            if (path != null && path.length() > 1) {
                action = path.substring(1);
                if (action.contains("/")) {
                    action = action.substring(0, action.indexOf("/"));
                }
            }
        }
        if (action == null || action.isEmpty()) action = "list";

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

    private void listCategories(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        var categories = categoryService.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/categories.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/add-category.jsp").forward(request, response);
    }

    private void addCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");

        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Name is required");
            showAddForm(request, response);
            return;
        }

        boolean success = categoryService.addCategory(new Category(name, description, null));
        if (success) {
            response.sendRedirect("/servlet-jsp-gr3/categories?action=list");
        } else {
            request.setAttribute("errorMessage", "Failed to add category");
            showAddForm(request, response);
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                response.sendRedirect("/servlet-jsp-gr3/categories?action=list");
                return;
            }

            int id = Integer.parseInt(idStr);
            var category = categoryService.getCategoryById(id);
            if (category == null) {
                response.sendRedirect("/servlet-jsp-gr3/categories?action=list");
                return;
            }

            request.setAttribute("category", category);
            request.getRequestDispatcher("/edit-category.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("/servlet-jsp-gr3/categories?action=list");
        }
    }

    private void updateCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
                response.sendRedirect("/servlet-jsp-gr3/categories?action=list");
            } else {
                request.setAttribute("errorMessage", "Failed to update category");
                showEditForm(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid ID");
            showEditForm(request, response);
        }
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                categoryService.deleteCategory(id);
            } catch (NumberFormatException ignored) {
            }
        }

        response.sendRedirect("/servlet-jsp-gr3/categories?action=list");
    }
}

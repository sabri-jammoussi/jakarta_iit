package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.service.CategoryService;
import org.example.service.ProductService;
import org.example.service.PromotionService;


import java.io.IOException;

@WebServlet(name = "ProductController", urlPatterns = "/products")

public class ProductController extends HttpServlet {
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
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String action = request.getParameter("action");
    if (action == null) action = "list";

    switch (action) {
      case "list":
        listProducts(request, response);
        break;
      case "add":
        showAddForm(request, response);
        break;
      case "edit":
        showEditForm(request, response);
        break;
      case "delete":
        deleteProduct(request, response);
        break;
      case "view":
        viewProduct(request, response);
        break;
      default:
        listProducts(request, response);
    }
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String action = request.getParameter("action");
    if (action == null) action = "list";

    try {
      switch (action) {
        case "add":
          addProduct(request, response);
          break;
        case "edit":
          updateProduct(request, response);
          break;
        case "delete":
          deleteProduct(request, response);
          break;
        default:
          listProducts(request, response);
      }
    } catch (Exception e) {
      throw new ServletException(e);
    }
  }

  private void listProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    var products = productService.getAllProducts();

    // optional category filter from query param
    String categoryParam = request.getParameter("category");
    if (categoryParam != null && !categoryParam.isEmpty()) {
      try {
        int catId = Integer.parseInt(categoryParam);
        var filtered = new java.util.ArrayList<>(products.size());
        for (var p : products) {
          if (p.getCategoryId() == catId) filtered.add(p);
        }
        products = filtered;
      } catch (NumberFormatException ignored) {
      }
    }

    // provide categories for the UI and promotions for client display
    request.setAttribute("categories", categoryService.getAllCategories());
    request.setAttribute("promotions", promotionService.getAllPromotions());

    request.setAttribute("products", products);
    request.getRequestDispatcher("products.jsp").forward(request, response);
  }

  private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    request.setAttribute("categories", categoryService.getAllCategories());
    request.getRequestDispatcher("add-product.jsp").forward(request, response);
  }

  private void addProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      String name = request.getParameter("name");
      String priceStr = request.getParameter("price");
      String description = request.getParameter("description");
      String imageUrl = request.getParameter("imageUrl");
      String categoryIdStr = request.getParameter("categoryId");

      if (name == null || name.trim().isEmpty() || priceStr == null || priceStr.trim().isEmpty()) {
        request.setAttribute("errorMessage", "Name and price are required");
        showAddForm(request, response);
        return;
      }

      double price = Double.parseDouble(priceStr);
      int categoryId = categoryIdStr == null || categoryIdStr.isEmpty() ? 0 : Integer.parseInt(categoryIdStr);

      boolean success = productService.addProduct(name, price, description, categoryId, imageUrl);
      if (success) {
        response.sendRedirect("/servlet-jsp-gr3/products?action=list");
      } else {
        request.setAttribute("errorMessage", "Failed to add product");
        showAddForm(request, response);
      }

    } catch (NumberFormatException e) {
      request.setAttribute("errorMessage", "Invalid number format");
      showAddForm(request, response);
    }
  }

  private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      String idStr = request.getParameter("id");
      if (idStr == null || idStr.trim().isEmpty()) {
        response.sendRedirect("/servlet-jsp-gr3/products?action=list");
        return;
      }

      int id = Integer.parseInt(idStr);
      var product = productService.getProductById(id);
      if (product == null) {
        response.sendRedirect("/servlet-jsp-gr3/products?action=list");
        return;
      }

      request.setAttribute("product", product);
      request.setAttribute("categories", categoryService.getAllCategories());
      request.getRequestDispatcher("edit-product.jsp").forward(request, response);

    } catch (NumberFormatException e) {
      response.sendRedirect("/servlet-jsp-gr3/products?action=list");
    }
  }

  private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      int id = Integer.parseInt(request.getParameter("id"));
      String name = request.getParameter("name");
      double price = Double.parseDouble(request.getParameter("price"));
      String description = request.getParameter("description");
      String imageUrl = request.getParameter("imageUrl");
      int categoryId = Integer.parseInt(request.getParameter("categoryId"));

      boolean success = productService.updateProduct(id, name, price, description, categoryId, imageUrl);
      if (success) {
        response.sendRedirect("/servlet-jsp-gr3/products?action=list");
      } else {
        request.setAttribute("errorMessage", "Failed to update product");
        showEditForm(request, response);
      }

    } catch (NumberFormatException e) {
      request.setAttribute("errorMessage", "Invalid number format");
      showEditForm(request, response);
    }
  }

  private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
    String idStr = request.getParameter("id");
    if (idStr != null && !idStr.isEmpty()) {
      try {
        int id = Integer.parseInt(idStr);
        productService.deleteProduct(id);
      } catch (NumberFormatException ignored) {
      }
    }

    response.sendRedirect("/servlet-jsp-gr3/products?action=list");
  }

  private void viewProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String idStr = request.getParameter("id");
    if (idStr == null) {
      response.sendRedirect("/servlet-jsp-gr3/products?action=list");
      return;
    }
    try {
      int id = Integer.parseInt(idStr);
      var product = productService.getProductById(id);
      request.setAttribute("product", product);
      request.getRequestDispatcher("product-details.jsp").forward(request, response);
    } catch (NumberFormatException e) {
      response.sendRedirect("/servlet-jsp-gr3/products?action=list");
    }
  }

}

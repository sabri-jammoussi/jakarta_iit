package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.service.CategoryService;
import org.example.service.ProductService;


import java.io.IOException;

@WebServlet(name = "ProductController", urlPatterns = "/produits")

public class ProductController  extends HttpServlet {
   private ProductService productService;



    @Override
    public void init() throws ServletException {
        super.init();
      productService =  new ProductService() ;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        var produits = productService.getAllProducts();
        request.setAttribute("products", produits);
        request.getRequestDispatcher("produits.jsp").forward(request, response);
    }
}

package org.example.controller.client;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.model.Product;
import org.example.service.ProductService;
import org.example.service.PromotionService;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

/**
 * Cart Servlet - Handles shopping cart operations for clients
 * Supports: add, remove, update quantity, view cart
 */
@WebServlet(name = "CartServlet", urlPatterns = {"/client/cart", "/cart"})
public class CartServlet extends HttpServlet {

    private ProductService productService;
    private PromotionService promotionService;

    @Override
    public void init() throws ServletException {
        super.init();
        productService = new ProductService();
        promotionService = new PromotionService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) action = "view";

        switch (action) {
            case "remove":
                removeFromCart(request, response);
                break;
            case "clear":
                clearCart(request, response);
                break;
            case "count":
                getCartCount(request, response);
                break;
            case "view":
            default:
                viewCart(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) action = "add";

        switch (action) {
            case "add":
                addToCart(request, response);
                break;
            case "update":
                updateQuantity(request, response);
                break;
            case "remove":
                removeFromCart(request, response);
                break;
            default:
                viewCart(request, response);
        }
    }

    @SuppressWarnings("unchecked")
    private Map<Integer, Integer> getCart(HttpSession session) {
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String productIdStr = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");
        
        if (productIdStr == null || productIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/client/home");
            return;
        }

        try {
            int productId = Integer.parseInt(productIdStr);
            int quantity = (quantityStr != null && !quantityStr.isEmpty()) 
                    ? Integer.parseInt(quantityStr) : 1;
            
            // Verify product exists
            Product product = productService.getProductById(productId);
            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/client/home");
                return;
            }
            
            // Add to cart
            HttpSession session = request.getSession();
            Map<Integer, Integer> cart = getCart(session);
            cart.put(productId, cart.getOrDefault(productId, 0) + quantity);
            session.setAttribute("cart", cart);
            session.setAttribute("cartCount", getCartItemCount(cart));
            
            // Check if AJAX request
            String ajax = request.getParameter("ajax");
            if ("true".equals(ajax)) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                out.print("{\"success\": true, \"cartCount\": " + getCartItemCount(cart) + "}");
                out.flush();
            } else {
                // Redirect back to where user came from
                String referer = request.getHeader("Referer");
                if (referer != null && !referer.isEmpty()) {
                    response.sendRedirect(referer);
                } else {
                    response.sendRedirect(request.getContextPath() + "/client/home");
                }
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/client/home");
        }
    }

    private void removeFromCart(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String productIdStr = request.getParameter("productId");
        if (productIdStr == null || productIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/client/cart");
            return;
        }

        try {
            int productId = Integer.parseInt(productIdStr);
            
            HttpSession session = request.getSession();
            Map<Integer, Integer> cart = getCart(session);
            cart.remove(productId);
            session.setAttribute("cart", cart);
            session.setAttribute("cartCount", getCartItemCount(cart));
            
            response.sendRedirect(request.getContextPath() + "/client/cart");
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/client/cart");
        }
    }

    private void updateQuantity(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String productIdStr = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");
        
        if (productIdStr == null || quantityStr == null) {
            response.sendRedirect(request.getContextPath() + "/client/cart");
            return;
        }

        try {
            int productId = Integer.parseInt(productIdStr);
            int quantity = Integer.parseInt(quantityStr);
            
            HttpSession session = request.getSession();
            Map<Integer, Integer> cart = getCart(session);
            
            if (quantity <= 0) {
                cart.remove(productId);
            } else {
                cart.put(productId, quantity);
            }
            
            session.setAttribute("cart", cart);
            session.setAttribute("cartCount", getCartItemCount(cart));
            
            response.sendRedirect(request.getContextPath() + "/client/cart");
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/client/cart");
        }
    }

    private void clearCart(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        HttpSession session = request.getSession();
        session.removeAttribute("cart");
        session.setAttribute("cartCount", 0);
        
        response.sendRedirect(request.getContextPath() + "/client/cart");
    }

    private void viewCart(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Map<Integer, Integer> cart = getCart(session);
        
        // Build cart items with product details
        java.util.List<Map<String, Object>> cartItems = new java.util.ArrayList<>();
        double subtotal = 0;
        
        for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
            Product product = productService.getProductById(entry.getKey());
            if (product != null) {
                Map<String, Object> item = new HashMap<>();
                item.put("product", product);
                item.put("quantity", entry.getValue());
                item.put("itemTotal", product.getPrice() * entry.getValue());
                cartItems.add(item);
                subtotal += product.getPrice() * entry.getValue();
            }
        }
        
        // Calculate discount if there's an active promotion
        var bestPromotion = promotionService.getBestActivePromotion();
        double discount = 0;
        double total = subtotal;
        
        if (bestPromotion != null) {
            discount = subtotal * (bestPromotion.getPromotionValeur() / 100);
            total = subtotal - discount;
        }
        
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("discount", discount);
        request.setAttribute("total", total);
        request.setAttribute("bestPromotion", bestPromotion);
        
        session.setAttribute("cartCount", getCartItemCount(cart));
        
        request.getRequestDispatcher("/client/cart.jsp").forward(request, response);
    }

    private void getCartCount(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        HttpSession session = request.getSession(false);
        int count = 0;
        
        if (session != null) {
            Map<Integer, Integer> cart = getCart(session);
            count = getCartItemCount(cart);
        }
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print("{\"count\": " + count + "}");
        out.flush();
    }

    private int getCartItemCount(Map<Integer, Integer> cart) {
        return cart.values().stream().mapToInt(Integer::intValue).sum();
    }
}

package org.example.controller.client;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.model.Commande;
import org.example.model.CommandeItem;
import org.example.model.Product;
import org.example.service.CommandeService;
import org.example.service.ProductService;
import org.example.service.PromotionService;

import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * Order Servlet - Handles checkout and order viewing for clients
 */
@WebServlet(name = "OrderServlet", urlPatterns = {"/client/orders", "/client/checkout"})
public class OrderServlet extends HttpServlet {

    private CommandeService commandeService;
    private ProductService productService;
    private PromotionService promotionService;

    @Override
    public void init() throws ServletException {
        super.init();
        commandeService = new CommandeService();
        productService = new ProductService();
        promotionService = new PromotionService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String path = request.getServletPath();
        
        if ("/client/orders".equals(path)) {
            viewOrders(request, response);
        } else {
            // Default - view orders
            viewOrders(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String path = request.getServletPath();
        
        if ("/client/checkout".equals(path)) {
            processCheckout(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/client/cart");
        }
    }

    /**
     * View user's orders
     */
    private void viewOrders(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        String email = session != null ? (String) session.getAttribute("email") : null;
        
        if (email == null) {
            // User not logged in - redirect to login
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }
        
        List<Commande> orders = commandeService.getCommandesByUserEmail(email);
        request.setAttribute("orders", orders);
        
        request.getRequestDispatcher("/client/orders.jsp").forward(request, response);
    }

    /**
     * Process checkout - create order from cart
     */
    @SuppressWarnings("unchecked")
    private void processCheckout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in
        String email = session != null ? (String) session.getAttribute("email") : null;
        if (email == null) {
            // Store a message and redirect to login
            session = request.getSession(true);
            session.setAttribute("checkoutMessage", "Please login to complete your order");
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }
        
        // Get cart
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/client/cart");
            return;
        }
        
        // Build order
        Commande commande = new Commande();
        commande.setUserEmail(email);
        commande.setUserFullname((String) session.getAttribute("fullname"));
        commande.setStatus("PENDING");
        
        double subtotal = 0;
        
        for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
            Product product = productService.getProductById(entry.getKey());
            if (product != null) {
                CommandeItem item = new CommandeItem(
                    product.getId(),
                    product.getName(),
                    product.getPrice(),
                    entry.getValue()
                );
                commande.addItem(item);
                subtotal += item.getItemTotal();
            }
        }
        
        // Calculate discount
        var bestPromotion = promotionService.getBestActivePromotion();
        double discount = 0;
        double total = subtotal;
        
        if (bestPromotion != null) {
            discount = subtotal * (bestPromotion.getPromotionValeur() / 100);
            total = subtotal - discount;
        }
        
        commande.setSubtotal(subtotal);
        commande.setDiscount(discount);
        commande.setTotal(total);
        
        // Save order
        Commande savedOrder = commandeService.createCommande(commande);
        
        if (savedOrder != null) {
            // Clear cart
            session.removeAttribute("cart");
            session.setAttribute("cartCount", 0);
            
            // Redirect to orders with success message
            session.setAttribute("orderSuccess", "Order #" + savedOrder.getId() + " placed successfully!");
            response.sendRedirect(request.getContextPath() + "/client/orders");
        } else {
            // Error creating order
            request.setAttribute("error", "Failed to create order. Please try again.");
            request.getRequestDispatcher("/client/cart.jsp").forward(request, response);
        }
    }
}

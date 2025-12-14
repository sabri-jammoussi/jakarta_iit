package org.example.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.model.Commande;
import org.example.service.CommandeService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderAdminServlet", urlPatterns = {"/admin/orders"})
public class OrderAdminServlet extends HttpServlet {

    private CommandeService commandeService;

    @Override
    public void init() throws ServletException {
        super.init();
        commandeService = new CommandeService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        List<Commande> commandes = commandeService.getAllCommandes();
        request.setAttribute("commandes", commandes);
        request.getRequestDispatcher("/admin/orders.jsp").forward(request, response);
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

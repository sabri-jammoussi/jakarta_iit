package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.model.User;
import org.example.service.UserService;

import java.io.IOException;
import java.util.Optional;

@WebServlet(name = "AuthController", urlPatterns = {"/auth" , "/auth/*"})
public class AuthController extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        super.init();
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) {
            String p = request.getPathInfo();
            if (p != null && p.length() > 1) action = p.substring(1);
        }
        if (action == null || action.isEmpty()) action = "login";

        switch (action) {
            case "login":
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                break;
            case "register":
                request.getRequestDispatcher("/register.jsp").forward(request, response);
                break;
            case "logout":
                request.getSession().invalidate();
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                break;
            default:
                request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) action = "login";

        switch (action) {
            case "login":
                handleLogin(request, response);
                break;
            case "register":
                handleRegister(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String email = request.getParameter("email");
        String pwd = request.getParameter("password");
        if (email == null || pwd == null) {
            request.setAttribute("error", "Email and password required");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        Optional<User> userOpt = userService.findUserByEmailAndPwd(email, pwd);
        if (userOpt.isPresent()) {
            User u = userOpt.get();
            request.getSession().setAttribute("email", u.getEmail());
            request.getSession().setAttribute("fullname", u.getFullname() == null ? u.getEmail() : u.getFullname());
            request.getSession().setAttribute("role", u.getRole() == null ? "USER" : u.getRole());

            // Redirect based on role - Admin goes to admin dashboard, users to client home
            String role = (String) request.getSession().getAttribute("role");
            if ("ADMIN".equalsIgnoreCase(role) || "ROLE_ADMIN".equalsIgnoreCase(role)) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/client/home");
            }
        } else {
            request.setAttribute("error", "Invalid credentials");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String pwd = request.getParameter("password");
        String fullname = request.getParameter("fullname");

        if (email == null || pwd == null || email.isEmpty() || pwd.isEmpty()) {
            request.setAttribute("error", "Email and password are required");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        boolean ok = userService.registerUser(email, pwd, fullname);
        if (ok) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
        } else {
            request.setAttribute("error", "Failed to register (email may already exist)");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}

package org.example.security.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebFilter(urlPatterns = {"/promotions","/promotions/*","/products","/products/*","/categories","/categories/*"})
public class AuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        String fullname = null;
        if (req.getSession(false) != null) {
            fullname = (String) req.getSession().getAttribute("fullname");
        }
        if (fullname == null || fullname.isEmpty()) {
            ((HttpServletResponse) response).sendRedirect(req.getContextPath() + "/auth?action=login");
            return;
        }
        filterChain.doFilter(request, response);
    }
}

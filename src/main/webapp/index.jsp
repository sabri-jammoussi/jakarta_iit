<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
  <% // Index page - redirects all users to client home // Admins can access admin dashboard via navbar link after login
    String context=request.getContextPath(); response.sendRedirect(context + "/client/home" ); %>
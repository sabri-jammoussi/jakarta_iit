<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
  <% String context=request.getContextPath(); jakarta.servlet.http.HttpSession s=request.getSession(false); String
    role=null; if (s !=null) { Object r=s.getAttribute("role"); if (r !=null) role=r.toString(); } if (role !=null &&
    ("ADMIN".equalsIgnoreCase(role) || "ROLE_ADMIN" .equalsIgnoreCase(role))) { response.sendRedirect(context
    + "/promotions?action=list" ); } else { response.sendRedirect(context + "/home.jsp" ); } %>
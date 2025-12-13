package org.example.model;

import java.sql.Timestamp;
import java.util.List;
import java.util.ArrayList;

public class Commande {
    private int id;
    private int userId;
    private String userEmail;
    private String userFullname;
    private double subtotal;
    private double discount;
    private double total;
    private String status; // PENDING, CONFIRMED, SHIPPED, DELIVERED, CANCELLED
    private Timestamp createdAt;
    private List<CommandeItem> items;

    public Commande() {
        this.items = new ArrayList<>();
        this.status = "PENDING";
    }

    public Commande(int userId, double subtotal, double discount, double total) {
        this();
        this.userId = userId;
        this.subtotal = subtotal;
        this.discount = discount;
        this.total = total;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserFullname() {
        return userFullname;
    }

    public void setUserFullname(String userFullname) {
        this.userFullname = userFullname;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public List<CommandeItem> getItems() {
        return items;
    }

    public void setItems(List<CommandeItem> items) {
        this.items = items;
    }

    public void addItem(CommandeItem item) {
        this.items.add(item);
    }

    public int getItemCount() {
        return items.stream().mapToInt(CommandeItem::getQuantity).sum();
    }
}

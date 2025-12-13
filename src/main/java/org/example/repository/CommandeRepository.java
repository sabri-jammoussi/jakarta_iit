package org.example.repository;

import org.example.config.DatabaseConfig;
import org.example.model.Commande;
import org.example.model.CommandeItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommandeRepository {

    public CommandeRepository() {}

    /**
     * Create a new order and its items
     * Returns the created order with ID
     */
    public Commande createCommande(Commande commande) {
        String sqlCommande = "INSERT INTO commande (user_id, user_email, user_fullname, subtotal, discount, total, status, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, NOW())";
        String sqlItem = "INSERT INTO commande_item (commande_id, product_id, product_name, product_price, quantity, item_total) VALUES (?, ?, ?, ?, ?, ?)";

        Connection conn = null;
        try {
            conn = DatabaseConfig.getConnection();
            conn.setAutoCommit(false);

            // Insert commande
            try (PreparedStatement pstmt = conn.prepareStatement(sqlCommande, Statement.RETURN_GENERATED_KEYS)) {
                pstmt.setInt(1, commande.getUserId());
                pstmt.setString(2, commande.getUserEmail());
                pstmt.setString(3, commande.getUserFullname());
                pstmt.setDouble(4, commande.getSubtotal());
                pstmt.setDouble(5, commande.getDiscount());
                pstmt.setDouble(6, commande.getTotal());
                pstmt.setString(7, commande.getStatus());
                pstmt.executeUpdate();

                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    commande.setId(rs.getInt(1));
                }
            }

            // Insert items
            try (PreparedStatement pstmt = conn.prepareStatement(sqlItem)) {
                for (CommandeItem item : commande.getItems()) {
                    pstmt.setInt(1, commande.getId());
                    pstmt.setInt(2, item.getProductId());
                    pstmt.setString(3, item.getProductName());
                    pstmt.setDouble(4, item.getProductPrice());
                    pstmt.setInt(5, item.getQuantity());
                    pstmt.setDouble(6, item.getItemTotal());
                    pstmt.addBatch();
                }
                pstmt.executeBatch();
            }

            conn.commit();
            return commande;

        } catch (SQLException e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
            return null;
        } finally {
            if (conn != null) {
                try { 
                    conn.setAutoCommit(true);
                    conn.close(); 
                } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }

    /**
     * Get all orders for a specific user
     */
    public List<Commande> getCommandesByUserId(int userId) {
        List<Commande> commandes = new ArrayList<>();
        String sql = "SELECT * FROM commande WHERE user_id = ? ORDER BY created_at DESC";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Commande c = mapRowToCommande(rs);
                c.setItems(getCommandeItems(c.getId()));
                commandes.add(c);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return commandes;
    }

    /**
     * Get all orders by user email
     */
    public List<Commande> getCommandesByUserEmail(String email) {
        List<Commande> commandes = new ArrayList<>();
        String sql = "SELECT * FROM commande WHERE user_email = ? ORDER BY created_at DESC";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Commande c = mapRowToCommande(rs);
                c.setItems(getCommandeItems(c.getId()));
                commandes.add(c);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return commandes;
    }

    /**
     * Get all orders (for admin)
     */
    public List<Commande> getAllCommandes() {
        List<Commande> commandes = new ArrayList<>();
        String sql = "SELECT * FROM commande ORDER BY created_at DESC";

        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Commande c = mapRowToCommande(rs);
                c.setItems(getCommandeItems(c.getId()));
                commandes.add(c);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return commandes;
    }

    /**
     * Get a single order by ID
     */
    public Commande getCommandeById(int id) {
        String sql = "SELECT * FROM commande WHERE id = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                Commande c = mapRowToCommande(rs);
                c.setItems(getCommandeItems(c.getId()));
                return c;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Get items for a specific order
     */
    public List<CommandeItem> getCommandeItems(int commandeId) {
        List<CommandeItem> items = new ArrayList<>();
        String sql = "SELECT * FROM commande_item WHERE commande_id = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, commandeId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                CommandeItem item = new CommandeItem();
                item.setId(rs.getInt("id"));
                item.setCommandeId(rs.getInt("commande_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setProductName(rs.getString("product_name"));
                item.setProductPrice(rs.getDouble("product_price"));
                item.setQuantity(rs.getInt("quantity"));
                item.setItemTotal(rs.getDouble("item_total"));
                items.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return items;
    }

    /**
     * Update order status
     */
    public boolean updateCommandeStatus(int commandeId, String status) {
        String sql = "UPDATE commande SET status = ? WHERE id = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, status);
            pstmt.setInt(2, commandeId);
            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Count total orders (for admin dashboard)
     */
    public int countCommandes() {
        String sql = "SELECT COUNT(*) FROM commande";

        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    private Commande mapRowToCommande(ResultSet rs) throws SQLException {
        Commande c = new Commande();
        c.setId(rs.getInt("id"));
        c.setUserId(rs.getInt("user_id"));
        c.setUserEmail(rs.getString("user_email"));
        c.setUserFullname(rs.getString("user_fullname"));
        c.setSubtotal(rs.getDouble("subtotal"));
        c.setDiscount(rs.getDouble("discount"));
        c.setTotal(rs.getDouble("total"));
        c.setStatus(rs.getString("status"));
        c.setCreatedAt(rs.getTimestamp("created_at"));
        return c;
    }
}

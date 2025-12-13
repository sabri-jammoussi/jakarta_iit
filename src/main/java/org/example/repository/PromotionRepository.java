package org.example.repository;

import org.example.config.DatabaseConfig;
import org.example.model.Promotion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PromotionRepository {

    public PromotionRepository() {
    }

    // Get all promotions
    public List<Promotion> getAllPromotions() {
        List<Promotion> promotions = new ArrayList<>();
        String sql = "SELECT * FROM Promotion";

        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                int id = rs.getInt("id");
                Date dateDebut = rs.getDate("date_promotion_debut");
                Date dateFin = rs.getDate("date_promotion_fin");
                double valeur = rs.getDouble("promotion_valeur");

                Promotion promotion = new Promotion( dateDebut, dateFin, valeur);
                promotion.setId(id);
                promotions.add(promotion);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return promotions;
    }

    // Get promotion by ID
    public Promotion getPromotionById(int id) {
        String sql = "SELECT * FROM Promotion WHERE id = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                Date dateDebut = rs.getDate("date_promotion_debut");
                Date dateFin = rs.getDate("date_promotion_fin");
                double valeur = rs.getDouble("promotion_valeur");

                Promotion promotion = new Promotion( dateDebut, dateFin, valeur);
                promotion.setId(id);
                return promotion;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // Get active promotions (current date is between start and end date)
    public List<Promotion> getActivePromotions() {
        List<Promotion> promotions = new ArrayList<>();
        String sql = "SELECT * FROM Promotion WHERE CURDATE() BETWEEN date_promotion_debut AND date_promotion_fin";

        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                int id = rs.getInt("id");
                Date dateDebut = rs.getDate("date_promotion_debut");
                Date dateFin = rs.getDate("date_promotion_fin");
                double valeur = rs.getDouble("promotion_valeur");

                Promotion promotion = new Promotion( dateDebut, dateFin, valeur);
                promotion.setId(id);
                promotions.add(promotion);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return promotions;
    }

    // Get upcoming promotions
    public List<Promotion> getUpcomingPromotions() {
        List<Promotion> promotions = new ArrayList<>();
        String sql = "SELECT * FROM Promotion WHERE date_promotion_debut > CURDATE() ORDER BY date_promotion_debut";

        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                int id = rs.getInt("id");
                Date dateDebut = rs.getDate("date_promotion_debut");
                Date dateFin = rs.getDate("date_promotion_fin");
                double valeur = rs.getDouble("promotion_valeur");

                Promotion promotion = new Promotion(dateDebut, dateFin, valeur);
                promotion.setId(id);
                promotions.add(promotion);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return promotions;
    }

    // Add a new promotion
    public boolean addPromotion(Promotion promotion) {
        String sql = "INSERT INTO Promotion (date_promotion_debut, date_promotion_fin, promotion_valeur) VALUES (?, ?, ?)";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setDate(1, new java.sql.Date(promotion.getDatePromotionDebut().getTime()));
            pstmt.setDate(2, new java.sql.Date(promotion.getDatePromotionFin().getTime()));
            pstmt.setDouble(3, promotion.getPromotionValeur());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update a promotion
    public boolean updatePromotion(int id, Promotion promotion) {
        String sql = "UPDATE Promotion SET date_promotion_debut = ?, date_promotion_fin = ?, promotion_valeur = ? WHERE id = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setDate(1, new java.sql.Date(promotion.getDatePromotionDebut().getTime()));
            pstmt.setDate(2, new java.sql.Date(promotion.getDatePromotionFin().getTime()));
            pstmt.setDouble(3, promotion.getPromotionValeur());
            pstmt.setInt(4, id);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete a promotion
    public boolean deletePromotion(int id) {
        String sql = "DELETE FROM Promotion WHERE id = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
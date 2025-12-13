package org.example.repository;

import org.example.config.DatabaseConfig;
import org.example.model.Category;
import org.example.model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryRepository {

    public CategoryRepository() {
    }

    // Get all categories
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM Category";

        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                int id = rs.getInt("id");
                    String name = rs.getString("name");
                String description = rs.getString("description");

                // Get products for this category
                List<Product> products = getProductsByCategory(id);

                    Category category = new Category(id, name, description, products);
                categories.add(category);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }

    // Get category by ID
    public Category getCategoryById(int id) {
        String sql = "SELECT * FROM Category WHERE id = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn. prepareStatement(sql)) {

            pstmt.setInt(1, id);
            ResultSet rs = pstmt. executeQuery();

            if (rs.next()) {
                String name = rs.getString("name");
                String description = rs.getString("description");

                // Get products for this category
                List<Product> products = getProductsByCategory(id);

             return new Category(id, name, description, products);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // Get products by category ID
    private List<Product> getProductsByCategory(int categoryId) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Product WHERE category_id = ? ";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, categoryId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                String name = rs.getString("name");
                double price = rs.getDouble("price");
                String description = rs.getString("description");
                String imageUrl = null;
                try { imageUrl = rs.getString("image_url"); } catch (SQLException ignore) {}
                Product product = new Product(name, price, description, categoryId, imageUrl);
                products.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    // Add a new category
    public boolean addCategory(Category category) {
        String sql = "INSERT INTO Category (name, description) VALUES (?, ?)";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, category.getName());
            pstmt.setString(2, category.getDescription());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update a category
    public boolean updateCategory(int id, Category category) {
        String sql = "UPDATE Category SET name = ?, description = ? WHERE id = ?";

        try (Connection conn = DatabaseConfig. getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, category.getName());
            pstmt.setString(2, category.getDescription());
            pstmt.setInt(3, id);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete a category
    public boolean deleteCategory(int id) {
        String sql = "DELETE FROM Category WHERE id = ?";

        try (Connection conn = DatabaseConfig. getConnection();
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
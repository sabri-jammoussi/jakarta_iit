package org.example.repository;

import org.example.config.DatabaseConfig;
import org.example.model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductRepository {

	public ProductRepository() {
	}

	public List<Product> getAllProducts() {
		List<Product> products = new ArrayList<>();
		String sql = "SELECT * FROM Product";

		try (Connection conn = DatabaseConfig.getConnection();
			 Statement stmt = conn.createStatement();
			 ResultSet rs = stmt.executeQuery(sql)) {

			while (rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("name");
				double price = rs.getDouble("price");
				String description = rs.getString("description");
				int categoryId = rs.getInt("category_id");

				Product p = new Product(id, name, price, description, categoryId);
				products.add(p);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return products;
	}

	public Product getProductById(int id) {
		String sql = "SELECT * FROM Product WHERE id = ?";

		try (Connection conn = DatabaseConfig.getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				String name = rs.getString("name");
				double price = rs.getDouble("price");
				String description = rs.getString("description");
				int categoryId = rs.getInt("category_id");

				return new Product(id, name, price, description, categoryId);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null;
	}

	public boolean addProduct(Product product) {
		String sql = "INSERT INTO Product (name, price, description, category_id) VALUES (?, ?, ?, ?)";

		try (Connection conn = DatabaseConfig.getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, product.getName());
			pstmt.setDouble(2, product.getPrice());
			pstmt.setString(3, product.getDescription());
			pstmt.setInt(4, product.getCategoryId());

			int rows = pstmt.executeUpdate();
			return rows > 0;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean updateProduct(int id, Product product) {
		String sql = "UPDATE Product SET name = ?, price = ?, description = ?, category_id = ? WHERE id = ?";

		try (Connection conn = DatabaseConfig.getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, product.getName());
			pstmt.setDouble(2, product.getPrice());
			pstmt.setString(3, product.getDescription());
			pstmt.setInt(4, product.getCategoryId());
			pstmt.setInt(5, id);

			int rows = pstmt.executeUpdate();
			return rows > 0;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean deleteProduct(int id) {
		String sql = "DELETE FROM Product WHERE id = ?";

		try (Connection conn = DatabaseConfig.getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, id);
			int rows = pstmt.executeUpdate();
			return rows > 0;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
}

package org.example.repository;

import org.example.config.DatabaseConfig;
import org.example.model.User;

import java.sql.*;
import java.util.Optional;

public class UserRepository {

    public UserRepository() {}

    public Optional<User> findUserByEmailAndPwd(String email, String pwd) {
        String sql = "SELECT id, email, password, fullname, role FROM users WHERE email = ? AND password = ?";
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, email);
            pstmt.setString(2, pwd);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                String e = rs.getString("email");
                String full = rs.getString("fullname");
                String role = rs.getString("role");
                return Optional.of(new User(id, e, pwd, full, role));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return Optional.empty();
    }

    public boolean addUser(User user) {
        String sql = "INSERT INTO users (email, password, fullname, role) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, user.getEmail());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getFullname());
            pstmt.setString(4, user.getRole() == null ? "USER" : user.getRole());
            int r = pstmt.executeUpdate();
            return r > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }
}

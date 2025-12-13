package org.example.config;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DatabaseConfig {

    private static String URL;
    private static String USER;
    private static String PASSWORD;

    // Static block to load properties when class is loaded
    static {
        try {
            loadProperties();
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to load database properties", e);
        }
    }

    // Load properties from db.properties file
    private static void loadProperties() throws IOException {
        Properties properties = new Properties();

        // Load from resources folder
        try (InputStream input = DatabaseConfig.class.getClassLoader()
                .getResourceAsStream("db.properties")) {

            if (input == null) {
                throw new IOException("Unable to find db.properties");
            }

            properties.load(input);

            URL = properties.getProperty("jdbc.url");
            USER = properties.getProperty("jdbc.user");
            PASSWORD = properties.getProperty("jdbc.password");

        }
    }

    // Get database connection
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found", e);
        }
    }

    // Test connection method (optional)
    public static boolean testConnection() {
        try (Connection conn = getConnection()) {
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
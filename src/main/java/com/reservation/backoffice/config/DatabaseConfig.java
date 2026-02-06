package com.reservation.backoffice.config;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Classe de configuration pour la connexion à la base de données PostgreSQL.
 */
public class DatabaseConfig {

    private static final Properties props = new Properties();
    private static String url;
    private static String username;
    private static String password;

    static {
        try (InputStream input = DatabaseConfig.class.getClassLoader()
                .getResourceAsStream("database.properties")) {
            if (input != null) {
                props.load(input);
                String driver = props.getProperty("db.driver");
                url = props.getProperty("db.url");
                username = props.getProperty("db.username");
                password = props.getProperty("db.password");
                Class.forName(driver);
            } else {
                throw new RuntimeException("database.properties introuvable dans le classpath");
            }
        } catch (Exception e) {
            throw new RuntimeException("Erreur de chargement de la configuration DB", e);
        }
    }

    /**
     * Obtenir une connexion à la base de données.
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, username, password);
    }

    /**
     * Fermer une connexion proprement.
     */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

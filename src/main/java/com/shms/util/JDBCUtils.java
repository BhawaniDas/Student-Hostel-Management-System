package com.shms.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class JDBCUtils {
    private static String jdbcURL;
    private static String jdbcUsername;
    private static String jdbcPassword;

    static {
        try {
            Properties prop = new Properties();
            prop.load(JDBCUtils.class.getClassLoader().getResourceAsStream("db.properties"));
            jdbcURL = prop.getProperty("db.url");
            jdbcUsername = prop.getProperty("db.username");
            jdbcPassword = prop.getProperty("db.password");
            Class.forName("com.mysql.cj.jdbc.Driver"); // Important for MySQL 8+
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }
}

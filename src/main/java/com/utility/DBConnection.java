package com.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    public Connection getConnection() {

        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Read environment variables
            String host = System.getenv("MYSQLHOST");
            String port = System.getenv("MYSQLPORT");
            String database = System.getenv("MYSQLDATABASE");
            String username = System.getenv("MYSQLUSER");
            String password = System.getenv("MYSQLPASSWORD");

            String url;

            // If cloud variables are available
            if (host != null && port != null &&
                database != null && username != null &&
                password != null) {

                url = "jdbc:mysql://" + host + ":" +
                      port + "/" + database;

            } else {

                // Local development connection
                url = "jdbc:mysql://localhost:3306/health_nutrition_assistant";

                username = "root";
                password = "root";
            }

            con = DriverManager.getConnection(
                url, username, password
            );

            System.out.println("Database connected successfully!");

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}

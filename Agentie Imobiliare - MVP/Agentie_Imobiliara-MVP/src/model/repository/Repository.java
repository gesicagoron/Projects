package model.repository;

import java.sql.*;

public class Repository {
    private static final String URL = "jdbc:mysql://localhost:3306/agentie";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "Gesicasql1vtm";

    protected Connection connection;

    public Repository() {
        try {
            this.connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Connection getConnection() {
        return this.connection;
    }

    public void openingConnection() {
        try {
            if (this.connection != null && !this.connection.isClosed())
                return;
            this.connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void closingConnection() {
        try {
            if (this.connection != null && !this.connection.isClosed())
                this.connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean commandSQL(String commandSQL) {
        boolean result = true;
        try {
            openingConnection();
            Statement statement = this.connection.createStatement();
            if (statement.executeUpdate(commandSQL) == 0)
                result = false;
        } catch (SQLException e) {
            e.printStackTrace();
            result = false;
        } finally {
            closingConnection();
        }
        return result;
    }

    public ResultSet getResultSet(String commandSQL) {
        ResultSet result = null;
        try {
            openingConnection();
            PreparedStatement statement = this.connection.prepareStatement(commandSQL);
            result = statement.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }


    public boolean testDataRetrieval() {
        boolean dataRetrieved = false;
        try {
            openingConnection();
            PreparedStatement statement = this.connection.prepareStatement("SELECT * FROM client");
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                dataRetrieved = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closingConnection();
        }
        return dataRetrieved;
    }
}

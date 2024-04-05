package model.repository;

import model.User;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserRepository {

    private Repository repository;

    public UserRepository()
    {
        this.repository = new Repository();
    }

    public boolean addUser(User user) {
        String commandSQL = "insert into users values('" +
                user.getUserID() + "','" +
                user.getUsername() + "','" +
                user.getPassword() + "','" +
                user.getRole() +
                "')";
        return this.repository.commandSQL(commandSQL);
    }

    public boolean deleteUser(int userID) {
        String commandSQL = "delete from users where idusers = '" + userID + "'";
        return this.repository.commandSQL(commandSQL);
    }

    public List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();
        String selectSQL = "SELECT * FROM users";
        try {
            ResultSet resultSet = this.repository.getResultSet(selectSQL);
            while (resultSet.next()) {
                User user = new User();
                user.setUserID(resultSet.getInt("idusers"));
                user.setUsername(resultSet.getString("username"));
                user.setPassword(resultSet.getString("password"));
                user.setRole(resultSet.getString("role"));
                userList.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }

    public boolean updateUser(int userID, User user) {
        String commandSQL = "update users set username = '" +
                user.getUsername() + "', password = '" +
                user.getPassword() + "', role = '" +
                user.getRole() + "' where idusers = '" + userID + "'";
        return this.repository.commandSQL(commandSQL);
    }


    public User findUserByUsernameAndPassword(String username, String password) {
        User user = null;
        String selectSQL = "SELECT * FROM users WHERE username = ? AND password = ?";
        try {
            repository.openingConnection();

            PreparedStatement preparedStatement = repository.getConnection().prepareStatement(selectSQL);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                user = new User();
                user.setUserID(resultSet.getInt("idusers"));
                user.setUsername(resultSet.getString("username"));
                user.setPassword(resultSet.getString("password"));
                user.setRole(resultSet.getString("role"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            repository.closingConnection();
        }
        return user;
    }

}

package presenter;

import model.User;
import model.repository.UserRepository;
import view.AdminView;
import view.ClientView;
import view.EmployeeView;
import view.LoginForm;

import javax.swing.*;

public class LoginPresenter {
    private LoginForm loginForm;
    private UserRepository userRepository;

    public LoginPresenter(LoginForm loginForm, UserRepository userRepository) {
        this.loginForm = loginForm;
        this.userRepository = userRepository;
        initPresenter();
    }

    private void initPresenter() {
        loginForm.addLoginButtonListener(e -> performLogin());
    }

    private void performLogin() {
        String username = loginForm.getUsername();
        String password = new String(loginForm.getPassword());

        User user = userRepository.findUserByUsernameAndPassword(username, password);
        if (user != null) {
            loginForm.dispose(); // Close the login form
            System.out.println("Login successful for user: " + user.getUsername());

            switch (user.getRole().toLowerCase()) {
                case "admin":
                    // Open the Admin view and connect it with its presenter
                    AdminView adminView = new AdminView();
                    AdminPresenter adminPresenter = new AdminPresenter(adminView);
                    adminView.setVisible(true); // Make the AdminView visible
                    break;
                case "employee":
                    // Similar setup for EmployeeView and its presenter
                    EmployeeView employeeView = new EmployeeView();
                    EmployeePresenter employeePresenter = new EmployeePresenter(employeeView);
                    employeeView.setVisible(true); // Make the EmployeeView visible
                    break;
                default:
                    JOptionPane.showMessageDialog(loginForm, "Unsupported role: " + user.getRole(), "Login Error", JOptionPane.ERROR_MESSAGE);
                    break;
            }
        } else {
            JOptionPane.showMessageDialog(loginForm, "Invalid username or password.", "Login Failed", JOptionPane.ERROR_MESSAGE);
        }
    }


}

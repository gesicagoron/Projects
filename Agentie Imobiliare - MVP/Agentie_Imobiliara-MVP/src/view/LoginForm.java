package view;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionListener;

public class LoginForm extends JDialog implements ILoginForm{
    private JTextField tfEmail;
    private JPasswordField pfPassword;
    private JButton btnLogin;
    private JPanel loginPannel;

    public LoginForm(JFrame parent)
    {
        super(parent);
        setTitle("Login");
        setContentPane(loginPannel);
        setMinimumSize(new Dimension(450,474));
        setModal(true);
        setLocationRelativeTo(parent);
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        setVisible(true);
    }

    @Override
    public String getUsername() {
        return tfEmail.getText();
    }

    @Override
    public String getPassword() {
        return new String(pfPassword.getPassword()); // Correctly converting char[] to String
    }

    @Override
    public void addLoginButtonListener(ActionListener loginListener) {
        btnLogin.addActionListener(loginListener);
    }

    @Override
    public void displayErrorMessage(String errorMessage) {
        JOptionPane.showMessageDialog(this, errorMessage, "Error", JOptionPane.ERROR_MESSAGE);
    }

    @Override
    public void closeView() {
        dispose();
    }

}

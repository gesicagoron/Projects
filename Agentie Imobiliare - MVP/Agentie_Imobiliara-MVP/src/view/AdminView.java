package view;
import javax.swing.*;

public class AdminView {
    private JFrame frame;
    private JPanel adminPannel;
    private JButton filtrareListaButton;
    private JButton vizualizareListaButton;
    private JButton vizualizareUtilizatoriButton;
    private JButton addEmployeeButton;
    private JButton addAdminButton;
    private JButton deleteUserButton;
    private JTextField usernameField;
    private JTextField passwordField;
    private JTextField roleField;
    private JTextField usernameFieldDel;

    public AdminView() {
        initialize();
    }

    private void initialize() {
        frame = new JFrame();
        frame.setTitle("Admin View");
        frame.setSize(400, 300);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        // Add Swing components to frame
        JLabel label = new JLabel("Welcome, Admin!");
        frame.add(label);
        frame.setVisible(false); // Initially set to false, to be controlled by showView
    }

    // Add this method to control the visibility of the frame
// In AdminView.java
    public void showView() {
        this.setVisible(true);
    }

    public void setVisible(boolean b) {
        this.setVisible(true);
    }
}

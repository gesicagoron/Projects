package view;

import javax.swing.*;

public class EmployeeView {
    private JFrame frame;

    public EmployeeView() {
        initialize();
    }

    private void initialize() {
        frame = new JFrame();
        frame.setTitle("Employee View");
        frame.setSize(400, 300);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        // Adăugați componente Swing la frame
        JLabel label = new JLabel("Welcome, Employee!");
        frame.add(label);
        frame.setVisible(true);
    }

    // Adăugați metode pentru a actualiza vizualizarea, după necesitate
    public void showView() {
        this.frame.setVisible(true);
    }

    public void setVisible(boolean b) {
        this.setVisible(true);
    }
}

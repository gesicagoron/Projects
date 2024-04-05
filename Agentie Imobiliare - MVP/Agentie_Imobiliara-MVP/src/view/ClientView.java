package view;

import javax.swing.*;
import java.awt.*;

public class ClientView extends JDialog{

    private JPanel clientPannel;
    private JButton loginButton;
    private JButton filtrareListaButton;


    public ClientView(JFrame parent)
    {
        super(parent);
        setTitle("Client");
        setContentPane(clientPannel);
        setMinimumSize(new Dimension(450,474));
        setModal(true);
        setLocationRelativeTo(parent);
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        setVisible(true);
    }

    public void showView() {
        this.setVisible(true);
    }

}

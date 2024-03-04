import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.util.regex.*;

public class MainFrame extends JFrame {
    private JTextField poli1, poli2;
    private JLabel rezultat;

    public MainFrame() {
        setTitle("Calculator polinomial");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(500, 300);

        JPanel inputPanel = new JPanel();
        inputPanel.setLayout(new GridLayout(0, 1));
        inputPanel.add(new JLabel("Polinom 1:"));
        poli1 = new JTextField();
        inputPanel.add(poli1);
        inputPanel.add(new JLabel("Polinom 2:"));
        poli2 = new JTextField();
        inputPanel.add(poli2);
        add(inputPanel, BorderLayout.CENTER);

        JPanel buttonPanel = new JPanel();
        JButton addButton = new JButton("Adunare");
        addButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Polynomial p1 = parsePolynomial(poli1.getText());
                Polynomial p2 = parsePolynomial(poli2.getText());
                p1.adunare(p2);
                rezultat.setText(p1.toString());
            }
        });
        buttonPanel.add(addButton);
        JButton scdButton = new JButton("Scadere");
        scdButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Polynomial p1 = parsePolynomial(poli1.getText());
                Polynomial p2 = parsePolynomial(poli2.getText());
                p1.scadere(p2);
                rezultat.setText(p1.toString());
            }
        });
        buttonPanel.add(scdButton);
        add(buttonPanel, BorderLayout.SOUTH);

        rezultat = new JLabel();
        add(rezultat, BorderLayout.NORTH);

        JButton inmButton = new JButton("Inmultire");
        inmButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Polynomial p1 = parsePolynomial(poli1.getText());
                Polynomial p2 = parsePolynomial(poli2.getText());
                Polynomial rez = p1.inmultire(p2);
                rezultat.setText(rez.toString());
            }
        });
        buttonPanel.add(inmButton);

        JButton derivButton = new JButton("Derivare");
        derivButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Polynomial p1 = parsePolynomial(poli1.getText());
                Polynomial deriv = p1.derivare(p1);
                rezultat.setText(deriv.toString());
            }
        });
        buttonPanel.add(derivButton);

        JButton intgButton = new JButton("Integrare");
        intgButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Polynomial p = parsePolynomial(poli1.getText());
                Polynomial intg = p.integrare(p);
                rezultat.setText(intg.toString());
            }
        });
        buttonPanel.add(intgButton);



        add(buttonPanel, BorderLayout.SOUTH);

        rezultat = new JLabel();
        add(rezultat, BorderLayout.NORTH);
    }

    private Polynomial parsePolynomial(String input) {
        Polynomial p = new Polynomial();
        String reg = "(\\+|\\-)?\\s*(\\d+(\\.\\d+)?|\\d*(\\.\\d+))?(x(\\^\\d+)?)?";
        Pattern pattern = Pattern.compile(reg);
        Matcher matcher = pattern.matcher(input);
        while (matcher.find()) {
            String semn = matcher.group(1);
            double coeficient = 0.0;
            if (matcher.group(2) != null) {
                coeficient = Double.parseDouble(matcher.group(2));
            }
            if (matcher.group(4) != null) {
                coeficient *= Double.parseDouble(matcher.group(4));
            }
            int exponent = 0;
            if (matcher.group(6) != null) {
                exponent = Integer.parseInt(matcher.group(6).substring(1));
            }
            if (semn != null && semn.equals("-")) {
                coeficient *= -1;
            }
            Monomial m = new Monomial(coeficient, exponent);
            p.addTerm(m);
        }
        return p;
    }

    public static void main(String[] args) {
        MainFrame calculator = new MainFrame();
        calculator.setVisible(true);
    }
}


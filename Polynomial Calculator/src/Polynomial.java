
import java.util.HashMap;


public class Polynomial {
    private HashMap<Integer, Double> poli;

    public Polynomial() {
        poli = new HashMap<Integer, Double>();
    }

    public void addTerm(Monomial termen) {
        int exponent = termen.getExponent();
        double coeficient = termen.getCoeficient();
        if (poli.containsKey(exponent)) {
            coeficient += poli.get(exponent);
        }
        if (coeficient != 0) {
            poli.put(exponent, coeficient);
        } else {
            poli.remove(exponent);
        }
    }


    public void adunare(Polynomial p1) {
        for (Monomial m : p1.getTerms()) {
            double coeficient = m.getCoeficient();
            int exponent = m.getExponent();
            Monomial m1 = new Monomial(coeficient, exponent);
            addTerm(m1);
        }
    }

    public void scadere(Polynomial p) {
        for (Monomial m : p.getTerms()) {
            double coeficient = -m.getCoeficient();
            int exponent = m.getExponent();
            Monomial negat = new Monomial(coeficient, exponent);
            addTerm(negat);
        }
    }

    public Polynomial inmultire(Polynomial p) {
        Polynomial rez = new Polynomial();
        for (Monomial m1 : getTerms()) {
            for (Monomial m2 : p.getTerms()) {
                double coeficient1 = m1.getCoeficient() * m2.getCoeficient();
                int exponent1 = m1.getExponent() + m2.getExponent();
                Monomial nou = new Monomial(coeficient1, exponent1);
                rez.addTerm(nou);
            }
        }
        return rez;
    }

    public Polynomial derivare(Polynomial p) {
        Polynomial deriv = new Polynomial();
        for (Monomial m : p.getTerms()) {
            double nouCoeficient = m.getCoeficient() * m.getExponent();
            int nouExponent = m.getExponent() - 1;
            Monomial nou = new Monomial(nouCoeficient, nouExponent);
            deriv.addTerm(nou);
        }
        return deriv;
    }

    public Polynomial integrare(Polynomial p) {
        Polynomial rez = new Polynomial();
        for (Monomial m : p.getTerms()) {
            double nouCoeficient = m.getCoeficient() / (m.getExponent() + 1);
            int nouExponent = m.getExponent() + 1;
            Monomial nou = new Monomial(nouCoeficient, nouExponent);
            rez.addTerm(nou);
        }
        return rez;
    }

    public Monomial[] getTerms() {
        Monomial[] rez = new Monomial[poli.size()];
        int i = 0;
        for (int exponent : poli.keySet()) {
            rez[i] = new Monomial(poli.get(exponent), exponent);
            i++;
        }
        return rez;
    }


    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        boolean isFirstTerm = true;
        for (Monomial m : getTerms()) {
            double coeficient = m.getCoeficient();
            int exponent = m.getExponent();
            if (coeficient == 0.0) {
                continue;
            }
            if (!isFirstTerm) {
                if (coeficient > 0.0) {
                    builder.append(" + ");
                } else {
                    builder.append(" - ");
                    coeficient = -coeficient;
                }
            }
            if (coeficient != 1.0 || exponent == 0) {
                builder.append(coeficient);
            }
            if (exponent > 0) {
                builder.append("x");
                if (exponent > 1) {
                    builder.append("^").append(exponent);
                }
            }
            isFirstTerm = false;
        }
        if (builder.length() == 0) {
            builder.append("0");
        }
        return builder.toString();
    }



}




public class Monomial {
    private double coeficient;
    private int exponent;

    public Monomial(double coeficient, int exponent) {
        this.coeficient = coeficient;
        this.exponent = exponent;
    }

    public double getCoeficient() {
        return coeficient;
    }

    public int getExponent() {
        return exponent;
    }

    @Override
    public String toString() {
        if (exponent == 0) {
            return Double.toString(coeficient);
        } else if (exponent == 1) {
            return coeficient + "x";
        } else {
            return coeficient + "x^" + exponent;
        }
    }
}


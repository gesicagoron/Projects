package view;

import java.awt.event.ActionListener;

public interface ILoginForm {
    String getUsername();
    String getPassword();
    void displayErrorMessage(String errorMessage);
    void closeView();
    void addLoginButtonListener(ActionListener loginListener);
}

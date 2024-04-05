import model.repository.UserRepository;
import presenter.LoginPresenter;
import view.LoginForm;

public class Main {
    public static void main(String[] args) {
        // Your existing database test code has been omitted for brevity
        // You can keep it if you wish to test the database connection directly

        // Initiate the login process
        LoginForm loginForm = new LoginForm(null); // Create the login form without a parent frame
        UserRepository userRepository = new UserRepository(); // Create an instance of UserRepository
        new LoginPresenter(loginForm, userRepository); // Setup the login process with the form and repository
    }
}

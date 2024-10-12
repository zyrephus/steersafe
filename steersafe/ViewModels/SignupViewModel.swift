import FirebaseAuth

class SignupViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isPasswordVisible: Bool = false
    @Published var isConfirmPasswordVisible: Bool = false
    @Published var signupError: String? = nil
    @Published var isLoading: Bool = false
    @Published var didAttemptToConfirm: Bool = false // Flag to check when confirmation starts

    // Computed property to check if passwords match
    var passwordsMatch: Bool {
        return !password.isEmpty && password == confirmPassword
    }

    // Function to handle sign-up with password confirmation
    func handleSignup() {
        // Reset error state
        signupError = nil

        // Check if passwords match
        guard passwordsMatch else {
            signupError = "Passwords do not match"
            return
        }

        isLoading = true

        // Firebase Authentication for user sign-up
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    // Display error message
                    self.signupError = error.localizedDescription
                } else {
                    // Successful sign-up logic
                    print("User signed up successfully!")
                }
            }
        }
    }
}

import FirebaseAuth
import FirebaseDatabase // Import Realtime Database

class SignupViewModel: ObservableObject {
    // Existing properties...
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isPasswordVisible: Bool = false
    @Published var isConfirmPasswordVisible: Bool = false
    @Published var signupError: String? = nil
    @Published var isLoading: Bool = false
    @Published var didAttemptToConfirm: Bool = false
    @Published var signedUp: Bool = false

    var passwordsMatch: Bool {
        return !password.isEmpty && password == confirmPassword
    }

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
                    self.signedUp = true

                    // Add custom fields to Realtime Database
                    self.addUserToRealtimeDatabase(authResult: authResult)
                }
            }
        }
    }

    // New function to add user data to Realtime Database
    private func addUserToRealtimeDatabase(authResult: AuthDataResult?) {
        guard let uid = authResult?.user.uid else {
            print("Error: Unable to get user ID")
            return
        }

        let ref = Database.database().reference()
        let userData: [String: Any] = [
            "tokens": 0,
            "hoursDriven": 0.0
        ]

        ref.child("users").child(uid).setValue(userData) { error, _ in
            if let error = error {
                print("Error adding user data: \(error.localizedDescription)")
                // Handle the error as needed
            } else {
                print("User data added successfully!")
                // Proceed to next steps, e.g., navigating to the main app
            }
        }
    }
}

import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isPasswordVisible: Bool = false
    @Published var loginError: String? = nil
    @Published var isLoading: Bool = false

    // Function to handle login using Firebase
    func handleLogin(completion: @escaping (Bool) -> Void) {
        // Reset error state
        loginError = nil
        isLoading = true

        // Firebase Authentication
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    // Display error message
                    self.loginError = error.localizedDescription
                    completion(false) // Notify login failed
                } else {
                    // Successful login logic
                    print("User logged in successfully!")
                    completion(true) // Notify login success
                }
            }
        }
    }
}

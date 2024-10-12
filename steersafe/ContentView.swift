import SwiftUI
import Firebase
import FirebaseAuth


extension Font {
    static func inriaSans(size: CGFloat) -> Font {
        return Font.custom("InriaSans-Regular", size: size)
    }
}

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false // Track password visibility
    @State private var loginError: String? = nil // Track error for login
    @State private var isLoading: Bool = false // Track loading state

    var body: some View {
        VStack(spacing: 20) {
            // Logo at the top
            HStack {
                Image("logo")  // Replace with the actual image name
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50) // Adjust the size as needed
                Spacer()  // Pushes the image to the left
            }
            .padding(.horizontal)

            // Illustration Image
            Image("lady") // Replace with your actual image name
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .padding(.bottom, 40)

            // Username TextField
            TextField("email", text: $email)
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(20)
                .font(Font.inriaSans(size: 18))
                .autocapitalization(.none)

            // Password field with toggle visibility
            ZStack {
                if isPasswordVisible {
                    TextField("password", text: $password)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(20)
                        .font(Font.inriaSans(size: 18))
                        .frame(height: 50)  // Set a fixed height
                }
                else {
                    SecureField("password", text: $password)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(20)
                        .font(Font.inriaSans(size: 18))
                        .frame(height: 50)
                }
                // Eye icon button to toggle password visibility
                HStack {
                    Spacer()
                    Button(action: {
                        isPasswordVisible.toggle()
                    })
                    {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                    .padding().padding(.trailing, 15)  // Adjust padding to place the button inside the text field
                }
            }

            // Display error message if login fails
            if let loginError = loginError {
                Text(loginError)
                    .foregroundColor(.red)
                    .font(.footnote)
                    .padding(.top, 5)
            }

            // Login Button
            Button(action: {
                handleLogin() // Call the login function
            }) {
                if isLoading {
                    ProgressView() // Show loading spinner during login
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(UIColor(red: 0.23, green: 0.86, blue: 0.57, alpha: 1.00)))
                        .cornerRadius(20)
                } else {
                    Text("login")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor(red: 0.23, green: 0.86, blue: 0.57, alpha: 1.00)))
                        .cornerRadius(20)
                        .font(Font.inriaSans(size: 18))
                }
            }
            .disabled(isLoading) // Disable button while loading

            // Sign-up text
            HStack {
                Text("don't have an account?")
                    .font(Font.inriaSans(size: 16))
                    .foregroundColor(.gray)
                Button(action: {
                    // Handle sign-up action
                }) {
                    Text("sign up!")
                        .font(Font.inriaSans(size: 16))
                        .foregroundColor(Color(UIColor(red: 0.23, green: 0.86, blue: 0.57, alpha: 1.00)))
                }
            }
            .padding(.top, 10)

            Spacer()
        }
        .padding()
    }

    // MARK: - Handle Login with Firebase
    func handleLogin() {
        // Reset error state
        loginError = nil
        isLoading = true

        // Firebase Authentication
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            isLoading = false // Stop the loading indicator

            if let error = error {
                // Display error message
                loginError = error.localizedDescription
            } else {
                // Successful login, handle what happens next (e.g., navigate to home screen)
                print("User logged in successfully!")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

#Preview {
    LoginView()
}

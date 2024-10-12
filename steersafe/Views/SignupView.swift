import SwiftUI

struct SignupView: View {
    @StateObject private var viewModel = SignupViewModel()
    @State private var isSignUpPresented = false

    var body: some View {
        VStack(spacing: 20) {
            // Logo at the top
            HStack {
                Image("logo")  // Replace with the actual image name
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                Spacer()
            }
            .padding(.horizontal)

            // Illustration Image
            Image("lady")
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .padding(.bottom, 20)

            // Email TextField
            TextField("email", text: $viewModel.email)
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(20)
                .font(Font.inriaSans(size: 18))
                .autocapitalization(.none)

            // Password field with toggle visibility
            ZStack {
                if viewModel.isPasswordVisible {
                    TextField("password", text: $viewModel.password)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(20)
                        .font(Font.inriaSans(size: 18))
                        .frame(height: 50)
                } else {
                    SecureField("password", text: $viewModel.password)
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
                        viewModel.isPasswordVisible.toggle()
                    }) {
                        Image(systemName: viewModel.isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                    .padding().padding(.trailing, 15)
                }
            }

            // Confirm Password field with toggle visibility
            ZStack {
                if viewModel.isConfirmPasswordVisible {
                    TextField("confirm password", text: $viewModel.confirmPassword, onEditingChanged: { isEditing in
                        if !isEditing {
                            viewModel.didAttemptToConfirm = true // Start checking for password match
                        }
                    })
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(20)
                    .font(Font.inriaSans(size: 18))
                    .frame(height: 50)
                } else {
                    SecureField("confirm password", text: $viewModel.confirmPassword, onCommit: {
                        viewModel.didAttemptToConfirm = true // Start checking for password match
                    })
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(20)
                    .font(Font.inriaSans(size: 18))
                    .frame(height: 50)
                }

                // Eye icon button to toggle confirm password visibility
                HStack {
                    Spacer()
                    Button(action: {
                        viewModel.isConfirmPasswordVisible.toggle()
                    }) {
                        Image(systemName: viewModel.isConfirmPasswordVisible ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                    .padding().padding(.trailing, 15)
                }
            }

            // Display password match status only after attempting confirmation
            if !viewModel.confirmPassword.isEmpty {
                Text(viewModel.passwordsMatch ? "Passwords match" : "Passwords do not match")
                    .foregroundColor(viewModel.passwordsMatch ? .green : .red)
                    .font(.footnote)
                    .padding(.top, 5)
            } else {
                // Placeholder Text to avoid layout shift
                Text(" ")
                    .font(.footnote)
                    .padding(.top, 5)
            }


            // Display error message if signup fails
            if let signupError = viewModel.signupError {
                Text(signupError)
                    .foregroundColor(.red)
                    .font(.footnote)
                    .padding(.top, 5)
            }

            // Signup Button
            Button(action: {
                viewModel.handleSignup()
            }) {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(UIColor(red: 0.23, green: 0.86, blue: 0.57, alpha: 1.00)))
                        .cornerRadius(20)
                } else {
                    Text("signup")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(viewModel.passwordsMatch ? Color(UIColor(red: 0.23, green: 0.86, blue: 0.57, alpha: 1.00)) : Color.gray) // Disable if passwords do not match
                        .cornerRadius(20)
                        .font(Font.inriaSans(size: 18))
                }
            }
            .disabled(!viewModel.passwordsMatch || viewModel.isLoading)

            // Sign-up text with NavigationLink to LoginView
            HStack {
                Text("already have an account?")
                    .font(Font.inriaSans(size: 16))
                    .foregroundColor(.gray)

                NavigationLink(destination: LoginView()) {
                    Text("log in!")
                        .font(Font.inriaSans(size: 16))
                        .foregroundColor(Color(UIColor(red: 0.23, green: 0.86, blue: 0.57, alpha: 1.00)))
                }
            }
            .padding(.top, 10)
            .navigationBarHidden(true)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    SignupView()
}

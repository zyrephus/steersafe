import SwiftUI

struct SignupView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var isSignUpPresented = false  // Control sign-up view presentation

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

            // Sigup Button
            Button(action: {
                // To be implemented
            }) {
                if viewModel.isLoading {
                    ProgressView() // Show loading spinner during signup
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(UIColor(red: 0.23, green: 0.86, blue: 0.57, alpha: 1.00)))
                        .cornerRadius(20)
                } else {
                    Text("signup")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor(red: 0.23, green: 0.86, blue: 0.57, alpha: 1.00)))
                        .cornerRadius(20)
                        .font(Font.inriaSans(size: 18))
                }
            }
            .disabled(viewModel.isLoading)

            // Sign-up text with NavigationLink to SignupView
            HStack {
                Text("already have an account?")
                .font(Font.inriaSans(size: 16))
                .foregroundColor(.gray)

                // Full-page transition to SignUpView using NavigationLink
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

struct Signup_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}

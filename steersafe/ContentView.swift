import SwiftUI

extension Font {
    static func inriaSans(size: CGFloat) -> Font {
        return Font.custom("InriaSans-Regular", size: size)
    }
}

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""

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
            TextField("username", text: $username)
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(20)
                .font(Font.inriaSans(size: 18))

            // Password SecureField
            SecureField("password", text: $password)
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(20)
                .font(Font.inriaSans(size: 18))

            // Login Button
            Button(action: {
                // Handle login action
            }) {
                Text("login")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(UIColor(red: 0.23, green: 0.86, blue: 0.57, alpha: 1.00)))
                    .cornerRadius(20)
                    .font(Font.inriaSans(size: 18))
            }

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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

#Preview {
    LoginView()
}

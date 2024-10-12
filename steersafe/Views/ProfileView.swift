import SwiftUI

struct ProfileView: View {
    @StateObject private var profileViewModel = ProfileViewModel()
    @State private var isLoggedOut = false // To handle navigation after logout
    
    var body: some View {
        let hours = Int(profileViewModel.hoursDriven)
        let minutes = Int((profileViewModel.hoursDriven - Double(hours)) * 60)
        let formattedTime = String(format: "%02d:%02d", hours, minutes)

        NavigationStack {
            VStack(spacing: 20) {
                
                HStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    Text("profile")
                        .font(Font.inriaSans(size: 30))
                        .foregroundColor(Color(red: 0.23, green: 0.86, blue: 0.57))
                    
                    Spacer()
                    
                    BalanceView(balance: profileViewModel.tokens)
                }
                .padding(.horizontal, 30)
                
                Text("Hours Driven: \(formattedTime)")
                    .font(.title2)


                // Logout button
                Button(action: {
                    profileViewModel.handleLogout {
                        isLoggedOut = true // Set logged out state to trigger navigation
                    }
                }) {
                    Text("Logout")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor(red: 0.23, green: 0.86, blue: 0.57, alpha: 1.00)))
                        .cornerRadius(20)
                        .font(Font.inriaSans(size: 18))
                }
                .padding(.top, 20)

                Spacer()

                // Navigate back to login page after logging out
                NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true), isActive: $isLoggedOut) {
                    EmptyView()
                }
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

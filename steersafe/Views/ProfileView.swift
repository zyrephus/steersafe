import SwiftUI

struct ProfileView: View {
    @StateObject private var profileViewModel = ProfileViewModel()
    @State private var isLoggedOut = false // To handle navigation after logout
    
    var body: some View {
        let hours = Int(profileViewModel.hoursDriven)
        let minutes = Int((profileViewModel.hoursDriven - Double(hours)) * 60)
        let formattedTime = String(format: "%dh %02dm", hours, minutes)
        
        let lastHours = Int(profileViewModel.lastHoursDriven)
        let lastMinutes = Int((profileViewModel.lastHoursDriven - Double(lastHours)) * 60)
        let lastFormattedTime = String(format: "%dh %02dm", lastHours, lastMinutes)

        NavigationStack {
            VStack(spacing: 20) {
                // Logo and Balance Section (Update padding here)
                HStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                    Spacer()
                }
                .padding(.horizontal, 20)  // Ensure this matches StoreView's padding
                
                // Profile Title
                HStack {
                    Text("profile")
                        .font(Font.inriaSans(size: 30))
                        .foregroundColor(Color(red: 0.23, green: 0.86, blue: 0.57))
                    Spacer()
                    BalanceView(balance: profileViewModel.tokens)
                }
                .padding(.horizontal, 30)
                
                // Rest of the Profile View content...

                Spacer()

                // Navigate back to login page after logging out
                NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true), isActive: $isLoggedOut) {
                    EmptyView()
                }
            }
            .padding(.top)
            .navigationBarHidden(true)
        }
    }
}

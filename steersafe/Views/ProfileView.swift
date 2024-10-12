import SwiftUI

struct ProfileView: View {
    @StateObject private var profileViewModel = ProfileViewModel()
    @State private var isLoggedOut = false // To handle navigation after logout
    
    var body: some View {
        let hours = Int(profileViewModel.hoursDriven)
        let minutes = Int((profileViewModel.hoursDriven - Double(hours)) * 60)
        let formattedTime = String(format: "%dh %02dm", hours, minutes)

        NavigationStack {
            VStack(spacing: 20) {
                // Logo and Balance Section
                HStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                // Profile Title
                HStack {
                    Text("profile")
                        .font(Font.inriaSans(size: 30))
                        .foregroundColor(Color(red: 0.23, green: 0.86, blue: 0.57))
                    Spacer()
                    BalanceView(balance: profileViewModel.tokens)
                }
                .padding(.horizontal, 30)
                
                // Last Trip and Hours Driven Section
                HStack {
                    VStack(alignment: .center, spacing: 10) {
                        Image(systemName: "car.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                        
                        Text("last trip:")
                            .font(Font.inriaSans(size: 18))
                            .foregroundColor(Color(red: 0.23, green: 0.86, blue: 0.57))
                        
                        Text("30 min, 15 coins")
                            .font(Font.inriaSans(size: 16))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()

                    VStack(alignment: .center, spacing: 10) {
                        Image(systemName: "clock.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                        
                        Text("hours driven:")
                            .font(Font.inriaSans(size: 18))
                            .foregroundColor(Color(red: 0.23, green: 0.86, blue: 0.57))
                        
                        Text("\(formattedTime)")
                            .font(Font.inriaSans(size: 16))
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
                .padding(.top, 20)
                
                HStack{
                    Text("challenges")
                        .font(Font.inriaSans(size: 18))
                        .foregroundColor(Color(red: 0.23, green: 0.86, blue: 0.57))
                        
                }
                .padding(.horizontal)
                .padding(.top, 20)

                // Placeholder for Ride Cards
                HStack(spacing: 10) {
                    ForEach(0..<3) { _ in
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color(UIColor.systemGray6))
                            .frame(width: 100, height: 100)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .padding(.top, 60)
                                    .padding(.trailing, 10)
                            )
                    }
                }
                .padding(.horizontal, 30)
                

                // Invite a Friend Section
                HStack {
                    Image(systemName: "person.badge.plus")
                        .foregroundColor(.gray)
                    
                    Text("invite a friend to earn 50 coins")
                        .foregroundColor(.black)
                        .font(Font.inriaSans(size: 16))
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(red: 0.23, green: 0.86, blue: 0.57), lineWidth: 1)
                        .background(Color(UIColor.systemGray6).cornerRadius(20))
                )
                .padding(.horizontal, 30)
                .padding(.top, 20)
                
                // Logout Button
                Button(action: {
                    profileViewModel.handleLogout {
                        isLoggedOut = true // Set logged out state to trigger navigation
                    }
                }) {
                    Text("sign out")
                        .font(Font.inriaSans(size: 20))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor(red: 0.23, green: 0.86, blue: 0.57, alpha: 1.00)))
                        .cornerRadius(20)
                }
                .padding(.top, 20)
                .padding(.horizontal, 30)

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

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

import SwiftUI

struct LeaderboardView: View {
    @StateObject private var viewModel = LeaderboardViewModel()

    var body: some View {
        VStack {
            // Logo at the top
            HStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                Spacer()
            }
            .padding(.horizontal, 20)

            // Leaderboard title
            HStack {
                Text("leaderboard")
                    .font(Font.inriaSans(size: 30))
                    .foregroundColor(Color(red: 0.23, green: 0.86, blue: 0.57))
                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 14)

            // Headers for the columns (user, time driven, coins earned)
            HStack {
                Text("user")
                    .font(Font.inriaSans(size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("time driven")
                    .font(Font.inriaSans(size: 20))
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("coins earned")
                    .font(Font.inriaSans(size: 20))
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.horizontal, 30)

            Divider()

            // List of top users styled as cards
            ScrollView {
                VStack(spacing: 10) {
                    // Add top padding to prevent cutoff
                    Spacer(minLength: 10)  // Adjust this value as needed
                    
                    ForEach(viewModel.topUsers) { user in
                        HStack {
                            Text("Anonymous")  // Replace with actual user name if available
                                .font(Font.inriaSans(size: 18))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(formatHoursDriven(user.hoursDriven))
                                .font(Font.inriaSans(size: 18))
                                .frame(maxWidth: .infinity, alignment: .center)
                            HStack {
                                Image("coin")  // Replace with actual coin image
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("\(user.tokens)")
                                    .font(Font.inriaSans(size: 18))
                                    .frame(alignment: .trailing)
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(red: 192 / 255, green: 221 / 255, blue: 214 / 255), lineWidth: 4)
                        )
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.white)
                        )
                        .padding(.horizontal, 30)
                    }
                    .padding(.top, 10)
                }
            }

            Spacer()
        }
        .padding(.top)
        .background(Color.white) // Set the background to white
        .navigationBarTitle("Leaderboard", displayMode: .inline)
    }

    // Function to format hours driven to hh:mm:ss
    func formatHoursDriven(_ hoursDriven: Double) -> String {
        let totalMinutes = Int(hoursDriven * 60)
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        return String(format: "%02d:%02d", hours, minutes)
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}

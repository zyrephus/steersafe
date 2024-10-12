import SwiftUI

struct LeaderboardView: View {
    var body: some View {
        VStack {
            Text("Leaderboard")
                .font(.largeTitle)
                .padding()

            Text("This is where you'll see the top players.")
                .font(.title2)
                .padding()

            Spacer()
        }
        .navigationBarTitle("Leaderboard", displayMode: .inline)
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}

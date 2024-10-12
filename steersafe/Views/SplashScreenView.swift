import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        VStack {
            Image("logo") // Add your app's logo
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300) // Adjust the size
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white) // Set the background color
    }
}
#Preview {
    SplashScreenView()
}

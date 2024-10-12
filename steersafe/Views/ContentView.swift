import SwiftUI

extension Font {
    static func inriaSans(size: CGFloat) -> Font {
        return Font.custom("InriaSans-Regular", size: size)
    }
}

struct ContentView: View {
    @State private var isLoggedIn = false  // Example login state

    var body: some View {
        NavigationView {
            if isLoggedIn {
                // Replace with your home or main screen view
                Text("Home View")
            } else {
                // Use the LoginView defined in the separate file
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
    ContentView()
}

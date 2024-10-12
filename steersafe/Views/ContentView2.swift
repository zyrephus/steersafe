import SwiftUI

struct ContentView2: View {
    
    init() {
        // Increase the size of tab bar icons
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        UITabBar.appearance().tintColor = UIColor.green // Selected tab color
    }

    var body: some View {
        TabView {
            HomePageView()
                .tabItem {
                    Image(systemName: "house")
                }

            StoreView()
                .tabItem {
                    Image(systemName: "cart.fill")
                }

            LeaderboardView()
                .tabItem {
                    Image(systemName: "rosette")
                }

            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                }
        }
        .accentColor(.green)  // Additional SwiftUI way to customize selected tab color
        .onAppear {
            UITabBar.appearance().itemPositioning = .automatic // Icon and text positioning
        }
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}

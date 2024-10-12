import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct steersafe: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var isActive = false // For toggling between splash and login view

    var body: some Scene {
        WindowGroup {
            ZStack {
                if isActive {
                    NavigationView {
                        LoginView()
                            .background(Color.white)
                            .preferredColorScheme(.light) // Force light mode
                    }
                    .transition(.move(edge: .trailing).combined(with: .opacity)) // Combined sliding and fade transition
                } else {
                    SplashScreenView()
                        .transition(.opacity) // Fade transition when splash screen disappears
                }
            }
            .animation(.easeInOut(duration: 1.0), value: isActive) // Attach animation to the ZStack
            .onAppear {
                // Simulate splash screen duration and then transition
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    self.isActive = true // Trigger transition from SplashScreen to LoginView
                }
            }
        }
    }
}

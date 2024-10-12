//
//  steersafeApp.swift
//  steersafe
//
//  Created by Jonathan Oh on 10/11/24.
//

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
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var isActive = false

    var body: some Scene {
        WindowGroup {
            if isActive {
                NavigationView {
                    LoginView()
                        .background(Color.white)  // Set background color to white
                        .preferredColorScheme(.light)  // Force light mode
                }
            } else {
                SplashScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                            withAnimation {
                                self.isActive = true  // Transition to LoginView after 2 seconds
                            }
                        }
                    }
            }
        }
    }
}

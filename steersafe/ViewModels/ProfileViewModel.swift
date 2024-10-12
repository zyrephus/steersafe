import FirebaseAuth
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var tokens: Int = 0
    @Published var hoursDriven: Double = 0.0

    // Function to handle logout
    func handleLogout(completion: @escaping () -> Void) {
        do {
            try Auth.auth().signOut()  // Sign out from Firebase
            completion() // Notify the view that logout is successful
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError.localizedDescription)
        }
    }
}

import FirebaseAuth
import FirebaseDatabase

class ProfileViewModel: ObservableObject {
    @Published var tokens: Int = 0
    @Published var hoursDriven: Double = 0.0
    @Published var lastTokens: Int = 0
    @Published var lastHoursDriven: Double = 0.0

    init() {
        fetchUserData()
    }

    // Function to fetch tokens and hoursDriven from Realtime Database
    func fetchUserData() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("No user is currently logged in.")
            return
        }

        let ref = Database.database().reference()
        ref.child("users").child(uid).observeSingleEvent(of: .value) { snapshot in
            if let userData = snapshot.value as? [String: Any] {
                // Fetch tokens
                if let tokens = userData["tokens"] as? Int {
                    self.tokens = tokens
                } else {
                    print("Tokens value is not available.")
                }

                // Fetch hoursDriven
                if let hoursDriven = userData["hoursDriven"] as? Double {
                    self.hoursDriven = hoursDriven
                } else {
                    print("Hours driven value is not available.")
                }
                
                // Fetch last tokens
                if let lastTokens = userData["lastTokens"] as? Int {
                    self.lastTokens = lastTokens
                } else {
                    print("Last tokens value is not available.")
                }

                // Fetch hoursDriven
                if let lastHoursDriven = userData["lastHoursDriven"] as? Double {
                    self.lastHoursDriven = lastHoursDriven
                } else {
                    print("Last hours driven value is not available.")
                }
            } else {
                print("User data is not available.")
            }
        } withCancel: { error in
            print("Error fetching user data: \(error.localizedDescription)")
        }
    }

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

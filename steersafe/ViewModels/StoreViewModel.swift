import FirebaseAuth
import FirebaseDatabase


class StoreViewModel: ObservableObject {
    @Published var tokens: Int = 0
    
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
            } else {
                print("User data is not available.")
            }
        } withCancel: { error in
            print("Error fetching user data: \(error.localizedDescription)")
        }
    }
}

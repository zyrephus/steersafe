import Foundation
import FirebaseDatabase

class LeaderboardViewModel: ObservableObject {
    @Published var topUsers: [User] = []
    
    private var ref: DatabaseReference!

    init() {
        // Initialize the Firebase reference and start observing
        ref = Database.database().reference().child("users")
        observeTopUsers()
    }

    // Function to observe top 10 users sorted by token count in real-time
    func observeTopUsers() {
        // Query the top 10 users based on token count
        ref.queryOrdered(byChild: "tokens").queryLimited(toLast: 10).observe(.value) { snapshot in
            var users: [User] = []
            
            for child in snapshot.children.allObjects as? [DataSnapshot] ?? [] {
                if let userDict = child.value as? [String: Any],
                   let tokens = userDict["tokens"] as? Int,
                   let hoursDriven = userDict["hoursDriven"] as? Double {
                    
                    let user = User(tokens: tokens, hoursDriven: hoursDriven)
                    users.append(user)
                }
            }
            
            // Sort the users by tokens in descending order (Firebase returns ascending order)
            self.topUsers = users.sorted(by: { $0.tokens > $1.tokens })
        }
    }
}

struct User: Identifiable {
    var id = UUID()
    var tokens: Int
    var hoursDriven: Double
}

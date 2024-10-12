import Foundation
import FirebaseDatabase

class LeaderboardViewModel: ObservableObject {
    @Published var topUsers: [User] = []
    
    private var ref: DatabaseReference = Database.database().reference()

    init() {
        fetchTopUsers()
    }

    // Function to fetch top 10 users sorted by token count
    func fetchTopUsers() {
        ref.child("users").queryOrdered(byChild: "tokens").queryLimited(toLast: 10).observe(.value) { snapshot in
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

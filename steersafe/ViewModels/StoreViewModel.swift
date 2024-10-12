import FirebaseAuth
import FirebaseDatabase
import SwiftUI

struct Coupon: Identifiable, Codable {
    var id = UUID()  // Automatically generated, not part of the JSON
    var company: String
    var couponValue: String
    var coinCost: String
    var image: String
    var code: String

    // CodingKeys to exclude the `id` from the decoding process
    enum CodingKeys: String, CodingKey {
        case company
        case couponValue
        case coinCost
        case image
        case code
    }
}


class StoreViewModel: ObservableObject {
    @Published var tokens: Int = 0
    @Published var coupons: [Coupon] = []
    
    init() {
        fetchUserData()
        loadCoupons()
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
    
    // Function to load coupons from JSON
        func loadCoupons() {
            if let url = Bundle.main.url(forResource: "coupons", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let coupons = try decoder.decode([Coupon].self, from: data)
                    self.coupons = coupons
                }
                catch {
                    print("Failed to load coupons: \(error)")
                }
            }
        }
}

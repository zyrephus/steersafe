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
    
    private var ref: DatabaseReference!
    
    init() {
        fetchUserData()
        loadCoupons()
    }
    
    // Function to fetch tokens from Realtime Database
    func fetchUserData() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("No user is currently logged in.")
            return
        }
        
        ref = Database.database().reference().child("users").child(uid)

        // Use observe to continuously monitor changes to the user data
        ref.observe(.value) { snapshot in
            if let userData = snapshot.value as? [String: Any] {
                // Fetch tokens
                if let tokens = userData["tokens"] as? Int {
                    self.tokens = tokens
                } else if let tokensString = userData["tokens"] as? String, let tokens = Int(tokensString) {
                    self.tokens = tokens
                } else if let tokensDouble = userData["tokens"] as? Double {
                    self.tokens = Int(tokensDouble)
                } else if let tokensNumber = userData["tokens"] as? NSNumber {
                    self.tokens = tokensNumber.intValue
                } else {
                    print("Tokens value is not available.")
                    self.tokens = 0
                }
            } else {
                print("User data is not available.")
                self.tokens = 0
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
            } catch {
                print("Failed to load coupons: \(error)")
            }
        }
    }
    
    // Function to redeem a coupon
    func redeemCoupon(coupon: Coupon, completion: @escaping (Bool) -> Void) {
        guard let coinCost = Int(coupon.coinCost) else {
            print("Invalid coin cost for coupon")
            completion(false)
            return
        }
        guard let uid = Auth.auth().currentUser?.uid else {
            print("No user is currently logged in.")
            completion(false)
            return
        }
        let tokensRef = Database.database().reference().child("users").child(uid).child("tokens")
        
        tokensRef.runTransactionBlock({ (currentData) -> TransactionResult in
            var tokens: Int = 0

            if let tokensInt = currentData.value as? Int {
                tokens = tokensInt
            } else if let tokensDouble = currentData.value as? Double {
                tokens = Int(tokensDouble)
            } else if let tokensString = currentData.value as? String, let tokensInt = Int(tokensString) {
                tokens = tokensInt
            } else if let tokensNumber = currentData.value as? NSNumber {
                tokens = tokensNumber.intValue
            } else {
                tokens = 0
            }

            if tokens >= coinCost {
                tokens -= coinCost
                currentData.value = tokens
                return TransactionResult.success(withValue: currentData)
            } else {
                print("Not enough tokens")
                return TransactionResult.abort()
            }
        }) { (error, committed, snapshot) in
            if let error = error {
                print("Transaction failed: \(error.localizedDescription)")
                completion(false)
            } else if committed {
                DispatchQueue.main.async {
                    // self.tokens -= coinCost  // Removed this line
                    completion(true)
                }
                print("Tokens updated successfully")
            } else {
                print("Transaction not committed")
                completion(false)
            }
        }
    }
}

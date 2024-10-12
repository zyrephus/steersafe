import Foundation
import SwiftUI

class HomePageModel: ObservableObject {
    @Published var isDriving: Bool = false
    @Published var time: TimeInterval = 0  // Total time in seconds
    @Published var coins: Int = 0           // Total coins earned

    // Function to start driving mode
    func startDriving() {
        isDriving = true
        time = 0
        // Additional logic for when driving mode starts
    }

    // Function to stop driving mode
    func stopDriving() {
        isDriving = false
        coins = Int(time) / 120  // Calculate 1 coin per 2 minutes of driving, each coin worth 10 cents
    }
}

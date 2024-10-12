import Foundation
import SwiftUI

class HomePageModel: ObservableObject {
    // You can have state variables here that affect your view
    @Published var isDriving: Bool = false

    // Function to start driving mode
    func startDriving() {
        isDriving = true
        // Additional logic for when driving mode starts
    }

    // Function to stop driving mode
    func stopDriving() {
        isDriving = false
        // Additional logic for when driving mode stops
    }
}

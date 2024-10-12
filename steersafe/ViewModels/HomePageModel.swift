import Foundation
import CoreMotion
import SwiftUI

class HomePageModel: ObservableObject {
    private let motionManager = CMMotionManager()

    @Published var isDriving: Bool = false
    @Published var time: TimeInterval = 0  // Total time in seconds
    @Published var coins: Int = 0           // Total coins earned
    @Published var zAxisRotationRate: Double = 0.0  // Track z-axis movement

    // Function to start driving mode
    func startDriving() {
        isDriving = true
        time = 0
        startGyroscopeUpdates()  // Start monitoring the gyroscope when driving starts
    }

    // Function to stop driving mode
    func stopDriving() {
        isDriving = false
        coins = Int(time) / 120  // Calculate 1 coin per 2 minutes of driving
        stopGyroscopeUpdates()   // Stop monitoring the gyroscope when driving ends
    }

    // Function to start receiving gyroscope updates
    func startGyroscopeUpdates() {
        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 0.1  // Update interval

            // Start updates for gyroscope data
            motionManager.startGyroUpdates(to: OperationQueue.main) { [weak self] data, error in
                if let gyroData = data {
                    // Update the z-axis rotation rate
                    self?.zAxisRotationRate = gyroData.rotationRate.z
                    
                    // Check if the phone is being rotated too much (e.g., user picks up the phone)
                    if abs(gyroData.rotationRate.z) > 1.0 {
                        // If significant movement is detected, stop driving
                        self?.stopDriving()
                    }
                } else if let error = error {
                    print("Gyroscope error: \(error.localizedDescription)")
                }
            }
        } else {
            print("Gyroscope is not available.")
        }
    }

    // Function to stop gyroscope updates
    func stopGyroscopeUpdates() {
        motionManager.stopGyroUpdates()
    }
}


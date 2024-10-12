import Foundation
import CoreMotion
import SwiftUI

class HomePageModel: ObservableObject {
    private let motionManager = CMMotionManager()

    @Published var isDriving: Bool = false
    @Published var time: TimeInterval = 0  // Total time in seconds
    @Published var coins: Int = 0           // Total coins earned
    @Published var zAxisRotationRate: Double = 0.0  // Track z-axis movement
    @Published var pickups: Int = 0
    private var lastPickupTime: Date?  // Track the last time a pickup was registered
    private var startTime: Date?            // Track when driving started
    private var timer: Timer?               // Timer for elapsed time tracking

    // Toggle driving state
    func toggleDriving() {
        if isDriving {
            stopDriving()
        } else {
            startDriving()
        }
    }

    // Function to start driving mode
    func startDriving() {
        print("started driving")
        isDriving = true
        time = 0
        startTime = Date()  // Set start time when driving begins

        // Start a timer to update elapsed time every second
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if let startTime = self.startTime {
                self.time = Date().timeIntervalSince(startTime)
            }
        }

        startGyroscopeUpdates()  // Start monitoring the gyroscope when driving starts
    }

    // Function to stop driving mode
    func stopDriving() {
        print("stopped driving")
        isDriving = false
        coins = Int(time) / 120  // Calculate 1 coin per 2 minutes of driving
        stopGyroscopeUpdates()   // Stop monitoring the gyroscope when driving ends

        // Invalidate the timer
        timer?.invalidate()
        timer = nil
    }

    // Function to start receiving gyroscope updates
    func startGyroscopeUpdates() {
        print("started measuring gyro")
        if motionManager.isGyroAvailable {
            print("gyro available")
            motionManager.gyroUpdateInterval = 0.1  // Update interval

            // Start updates for gyroscope data
            motionManager.startGyroUpdates(to: OperationQueue.main) { [weak self] data, error in
                if let gyroData = data {
                    // Update the z-axis rotation rate
                    self?.zAxisRotationRate = gyroData.rotationRate.z

                    // Check if the phone is being rotated too much (e.g., user picks up the phone)
                    if abs(gyroData.rotationRate.z) > 0.5 {
                        let now = Date()
                        if let lastPickup = self?.lastPickupTime {
                            // Check if 0.5 seconds (500 milliseconds) have passed since the last pickup
                            if now.timeIntervalSince(lastPickup) > 5.0 {
                                self?.registerPickup(now)
                            }
                        } else {
                            // No previous pickup, register the first one
                            self?.registerPickup(now)
                        }
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

    // Helper function to register a pickup and update the timestamp
    private func registerPickup(_ currentTime: Date) {
        pickups += 1
        lastPickupTime = currentTime
        print("Pickups: \(pickups)")
    }
}

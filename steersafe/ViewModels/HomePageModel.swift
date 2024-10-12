import Foundation
import CoreMotion
import SwiftUI

class HomePageModel: ObservableObject {
    private let motionManager = CMMotionManager()

    @Published var isDriving: Bool = false
    @Published var time: TimeInterval = 0  // Total time in seconds
    @Published var coins: Int = 0           // Total coins earned
    @Published var zAccel: Double = 0.0  // Track z-axis movement
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

        startAccelUpdates()  // Start monitoring the accelerometer when driving starts
    }

    // Function to stop driving mode
    func stopDriving() {
        print("stopped driving")
        isDriving = false
        coins = Int(time) / 120  // Calculate 1 coin per 2 minutes of driving
        stopAccelUpdates()   // Stop monitoring the accelerometer when driving ends

        // Invalidate the timer
        timer?.invalidate()
        timer = nil
    }

    // Function to start receiving accelerometer updates
    func startAccelUpdates() {
        print("started measuring accel")
        if motionManager.isAccelerometerAvailable {
            print("accel available")
            motionManager.accelerometerUpdateInterval = 0.1  // Update interval

            // Start updates for accelerometer data
            motionManager.startAccelerometerUpdates(to: OperationQueue.main) { [weak self] data, error in
                if let accelerometerData = data {
                    // Update the z-axis acceleration value
                    self?.zAccel = accelerometerData.acceleration.z

                    // Check if the phone is being moved too much (e.g., user picks up the phone)
                    let movementThreshold = 0.1  // Set a reasonable threshold for detecting a phone pickup
                    
                    if accelerometerData.acceleration.z > movementThreshold {
                        let now = Date()
                        if let lastPickup = self?.lastPickupTime {
                            // Check if 5 seconds have passed since the last pickup to debounce the input
                            if now.timeIntervalSince(lastPickup) > 5.0 {
                                self?.registerPickup(now)
                            }
                        } else {
                            // No previous pickup, register the first one
                            self?.registerPickup(now)
                        }
                    }
                } else if let error = error {
                    print("Accelerometer error: \(error.localizedDescription)")
                }
            }
        } else {
            print("Accelerometer is not available.")
        }
    }

    // Function to stop accelerometer updates
    func stopAccelUpdates() {
        motionManager.stopAccelerometerUpdates()
    }

    // Helper function to register a pickup and update the timestamp
    private func registerPickup(_ currentTime: Date) {
        pickups += 1
        lastPickupTime = currentTime
        print("Pickups: \(pickups)")
    }
}

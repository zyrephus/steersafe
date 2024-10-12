import Foundation
import CoreMotion
import FirebaseAuth
import FirebaseDatabase

class HomePageModel: ObservableObject {
    private let motionManager = CMMotionManager()
    
    @Published var isDriving: Bool = false
    @Published var time: TimeInterval = 0  // Total time in seconds
    @Published var coins: Int = 0           // Total coins earned
    @Published var zAccel: Double = 0.0     // Track z-axis movement
    @Published var pickups: Int = 0         // Total pickups across sessions
    @Published var currPickups: Int = 0     // Pickups during the current session
    @Published var isWarningVisible: Bool = false  // Show warning for 5 seconds

    private var lastPickupTime: Date?  // Track the last time a pickup was registered
    private var startTime: Date?            // Track when driving started
    private var timer: Timer?               // Timer for elapsed time tracking
    private var warningTimer: Timer?        // Timer to hide the warning after 5 seconds

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
        currPickups = 0  // Reset currPickups for the current session
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

        // Update the user stats in Firebase
        updateUserStats()
    }

    // Function to start receiving accelerometer updates
    func startAccelUpdates() {
        print("started measuring accel")
        if motionManager.isAccelerometerAvailable {
            print("accel available")
            motionManager.accelerometerUpdateInterval = 0.05  // Update interval

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
        currPickups += 1  // Increment the pickups for the current session
        lastPickupTime = currentTime
        print("Total Pickups: \(pickups), Current Session Pickups: \(currPickups)")
        showWarning()  // Show warning when a pickup is detected
    }

    // Function to show the "get off your phone" warning for 5 seconds
    private func showWarning() {
        isWarningVisible = true
        warningTimer?.invalidate()  // Invalidate any previous timer
        warningTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] _ in
            self?.isWarningVisible = false
        }
    }

    // Function to update user's tokens and hoursDriven in Firebase
    private func updateUserStats() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("No user is currently logged in.")
            return
        }

        let ref = Database.database().reference()

        ref.child("users").child(uid).observeSingleEvent(of: .value) { snapshot in
            var existingTokens = 0
            var existingHoursDriven = 0.0

            if let userData = snapshot.value as? [String: Any] {
                // Fetch existing tokens
                if let tokens = userData["tokens"] as? Int {
                    existingTokens = tokens
                }

                // Fetch existing hours driven
                if let hoursDriven = userData["hoursDriven"] as? Double {
                    existingHoursDriven = hoursDriven
                }
            }

            // Calculate new tokens and hours driven
            let newTokens = existingTokens + self.coins
            let hoursThisSession = self.time / 3600.0  // Convert time from seconds to hours
            let newHoursDriven = existingHoursDriven + hoursThisSession

            // Prepare updated user data
            let updatedUserData: [String: Any] = [
                "tokens": newTokens,
                "hoursDriven": newHoursDriven
            ]

            // Update the user's data in Firebase Realtime Database
            ref.child("users").child(uid).updateChildValues(updatedUserData) { error, _ in
                if let error = error {
                    print("Error updating user data: \(error.localizedDescription)")
                } else {
                    print("User data updated successfully!")
                }
            }
        } withCancel: { error in
            print("Error fetching user data: \(error.localizedDescription)")
        }
    }
}

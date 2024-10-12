import SwiftUI

struct HomePageView: View {
    @ObservedObject var viewModel = HomePageModel()
    @State private var startTime = Date()  // Track the start time of driving
    @State private var timer: Timer?       // Timer to update the stopwatch

    var body: some View {
        VStack(spacing: 20) {
            // Logo at the top
            HStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                Spacer()
            }
            .padding(.horizontal)

            Spacer()

            // Placeholder for stopwatch to reserve space and avoid shifting
            if viewModel.isDriving {
                Text(formattedTime(viewModel.time))
                    .font(.system(size: 48, weight: .bold, design: .monospaced))
                    .padding(.bottom, 10)
            } else {
                Text(" ")
                    .font(.system(size: 48, weight: .bold, design: .monospaced))
                    .padding(.bottom, 10)
            }

            // Steering Wheel Button with transition
            Button(action: {
                withAnimation(.easeInOut(duration: 0.5)) {
                    viewModel.isDriving.toggle()
                    if viewModel.isDriving {
                        startDriving()  // Start driving mode and timer
                    } else {
                        stopDriving()   // Stop driving mode and timer
                    }
                }
            }) {
                // Conditionally render either the red wheel, grey wheel, or green wheel based on z-axis movement and driving state
                Image(viewModel.zAxisRotationRate > 1.0 ? "getoffyourphone" : (viewModel.isDriving ? "greenhomewheel" : "greysteeringwheel"))
                    .resizable()
                    .frame(width: 200, height: 200)
                    .transition(.scale)  // Smooth scaling transition
            }
            .background(Color.gray.opacity(0.3))
            .cornerRadius(100)

            // Centered Text, changes based on z-axis movement and driving state
            Text(viewModel.zAxisRotationRate > 1.0 ? "get off your phone!" : (viewModel.isDriving ? "stay focused" : "tap the wheel to start"))
                .font(.system(size: 20))
                .multilineTextAlignment(.center)
                .padding(.top, 10)
                .foregroundColor(viewModel.zAxisRotationRate > 1.0 ? .red : (viewModel.isDriving ? Color(UIColor(red: 0.23, green: 0.86, blue: 0.57, alpha: 1.00)) : .gray))  // Red if using phone, green if driving, gray otherwise

            Spacer()

            // Bottom tab bar
            HStack {
                // Home icon
                Button(action: {
                    // Home action
                }) {
                    Image("green_wheel")
                        .resizable()
                        .frame(width: 50, height: 50)
                }

                Spacer(minLength: 40)

                // Market icon
                Button(action: {
                    // Market action
                }) {
                    Image("market")
                        .resizable()
                        .frame(width: 50, height: 50)
                }

                Spacer(minLength: 40)

                // Leaderboard icon
                Button(action: {
                    // Leaderboard action
                }) {
                    Image("leaderboard")
                        .resizable()
                        .frame(width: 50, height: 50)
                }

                Spacer(minLength: 40)

                // Profile icon
                Button(action: {
                    // Profile action
                }) {
                    Image("profile")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            .padding(.horizontal, 20)
        }
        .padding()
        .onDisappear {
            stopDriving()  // Stop timer if the user navigates away
        }
    }

    // Function to format the elapsed time
    func formattedTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    // Function to start the driving timer
    func startDriving() {
        startTime = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            viewModel.time = Date().timeIntervalSince(startTime)
        }
    }

    // Function to stop the driving timer
    func stopDriving() {
        timer?.invalidate()  // Stop the timer
        timer = nil
        viewModel.stopDriving()  // Perform the coin calculation and stop driving logic
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}


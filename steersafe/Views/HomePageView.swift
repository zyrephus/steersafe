import SwiftUI

struct HomePageView: View {
    @ObservedObject var viewModel = HomePageModel()

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

            // Stopwatch Text, shows elapsed time if driving, otherwise shows placeholder
            if viewModel.isDriving {
                Text(formattedTime(viewModel.time))
                    .font(.system(size: 48, weight: .bold, design: .monospaced))
                    .padding(.bottom, 10)
            } else {
                Text(" ")
                    .font(.system(size: 48, weight: .bold, design: .monospaced))
                    .padding(.bottom, 10)
            }

            // Steering Wheel Button with z-axis monitoring
            Button(action: {
                withAnimation(.easeInOut(duration: 0.5)) {
                    viewModel.toggleDriving()  // Toggle driving state
                }
            }) {
                // Display red if z-axis rotation is too high (using phone), otherwise green or grey based on state
                Image(viewModel.zAccel > 1.0 ? "getoffyourphone" : (viewModel.isDriving ? "greenhomewheel" : "greysteeringwheel"))
                    .resizable()
                    .frame(width: 200, height: 200)
                    .transition(.scale)  // Smooth scaling transition
            }
            .background(Color.gray.opacity(0.3))
            .cornerRadius(100)

            // Dynamic Text under the wheel, red if phone detected, otherwise green or grey
            Text(viewModel.zAccel > 1.0 ? "get off your phone!" : (viewModel.isDriving ? "stay focused" : "tap the wheel to start"))
                .font(.system(size: 20))
                .multilineTextAlignment(.center)
                .padding(.top, 10)
                .foregroundColor(viewModel.zAccel > 1.0 ? .red : (viewModel.isDriving ? Color(UIColor(red: 0.23, green: 0.86, blue: 0.57, alpha: 1.00)) : .gray))  // Red if using phone, green if driving, gray otherwise

            Spacer()
        }
        .padding()
    }

    // Function to format the elapsed time
    func formattedTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}

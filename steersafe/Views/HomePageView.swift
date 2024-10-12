import SwiftUI

//extension Font {
//    static func inriaSans(size: CGFloat) -> Font {
//        return Font.custom("InriaSans-Regular", size: size)
//    }
//}

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
            
            Spacer()  // Push content towards the center

            // Steering Wheel Button (Grey/Green depending on state)
            Button(action: {
                viewModel.isDriving.toggle()  // Toggle between driving and inactive
            }) {
                // Conditionally render either the grey or green wheel
                if viewModel.isDriving {
                    Image("greenhomewheel")  // Green wheel when driving
                        .resizable()
                        .frame(width: 200, height: 200)
                } else {
                    Image("greysteeringwheel")  // Grey wheel when inactive
                        .resizable()
                        .frame(width: 200, height: 200)
                }
            }
            .background(Color.gray.opacity(0.3))
            .cornerRadius(100)

            // Centered Text
            Text("Click on the wheel to start driving")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.top, 10)

            Spacer()

            // Bottom tab bar
            HStack {
                // Home icon (Green Steering Wheel icon for Home)
                Button(action: {
                    // Home action
                }) {
                    Image("green_wheel")
                        .resizable()
                        .frame(width: 60, height: 60) 
                }

                Spacer(minLength: 40)

                // Market icon
                Button(action: {
                    // Market action
                    
                }) {
                    Image("market")
                        .resizable()
                        .frame(width: 60, height: 60)
                }

                Spacer(minLength: 40)

                // Leaderboard icon
                Button(action: {
                    // Leaderboard action
                    
                }) {
                    Image("leaderboard")
                        .resizable()
                        .frame(width: 60, height: 60)
                }

                Spacer(minLength: 40)

                // Profile icon
                Button(action: {
                    // Profile action
                    
                }) {
                    Image("profile")
                        .resizable()
                        .frame(width: 60, height: 60)
                }
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
        }
        .padding()
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}


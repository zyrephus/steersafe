import SwiftUI

struct QuestView: View {
    var body: some View {
        VStack(spacing: 16) {
            // Top Section with Logo and Description
            HStack(spacing: 16) {
                // Dunkin Logo
                Image("dunkin")
                    .resizable()
                    .frame(width: 100, height: 100)

                // Text describing the reward challenge
                VStack(alignment: .leading, spacing: 8) {
                    Text("Safe Driving Never Tasted This Good.")
                        .font(.inriaSans(size: 18))  // Adjust size based on the overall design
                        .foregroundColor(.black)
                        .offset(x: 40)

                    Text("Complete 5 safe drives by 10/22 for a free drink.")
                        .font(.inriaSans(size: 14))
                        .foregroundColor(.black)
                        .offset(x: 40)
                }
                Spacer()
            }
            .padding(.horizontal)

            // Bottom Section with Progress and Border
            ZStack{
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 250)
                    .frame(height: 20)
                    .background(Color(red: 0.23, green: 0.86, blue: 0.57))
                    .cornerRadius(40)
                Text("5/5 Safe Drives Complete")
                    .font(.inriaSans(size: 18))
                    .foregroundColor(.white)
                    .frame(width: 340, height: 40, alignment: .center)
            }
            .frame(width: 100, height: 50)
            .padding(.bottom, -20)
            .offset(y: +7)

        }
        .padding()
        .background(
            Image("questBorder")  // Use the 'questBorder' asset for the border/background
                .resizable()
                .cornerRadius(20)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.green.opacity(0.3), lineWidth: 3)
        )
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 5, y: 5)  // Add shadow here
    }
}

struct QuestView_Previews: PreviewProvider {
    static var previews: some View {
        QuestView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

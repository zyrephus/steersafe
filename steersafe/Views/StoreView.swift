import SwiftUI

struct StoreView: View {
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
            
            HStack {
                Text("shop")
                    .font(Font.inriaSans(size: 30))
                    .foregroundColor(Color(red: 0.23, green: 0.86, blue: 0.57))
                
                Spacer()
                
                BalanceView(balance: 945) // Need to send in user's balance
            }
            .padding(.horizontal, 30)
            
            Spacer()
        }
    }
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView()
    }
}

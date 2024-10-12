import SwiftUI

struct StoreView: View {
    @StateObject private var viewModel = StoreViewModel()
    
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
            .padding(.horizontal, 20)
            
            HStack {
                Text("shop")
                    .font(Font.inriaSans(size: 30))
                    .foregroundColor(Color(red: 0.23, green: 0.86, blue: 0.57))
                
                Spacer()
                
                BalanceView(balance: viewModel.tokens)
            }
            .padding(.horizontal, 30)
            
            ZStack {
                ScrollView {
                    VStack(spacing: 20) {
                        // Insert the QuestView at the top of the scrollable content
                        QuestView()
                            .padding(.horizontal)

                        // LazyVGrid for coupons
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 175))], spacing: 20) {
                            ForEach(viewModel.coupons) { coupon in
                                StoreItemView(
                                    company: coupon.company,
                                    couponValue: coupon.couponValue,
                                    coinCost: coupon.coinCost,
                                    image: coupon.image,
                                    code: coupon.code,
                                    userTokens: viewModel.tokens
                                )
                            }
                        }
                        .padding()
                    }
                }
                
                // Top shadow
                VStack {
                    Rectangle().fill(LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.2), Color.clear]),
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                        .frame(height: 10)  // Adjust height as needed
                    Spacer()
                }
            }
                        
            Spacer()
        }
        .padding(.top)
    }
}


struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView()
    }
}


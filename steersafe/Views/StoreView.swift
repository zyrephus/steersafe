import SwiftUI

struct StoreView: View {
    @StateObject private var viewModel = StoreViewModel()
    
    // State variables for popup visibility and animation
    @State private var showPopup = false
    @State private var popupScale: CGFloat = 0.1
    @State private var redeemedCode: String = ""
    @State private var redeemedCompany: String = ""
    @State private var redeemedCouponValue: String = ""
    @State private var redeemeCoinCost: String = ""
    
    var body: some View {
        ZStack {
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
                    
                    BalanceView(balance: viewModel.tokens)
                }
                .padding(.horizontal, 30)
                
                ZStack {
                    ScrollView {
                        VStack(spacing: 0) {
                            // Insert the QuestView at the top of the scrollable content
                            QuestView()
                                .padding(.horizontal)

                            // LazyVGrid for coupons
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 175))], spacing: 0) {
                                ForEach(viewModel.coupons) { coupon in
                                    StoreItemView(
                                        company: coupon.company,
                                        couponValue: coupon.couponValue,
                                        coinCost: coupon.coinCost,
                                        image: coupon.image,
                                        code: coupon.code,
                                        userTokens: viewModel.tokens,
                                        
                                        // Handle redemption when pressed
                                        onRedeem: {
                                            if viewModel.tokens >= Int(coupon.coinCost) ?? 0 {
                                                // Show popup with the coupon code
                                                redeemedCode = coupon.code
                                                redeemedCompany = coupon.company
                                                redeemedCouponValue = coupon.couponValue
                                                withAnimation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0)) {
                                                    showPopup = true
                                                    popupScale = 1.0
                                                }
                                            } else {
                                                print("Not enough tokens")
                                            }
                                        }
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
            
            // Display the popup if showPopup is true
            if showPopup {
                popupView
                    .scaleEffect(popupScale)
                    .transition(.scale)
            }
        }
    }
    
    // Custom Popup View
    var popupView: some View {
        VStack(spacing: 10) {
            // Combining multiple Text views for different formatting
            (
                Text(redeemedCompany)
                    .font(.system(size: 20))
                    .fontWeight(.bold) +
                Text(" ") + // Adding space between
                Text(redeemedCouponValue)
                    .font(.system(size: 20))
                    .fontWeight(.bold) +
                Text(" coupon successfully redeemed! Here is the code:")
                    .font(.system(size: 20))
                    .fontWeight(.regular) // Regular weight for the rest of the text
            )
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(redeemedCode)
                .font(.system(size: 20))
                .foregroundColor(.green)
                .padding(.bottom, 10)
            
            Button(action: {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0)) {
                    popupScale = 0.1  // Scale down with bounce effect
                    showPopup = false  // Dismiss the popup
                }
            }) {
                Text("OK")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .frame(width: 300)
        .padding(.bottom, 50)
    }
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView()
    }
}

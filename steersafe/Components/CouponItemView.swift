import SwiftUI

struct StoreItemView: View {
    var company: String
    var couponValue: String
    var coinCost: String
    var image: String
    var code: String
    var userTokens: Int
    
    @State private var isPressed: Bool = false // Track press state
    
    var body: some View {
        ZStack {
            // Darken the first RoundedRectangle when pressed
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    isPressed ?
                    (userTokens >= Int(coinCost) ?? 0 ? Color(red: 150 / 255, green: 180 / 255, blue: 174 / 255) : Color.red.opacity(0.7)) :
                    (userTokens >= Int(coinCost) ?? 0 ? Color(red: 192 / 255, green: 221 / 255, blue: 214 / 255) : Color.red)
                )
                .frame(width: 175, height: 160)  // Set width and height
            
            // Inner Rectangle
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(width: 155, height: 120)
                .offset(y: -10)
            
            Image(image)
                .resizable()
                .frame(width: 80, height: 80)
            
            // Coupon price
            Text(couponValue)
                .font(Font.inriaSans(size: 20))
                .foregroundColor(.black)
                .offset(x: +45, y: -50)
            
            // Price in coins
            HStack {
                Text(coinCost)
                    .font(Font.inriaSans(size: 20))
                    .foregroundColor(.white)
                Image("coin")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .offset(x: -8)
            }
            .offset(x: +10, y: +64)
        }
        .padding()
        .onLongPressGesture(minimumDuration: 0.01, pressing: { isPressing in
            isPressed = isPressing // Update press state when pressed or released
        }, perform: {})
    }
}

struct StoreItemView_Previews: PreviewProvider {
    static var previews: some View {
        StoreItemView(
            company: "McDonald's",
            couponValue: "$25",
            coinCost: "250",
            image: "mcdonalds",
            code: "1234567890qwerty",
            userTokens: 200
        )
        .previewLayout(.sizeThatFits)
    }
}

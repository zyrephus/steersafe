import SwiftUI

struct StoreItemView: View {
    var companyName: String
    var couponValue: String
    var coinPrice: String
    var imageName: String
    var code: String  // New code parameter

    var body: some View {
        ZStack {
            // Rectangle with specified width, height, and corner radius
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 192 / 255, green: 221 / 255, blue: 214 / 255))
                .frame(width: 175, height: 160)  // Set width and height
            
            // Inner Rectangle
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(width: 155, height: 120)
                .offset(y: -10)
            
            Image(imageName)
                .resizable()
                .frame(width: 80, height: 80)
            
            // Coupon price
            Text(couponValue)
                .font(Font.inriaSans(size: 20))
                .foregroundColor(.black)
                .offset(x: +45, y: -50)
            
            // Price in coins
            HStack {
                Text(coinPrice)
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
    }
}

struct StoreItemView_Previews: PreviewProvider {
    static var previews: some View {
        StoreItemView(
            companyName: "McDonald's",
            couponValue: "$25",
            coinPrice: "250",
            imageName: "mcdonalds",
            code: "1234567890qwerty"
        )
        .previewLayout(.sizeThatFits)
    }
}

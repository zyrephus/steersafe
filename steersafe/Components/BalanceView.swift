import SwiftUI

struct BalanceView: View {
    var balance: Int

    var body: some View {
        HStack {
            Image("coin")
                .resizable()
                .frame(width: 40, height: 40)

            Text("\(String(format: "%0d", balance))")
                .font(Font.inriaSans(size: 30))
                .foregroundColor(.white)
                .padding(.trailing, 10) // Add right padding to the balance text
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 8)
        .background(Color(red: 192 / 255, green: 221 / 255, blue: 214 / 255))
        .cornerRadius(40)
    }
}

struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceView(balance: 945)
    }
}


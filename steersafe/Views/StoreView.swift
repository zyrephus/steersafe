import SwiftUI

struct StoreView: View {
    var body: some View {
        VStack {
            Text("Welcome to the Store")
                .font(.largeTitle)
                .padding()

            Text("This is where you can purchase items.")
                .font(.title2)
                .padding()

            Spacer()
        }
        .navigationBarTitle("Store", displayMode: .inline)
    }
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView()
    }
}

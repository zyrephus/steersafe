import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Text("Profile")
                .font(.largeTitle)
                .padding()

            Text("This is where you can view and edit your profile.")
                .font(.title2)
                .padding()

            Spacer()
        }
        .navigationBarTitle("Profile", displayMode: .inline)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

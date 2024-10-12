import SwiftUI

extension Font {
    static func inriaSans(size: CGFloat) -> Font {
        return Font.custom("InriaSans-Regular", size: size)
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
    ContentView()
}

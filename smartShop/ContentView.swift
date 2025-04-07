import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            BottomBarComponent()
        } else {
            SplashScreen()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}

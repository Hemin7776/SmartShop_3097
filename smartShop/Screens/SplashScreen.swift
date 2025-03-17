

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack(){
            LinearGradient(
                colors: [.appBlue, .white],
                startPoint: .bottom,
                endPoint:  .top
            )
            .ignoresSafeArea()
            
            VStack{
                Image(.smartShop)
                    .resizable().scaledToFit().padding()
            }
        }
    }
}

#Preview {
    SplashScreen()
}

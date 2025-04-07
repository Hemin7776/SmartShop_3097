
import SwiftUI

struct BottomBarComponent: View {
    var body: some View {
        TabView {
            NavigationStack {
                HomeScreen()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            NavigationStack {
                CategoryScreen()
            }
            .tabItem {
                Label("Category", systemImage: "square.split.2x2")
            }
            NavigationStack {
                FavouritesScreen()
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {}, label: {
                                Image(systemName: "ellipsis")
                                    .foregroundStyle(Color.appBlue)
                            })
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {}, label: {
                                Image(systemName: "cart.fill")
                                    .foregroundStyle(Color.appBlue)
                            })
                        }
                    }
            }
            .tabItem {
                Label("Favourites", systemImage: "heart.fill")
            }
            NavigationStack {
                MyCartScreen()
            }
            .tabItem {
                Label("Cart", systemImage: "cart.fill")
            }
        }
        .accentColor(.appBlue)
    }
}

#Preview {
    BottomBarComponent()
}

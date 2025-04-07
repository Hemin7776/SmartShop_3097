import SwiftUI
import SwiftData

@main
struct smartShopApp: App {
    let container: ModelContainer
    init() {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: false)
            container = try ModelContainer(
                for: Category.self, Product.self, CartItemsModel.self,
                configurations: config
            )
            ProductManager.shared.seedInitialData(context: container.mainContext)
        } catch {
            fatalError("Failed to create model container: \(error)")
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(container)
        }
    }
}

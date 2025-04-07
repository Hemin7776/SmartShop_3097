import SwiftUI
import SwiftData

struct FavouritesScreen: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var categories: [Category]
    
    // State variables to store the filtered products
    @State private var groceryProducts: [Product] = []
    @State private var foodProducts: [Product] = []
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                // Deals widget
                DealWidgetView()
                    .padding(.horizontal)
                
                // List view widget
                List {
                    if !groceryProducts.isEmpty {
                        Section(header: Text("Grocery products").font(.headline)) {
                            ForEach(groceryProducts) { product in
                                ProductRowView(product: product)
                                    .listRowBackground(Color.clear)
                            }
                        }
                    }
                    
                    if !foodProducts.isEmpty {
                        Section(header: Text("Foods").font(.headline)) {
                            ForEach(foodProducts) { product in
                                ProductRowView(product: product)
                                    .listRowBackground(Color.clear)
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("Favourites")
            .onAppear {
                loadProducts()
            }
        }
    }
    
    private func loadProducts() {
        // Find the Grocery and Food categories
        if let groceryCat = categories.first(where: { $0.name == "Grocery" }) {
            groceryProducts = groceryCat.products
        }
        
        if let foodCat = categories.first(where: { $0.name == "Food" }) {
            foodProducts = foodCat.products
        }
        
        // If we're in preview mode or the database is empty, use mock data
        if groceryProducts.isEmpty && foodProducts.isEmpty {
            let productManager = ProductManager.shared
            
            if let groceryCat = productManager.getCategory(byName: "Grocery") {
                groceryProducts = productManager.getProducts(forCategory: groceryCat)
            }
            
            if let foodCat = productManager.getCategory(byName: "Food") {
                foodProducts = productManager.getProducts(forCategory: foodCat)
            }
        }
    }
}


struct ProductRowView: View {
    let product: Product
    @State private var count: Int = 1
    
    var body: some View {
        ZStack {
            // Card background with gradient and rounded corners
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color.appBlue, Color.appBlue.opacity(0.7)]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                )
                .shadow(color: Color.appBlue.opacity(0.3), radius: 6, x: 0, y: 4)
            
            HStack(spacing: 1) {
                // Load asset image using the computed property 'assetName'
                Image(product.assetName)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70, height: 60)
                    
                
                // Extract product name from productDiscription
                Text(product.productDiscription
                        .split(separator: "-")
                        .first?
                        .trimmingCharacters(in: .whitespaces) ?? product.productDiscription)
                .font(.caption)  // Changed to .headline font
                    .lineLimit(1)
                    .foregroundColor(.white)
    
                
                Spacer()
                
                CounterButtonView(
                    count: $count,
                    productPrice: product.productPrice
                )
                .padding(.trailing, 8)
            }

        }
        .frame(height: 100)
    
    }
}

struct CounterButtonView: View {
    @Binding var count: Int
    let productPrice: Double
    
    var body: some View {
        HStack(spacing: 2) {
            Text("\(productPrice, specifier: "%.2f")")
                .foregroundColor(.white)
                .font(.subheadline)
            
            Button(action: { count += 1 }) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.white)
                    .font(.title2)
            }
            .buttonStyle(PlainButtonStyle())
            
            Text("\(count)")
                .foregroundColor(.white)
                .font(.subheadline)
            
            Button(action: {
                if count > 0 { count -= 1 }
            }) {
                Image(systemName: "minus.circle.fill")
                    .foregroundColor(.white)
                    .font(.title2)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}
struct DealWidgetView: View {
    var body: some View {
        ZStack {
            // Background card with gradient and soft shadow
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color.appBlue, Color.appBlue.opacity(0.85)]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                )
                .shadow(color: Color.appBlue.opacity(0.4), radius: 8, x: 0, y: 4)
            
            VStack(spacing: 12) {
                Text("Best Deals for You!")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                
                HStack(spacing: 10) {
                    Text("Exclusive")
                    Text("Subway Deals")
                    Text("Crazy Offers")
                }
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.white.opacity(0.9))
            }
            .padding(20)
        }
        .frame(height: 100)
    }
}


import SwiftUI
import SwiftData

import SwiftUI
import SwiftData

struct HomeScreen: View {
    @Query private var categories: [Category]
    // Only allow the listed categories to be displayed on the home screen.
    private let allowedCategories = ["Food", "Medication", "Grocery"]
    
    var filteredCategories: [Category] {
        categories.filter { allowedCategories.contains($0.name) }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Popular Picks")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(filteredCategories) { category in
                            NavigationLink {
                                CategoryDetailView(category: category)
                            } label: {
                                CategoryCardView(category: category)
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Home")
        }
    }
}


struct CategoryCardView: View {
    let category: Category
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Icon Container
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(category.uiColor.opacity(0.5))
                    .frame(height: 80)
                
                Image(systemName: category.icon)
                    .font(.system(size: 40))
                    .foregroundColor(category.uiColor)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(category.name)
                    .font(.title3.bold())
                    .foregroundColor(category.uiColor)
                
                Text("\(category.products.count) Items")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: category.uiColor.opacity(0.3), radius: 8, x: 0, y: 4)
        )
        .frame(maxWidth: .infinity)
    }
}

struct CategoryDetailView: View {
    let category: Category
    
    var body: some View {
        VStack {
            List(category.products) { product in
                NavigationLink {
                    // Pass both product and its category
                    ProductViewScreen(product: product, category: category)
                } label: {
                    // Pass both product and category to the product card view
                    ProductCardView(product: product, category: category)
                }
            }
        }
        .navigationTitle(category.name)
    }
}



struct ProductCardView: View {
    let product: Product
    let category: Category  // The parent category for the product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Product Image Card

                   
                Image(product.assetName(for: category))
              
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .scaledToFill()
                    .padding(8)
                   

            
            // Product details below the image
            VStack(alignment: .leading, spacing: 4) {
                Text(product.productDiscription)
                    .font(.subheadline)
                    .lineLimit(2)
                    .foregroundColor(.primary)
                
                Text(product.productPrice.formatted(.currency(code: "USD")))
                    .font(.headline)
                    .foregroundColor(category.uiColor)
            }
            .padding([.horizontal, .bottom])
        }
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4)
    }
}


#Preview {
    HomeScreen()
}

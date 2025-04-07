import SwiftUI
import _SwiftData_SwiftUI

struct ProductViewScreen: View {
    let product: Product
    let category: Category
    
    @Environment(\.modelContext) private var modelContext
    @State private var showAddedIndicator = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    productImage
                    priceSection
                    descriptionSection
                    categorySection
                    addToCartButton
                }
                .padding(24)
            }
            .navigationTitle("Product Details")
            .navigationBarTitleDisplayMode(.inline)
            .overlay(alignment: .bottom) {
                if showAddedIndicator {
                    confirmationView
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
    }
    
    private var productImage: some View {
        // A fixed-height container that centers the image and clips it if necessary.
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.appBlue.opacity(0.2))
            Image(product.assetName(for: category))
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .aspectRatio(contentMode: .fit)
                .padding(16)
        }
        .frame(height: 250)
    }
    
    private var priceSection: some View {
        HStack {
            Text(product.productPrice.formatted(.currency(code: "USD")))
                .font(.title.bold())
                .foregroundColor(Color.appBlue)
            Spacer()
        }
    }
    
    private var descriptionSection: some View {
        Text(product.productDiscription)
            .font(.body)
            .multilineTextAlignment(.leading)
    }
    
    private var categorySection: some View {
        HStack {
            Image(systemName: category.icon)
                .font(.title3)
            Text(category.name)
                .font(.headline)
        }
        .foregroundColor(Color.appBlue)
    }
    
    private var addToCartButton: some View {
        Button {
            addToCart()
        } label: {
            Text("Add to Cart")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.appBlue.gradient)
                .foregroundColor(.white)
                .cornerRadius(12)
        }
        .shadow(color: Color.appBlue.opacity(0.3), radius: 8)
    }
    
    private var confirmationView: some View {
        VStack {
            Spacer()
            Text("Added to Cart!")
                .font(.headline)
                .padding()
                .background(
                    Capsule()
                        .fill(Color.appBlue.opacity(0.9))
                        .shadow(radius: 8)
                )
                .foregroundColor(.white)
                .padding(.horizontal)
        }
        .padding(.bottom, 20)
    }
    
    private func addToCart() {
        let productID = product.persistentModelID
        
        let predicate = #Predicate<CartItemsModel> {
            $0.product.persistentModelID == productID
        }
        let descriptor = FetchDescriptor(predicate: predicate)
        
        do {
            let existingItems = try modelContext.fetch(descriptor)
            
            if let existing = existingItems.first {
                existing.quantity += 1
            } else {
                let newItem = CartItemsModel(product: product, quantity: 1)
                modelContext.insert(newItem)
            }
            
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                showAddedIndicator = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeOut(duration: 0.3)) {
                    showAddedIndicator = false
                }
            }
            
        } catch {
            print("Cart error: \(error.localizedDescription)")
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Category.self, Product.self, CartItemsModel.self, configurations: config)
    
    // Created a sample category and product.
    let category = Category(name: "Food", icon: "fork.knife", color: "orange")
    let product = Product(
        productPicture: "carrot.fill",
        productPrice: 2.99,
        productDiscription: "Fresh Organic Carrots"
    )
    
    // Inserting them into the context.
    container.mainContext.insert(category)
    container.mainContext.insert(product)
    
    // Appending the product to the category's products array.
    category.products.append(product)
    
    return ProductViewScreen(product: product, category: category)
        .modelContainer(container)
}

import SwiftUI
import _SwiftData_SwiftUI

struct MyCartScreen: View {
    @Query private var cartItems: [CartItemsModel]
    @Environment(\.modelContext) private var modelContext
    let taxRate = 0.085
     
    var subtotal: Double { cartItems.reduce(0) { $0 + $1.totalPrice } }
    var taxAmount: Double { subtotal * taxRate }
    var total: Double { subtotal + taxAmount }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 9) {
                ForEach(cartItems) { item in
                    ItemOrderRowView(item: item)
                }
                
                Spacer()
                
                // Checkout / total view (keeps appBlue)
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.appBlue)
                    .frame(maxWidth: 350)
                    .frame(height: 70)
                    .shadow(color: Color.appBlue.opacity(0.4), radius: 6, x: 0, y: 4)
                    .overlay {
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Total $\(String(format: "%.2f", total))")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                Text("(incl. $\(String(format: "%.2f", taxAmount)) tax)")
                                    .foregroundColor(.white)
                                    .font(.caption)
                            }
                            Spacer()
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.white)
                                .frame(maxWidth: 100)
                                .frame(height: 50)
                                .shadow(radius: 6)
                                .overlay {
                                    Text("CHECK OUT")
                                        .fontDesign(.rounded)
                                        .font(.caption)
                                        .foregroundColor(Color.appBlue)
                                }
                        }
                        .padding()
                    }
            }
            .padding(.bottom)
            .navigationTitle("My cart")
        }
    }
}

#Preview {
    MyCartScreen()
}

import SwiftUI
import _SwiftData_SwiftUI

struct ItemOrderRowView: View {
    @Bindable var item: CartItemsModel
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12, style: .continuous)
            .fill(colorfulGradient)
            .frame(maxWidth: 350)
            .frame(height: 100)
            .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 4)
            .overlay {
                HStack(spacing: 8) {
                    Image(item.product.assetName)
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .padding(.leading, 8)
                    
                    Text(item.product.productDiscription)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .lineLimit(2)
                        .padding(.horizontal, 8)
                    
                    Spacer()
                    
                    // Give the counter a fixed width to ensure it appears
                    CounterOrderButtonView(
                        count: $item.quantity,
                        productPrice: item.product.productPrice,
                        onDelete: { modelContext.delete(item) }
                    )
                    .frame(width: 100) // Fixed width for the counter view
                    .padding(.trailing, 8)
                }
                .padding()
            }
    }
    
    var colorfulGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [Color.appBlue, Color.appBlue.opacity(0.7)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

struct CounterOrderButtonView: View {
    @Binding var count: Int
    let productPrice: Double
    var onDelete: () -> Void
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 4) {
            Text("$\(String(format: "%.2f", Double(count) * productPrice))")
                .foregroundColor(.white)
                .fontWeight(.bold)
            
            HStack(spacing: 8) {
                Button(action: {
                    if count > 1 {
                        count -= 1
                    } else {
                        onDelete()
                    }
                }) {
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(.white)
                        .font(.title2)
                }
                .buttonStyle(PlainButtonStyle())
                
                Text("\(count)")
                    .foregroundColor(.white)
                    .frame(minWidth: 24)
                
                Button(action: { count += 1 }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.white)
                        .font(.title2)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}



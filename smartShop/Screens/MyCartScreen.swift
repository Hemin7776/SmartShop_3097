
import SwiftUI

struct MyCartScreen: View {
    @State private var OrderList = [
        ListOrderItem(name: "Fruits", image: "fruitspic", count: 2, unitPrice: 10.0),
        ListOrderItem(name: "Biryani", image: "ricepic", count: 3, unitPrice: 13.33),
        ListOrderItem(name: "Eggs", image: "eggspic", count: 4, unitPrice: 12.50)
    ]
    let taxRate = 0.085
    
    var subtotal: Double {
        OrderList.reduce(0) { $0 + $1.totalPrice }
    }
    var taxAmount : Double {
        subtotal * taxRate
    }
    var total: Double {
        subtotal + taxAmount
    }
    var body: some View {
        
        NavigationStack{
            VStack(spacing:9){
                ForEach($OrderList) { $orderlist in
                    ItemOrderRowView(item: $orderlist)
                }
                Spacer()
                RoundedRectangle(cornerRadius: 10)
                    .frame(maxWidth: 350)
                    .frame(height: 70)
                    .foregroundStyle(.appBlue)
                    .shadow(radius: 10)
                    .overlay {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Total $\(String(format: "%.2f", total))")
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                                Text("(incl. $\(String(format: "%.2f", taxAmount)) tax)")
                                    .foregroundStyle(.white)
                                    .font(.caption)
                            }
                            
                            Spacer()
                            
                            RoundedRectangle(cornerRadius: 10)
                                .frame(maxWidth: 100)
                                .frame(height: 50)
                                .foregroundStyle(.white)
                                .shadow(radius: 10)
                                .overlay {
                                    Text("CHECK OUT")
                                        .fontDesign(.rounded)
                                        .font(.caption)
                                }
                        }
                        .padding()
                    }
            }.padding(.bottom)
        }  .navigationTitle("My cart")
        
    }
    
}
#Preview {
    MyCartScreen()
}


struct ItemOrderRowView: View {
    @Binding var item: ListOrderItem
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(maxWidth: 350)
            .frame(height: 100)
            .foregroundStyle(.appBlue)
            .shadow(radius: 10)
            .overlay {
                HStack(spacing: 5) {
                    Image(item.image)
                        .resizable()
                        .scaledToFit()
                    
                    
                    Text(item.name)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    CounterOrderButtonView(count: $item.count, item: item)
                }
                .padding()
                
            }
    }
}
struct CounterOrderButtonView: View {
    @Binding var count: Int
    let item: ListOrderItem
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 4) {
            Text("$\(String(format: "%.2f", item.totalPrice))")
                .foregroundStyle(.white)
                .fontWeight(.bold)
            
            HStack(spacing: 1) {
                Button(action: {
                    if count > 1 {
                        count -= 1
                    }
                }) {
                    Image(systemName: "minus.square.fill")
                        .foregroundStyle(.white)
                        .font(.title2)
                }
                .buttonStyle(PlainButtonStyle())
                
                Text("\(count)")
                    .foregroundStyle(.white)
                    .frame(minWidth: 24)
                
                Button(action: {
                    count += 1
                }) {
                    Image(systemName: "plus.square.fill")
                        .foregroundStyle(.white)
                        .font(.title2)
                }
                
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}
struct ListOrderItem: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    var count: Int
    let unitPrice: Double
    
    var totalPrice: Double {
        Double(count) * unitPrice
    }
    
    var formattedUnitPrice: String {
        "$\(String(format: "%.2f", unitPrice))"
    }
    
    var formattedTotalPrice: String {
        "$\(String(format: "%.2f", totalPrice))"
    }
}

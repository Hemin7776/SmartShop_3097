
import SwiftUI
struct FavouritesScreen: View {
    @State private var gorceryItems = [
        ListItems(name: "Bread", image: "bread", count: 2, weight: "200g"),
        ListItems(name: "Milk", image: "milk", count: 3, weight: "2L"),
        ListItems(name: "Eggs", image: "egg", count: 4, weight: "10ct"),
        ListItems(name: "Eggs", image: "peanut-butter", count: 1, weight: "1Dozen"),
    ]
    @State private var FoodsItems = [
        ListItems(name: "Burger", image: "burger", count: 2, weight: "4M"),
        ListItems(name: "Pizza", image: "pizza", count: 3, weight: "2L"),
        ListItems(name: "Fried Chicken", image: "fried-chicken", count: 4, weight: "2pieces"),
        ListItems(name: "Mutton", image: "lamb", count: 1, weight: "1kg"),
    ]
    var body: some View {
        NavigationStack{
            VStack(spacing: 0) {
                //deals widget
                dealWidgetView()
                // listView widget
                List() {
                    Section("Grocery products")
                    {
                        ForEach($gorceryItems){ $item in
                            ItemRowView(item: $item)
                        }
                    }
                    Section("Foods")
                    {
                        ForEach($FoodsItems){$items in
                            
                            ItemRowView(item: $items)
                        }
                    }
                    
                }
            }
        }.navigationTitle("Favourites")
    }
}

#Preview {
    FavouritesScreen()
}
struct dealWidgetView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(maxWidth: 350)
            .frame(height: 120)
            .foregroundStyle(Color.white)
            .shadow(radius: 10)
            .overlay{
                VStack{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.appBlue)
                        .overlay{
                            Text("Best Deals for you!")
                                .font(.title)
                                .background(.appBlue)
                                .foregroundStyle(.white)
                        }
                    Spacer()
                    HStack{
                        Text("Exclusive")
                        Text("Eexclusive subway deals")
                        Text("Crazy deals")
                        
                    }.font(.caption)
                        .fontWeight(.semibold)
                }
                .padding(20)
            }
    }
}

struct ItemRowView: View {
    @Binding var item: ListItems
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(maxWidth: 350)
            .frame(height: 50)
            .foregroundStyle(.appBlue)
            .shadow(radius: 10)
            .overlay {
                HStack {
                    Image(item.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 50)

                    Text(item.name)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    CounterButtonView(count: $item.count, weight: item.weight)
                }
                .padding()
            }
    }
}

struct CounterButtonView: View {
    @Binding var count: Int
    let weight: String
    
    var body: some View {
        HStack(spacing: 5) {
            Text(weight)
                .foregroundStyle(.white)
            
            Button(action: {
                count += 1
            }) {
                Image(systemName: "plus.square.fill")
                    .foregroundStyle(.white)
                    .contentShape(Rectangle())
            }
            .buttonStyle(PlainButtonStyle())
            
            Text("\(count)")
                .foregroundStyle(.white)
            
            Button(action: {
                if count > 0 {
                    count -= 1
                }
            }) {
                Image(systemName: "minus.square.fill")
                    .foregroundStyle(.white)
                    .contentShape(Rectangle())
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}




struct ListItems : Identifiable {
    let id = UUID()
    let name: String
    let image : String
    var count : Int
    let weight : String
}



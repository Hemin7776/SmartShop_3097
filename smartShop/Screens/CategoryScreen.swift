
import SwiftUI
import SwiftData  
struct CategoryScreen: View {
    @State private var showAddCategory = false
    @Environment(\.modelContext) private var modelContext
    @Query private var categories: [Category]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 5) {
                    if !categories.isEmpty {
                        ForEach(categories) { category in
                            homeWidgetComponent(
                                foreground: CategoryManager.shared.stringToColor(category.color),
                                image: category.icon,
                                text: category.name,
                                smallWidget: false
                            )
                            .contextMenu {
                                Button(role: .destructive) {
                                    modelContext.delete(category)
                                    try? modelContext.save()
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    } else {
                        VStack(spacing: 24) {
                            Image(systemName: "square.grid.2x2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.secondary)
                                .padding(.top, 40)
                            
                            Text("No Categories Added")
                                .font(.title2)
                                .fontWeight(.medium)
                            
                            Text("Add categories to organize your shopping lists")
                                .font(.body)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 40)
                    }
                    
                    createCategoryButton(action: {
                        showAddCategory = true
                    })
                    
                    Spacer()
                }
                .padding(20)
            }
            .navigationTitle("Categories")
            .sheet(isPresented: $showAddCategory) {
                AddCategoryView()
            }
        }
    }
}

#Preview {
    CategoryScreen()
}


struct createCategoryButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "plus.app.fill")
                Text("Create Category")
            }
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.appBlue)
            )
        }
    }
}




struct AddCategoryView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query private var savedCategories: [Category]
    
    @State private var selectedCategory: CategoryOption?
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Select a Category")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(CategoryManager.shared.predefinedCategories) { category in
                            if !savedCategories.contains(where: { $0.name == category.name }) {
                                CategorySelectionItem(category: category, isSelected: selectedCategory?.id == category.id) {
                                    selectedCategory = category
                                }
                            }
                        }
                    }
                    .padding()
                }
                
                if savedCategories.count == CategoryManager.shared.predefinedCategories.count {
                    Text("You've added all available categories")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .padding()
                }
                
                Button(action: {
                    if let selected = selectedCategory {
                        let newCategory = Category(
                            name: selected.name,
                            icon: selected.icon,
                            color: CategoryManager.shared.colorToString(selected.color),
                            isSelected: true
                        )
                        modelContext.insert(newCategory)
                        
                        dismiss()
                    }
                }) {
                    Text("Add Category")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(selectedCategory != nil ? Color.appBlue : Color.gray)
                        )
                }
                .disabled(selectedCategory == nil)
                .padding()
            }
            .navigationTitle("Add Category")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
struct CategorySelectionItem: View {
    let category: CategoryOption
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 100)
                .foregroundStyle(category.color)
                .overlay(
                    VStack(spacing: 12) {
                        Text(category.name)
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundStyle(.foreground)
                        
                        Image(systemName: category.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    }
                    .padding()
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(isSelected ? Color.appBlue : Color.clear, lineWidth: 3)
                )
        }
        .onTapGesture {
            onTap()
        }
    }
}
struct EmptyCategoryScreen_Preview: PreviewProvider {
    static var previews: some View {
        CategoryScreen()
            .modelContainer(for: Category.self, inMemory: true)
    }
}

struct CategoryScreenWithData_Preview: PreviewProvider {
    static var previews: some View {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Category.self, configurations: config)
        
        let context = container.mainContext
        context.insert(Category(name: "Food", icon: "fork.knife", color: "orange", isSelected: true))
        context.insert(Category(name: "Cleaning", icon: "hands.and.sparkles.fill", color: "cyan", isSelected: true))
        
        return CategoryScreen()
            .modelContainer(container)
    }
}

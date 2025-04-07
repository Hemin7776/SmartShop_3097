import SwiftUI
import SwiftData

enum CategoryCreationMode: String, CaseIterable {
    case predefined = "Predefined"
    case custom = "Custom"
}

struct CategoryScreen: View {
    @State private var showAddCategory = false
    @Environment(\.modelContext) private var modelContext
    @Query private var categories: [Category]
    
    private let predefinedNames = ["Food", "Cleaning", "Grocery", "Medication", "Electronics", "Clothing", "Home", "Books", "Sports", "Beauty"]
    
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
                                // Only allow deletion if this is NOT a predefined category.
                                if !isPredefined(category: category) {
                                    Button(role: .destructive) {
                                        do {
                                            modelContext.delete(category)
                                            try modelContext.save()
                                        } catch {
                                            print("Deletion error: \(error)")
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
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
    
    private func isPredefined(category: Category) -> Bool {
        predefinedNames.contains(category.name)
    }
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
    
    @State private var customName = ""
    @State private var selectedIcon = "folder"
    @State private var selectedColor = Color.gray  // Default is gray
    @State private var showingIconPicker = false
    @State private var showingColorPicker = false
    
    // SF Symbols icons for selection
    let systemIcons = ["folder", "tag", "cart", "heart", "star", "bookmark", "flag", "pencil", "photo", "trash"]
    
    // Color options (including gray)
    let colorOptions: [Color] = [.red, .orange, .yellow, .green, .mint, .teal, .cyan, .blue, .indigo, .purple, .pink, .brown, .gray]
    
    var body: some View {
        NavigationStack {
            VStack {
                customCategoryForm
                addButton
            }
            .navigationTitle("Add Category")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
            }
            .sheet(isPresented: $showingIconPicker) {
                iconPickerView
            }
            .sheet(isPresented: $showingColorPicker) {
                ColorPickerGridView(selectedColor: $selectedColor, colorOptions: colorOptions)
            }
        }
    }
    
    private var customCategoryForm: some View {
        Form {
            Section(header: Text("Custom Details")) {
                TextField("Category Name", text: $customName)
                
                HStack {
                    Text("Icon")
                    Spacer()
                    Button {
                        showingIconPicker.toggle()
                    } label: {
                        Image(systemName: selectedIcon)
                            .font(.title)
                            .foregroundColor(selectedColor)
                    }
                }
                
                HStack {
                    Text("Category Color")
                    Spacer()
                    Button {
                        showingColorPicker.toggle()
                    } label: {
                        Circle()
                            .fill(selectedColor)
                            .frame(width: 30, height: 30)
                    }
                }
            }
        }
    }
    
    private var iconPickerView: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 20) {
                    ForEach(systemIcons, id: \.self) { icon in
                        Button {
                            selectedIcon = icon
                            showingIconPicker = false
                        } label: {
                            Image(systemName: icon)
                                .font(.largeTitle)
                                .frame(width: 60, height: 60)
                                .background(selectedColor.opacity(0.2))
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Choose Icon")
        }
    }
    
    private var addButton: some View {
        Button(action: addCategory) {
            Text("Add Category")
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(isValidEntry ? Color.appBlue : Color.gray)
                )
                .padding()
        }
        .disabled(!isValidEntry)
    }
    
    private var isValidEntry: Bool {
   
        return !customName.isEmpty && !savedCategories.contains { $0.name == customName }
    }
    
    private func addCategory() {
        let fetchDescriptor = FetchDescriptor<Category>(sortBy: [])
        let existingCategories = (try? modelContext.fetch(fetchDescriptor)) ?? []
        
        if existingCategories.contains(where: { $0.name == customName }) {
            dismiss()
            return
        }
        
        let newCategory = Category(
            name: customName,
            icon: selectedIcon,
            color: CategoryManager.shared.colorToString(selectedColor),
            isSelected: true
        )
        modelContext.insert(newCategory)
        
        do {
            try modelContext.save()
            dismiss()
        } catch {
            print("Error saving category: \(error)")
        }
    }
}

struct ColorPickerGridView: View {
    @Binding var selectedColor: Color
    let colorOptions: [Color]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 20) {
                    ForEach(colorOptions, id: \.self) { color in
                        Button {
                            selectedColor = color
                        } label: {
                            Circle()
                                .fill(color)
                                .frame(width: 40, height: 40)
                                .overlay(
                                    Circle().stroke(selectedColor == color ? Color.primary : Color.clear, lineWidth: 2)
                                )
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Choose Color")
        }
    }
}

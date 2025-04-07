import Foundation
import SwiftData



class ProductManager {
    static let shared = ProductManager()
    
    func seedInitialData(context: ModelContext) {
        let fetchDescriptor = FetchDescriptor<Category>(sortBy: [])
              if let existingCategories = try? context.fetch(fetchDescriptor), !existingCategories.isEmpty {
                  // Predefined categories already exist – skip seeding.
                  return
              }
        // Create all categories
        let categories = [
            Category(name: "Food", icon: "fork.knife", color: "orange"),
            Category(name: "Cleaning", icon: "hands.and.sparkles.fill", color: "cyan"),
            Category(name: "Grocery", icon: "basket.fill", color: "mint"),
            Category(name: "Medication", icon: "pills.fill", color: "green"),
            Category(name: "Electronics", icon: "desktopcomputer", color: "blue"),
            Category(name: "Clothing", icon: "tshirt.fill", color: "pink"),
            Category(name: "Home", icon: "house.fill", color: "brown"),
            Category(name: "Books", icon: "book.fill", color: "purple"),
            Category(name: "Sports", icon: "sportscourt.fill", color: "red"),
            Category(name: "Beauty", icon: "drop.fill", color: "indigo")
        ]
        
        // Insert categories first so they’re registered with the context.
        categories.forEach { context.insert($0) }
        
        
        // Food Category (index 0)
        let product1 = Product(productPicture: "fork.knife.circle.fill",
                               productPrice: 5.99,
                               productDiscription: "Freshly baked pizza with pepperoni")
        categories[0].products.append(product1)
        context.insert(product1)
        
        let product2 = Product(productPicture: "carrot.fill",
                               productPrice: 2.49,
                               productDiscription: "Organic carrots - 1lb bag")
        categories[0].products.append(product2)
        context.insert(product2)
        
        // Cleaning Category (index 1)
        let product3 = Product(productPicture: "bubbles.and.sparkles.fill",
                               productPrice: 3.99,
                               productDiscription: "All-purpose cleaner spray")
        categories[1].products.append(product3)
        context.insert(product3)
        
        let product4 = Product(productPicture: "trash.fill",
                               productPrice: 1.99,
                               productDiscription: "Heavy-duty trash bags")
        categories[1].products.append(product4)
        context.insert(product4)
        
        // Grocery Category (index 2)
        let product5 = Product(productPicture: "leaf.fill",
                               productPrice: 3.49,
                               productDiscription: "Organic spinach bunch")
        categories[2].products.append(product5)
        context.insert(product5)
        
        let product6 = Product(productPicture: "drop.fill",
                               productPrice: 1.29,
                               productDiscription: "Bottled spring water")
        categories[2].products.append(product6)
        context.insert(product6)
        
        // Medication Category (index 3)
        let product7 = Product(productPicture: "bandage.fill",
                               productPrice: 4.99,
                               productDiscription: "For Skin scratch")
        categories[3].products.append(product7)
        context.insert(product7)
        
        let product8 = Product(productPicture: "pills.circle.fill",
                               productPrice: 6.99,
                               productDiscription: "Pain relief tablets")
        categories[3].products.append(product8)
        context.insert(product8)
        
        // Electronics Category (index 4)
        let product9 = Product(productPicture: "headphones.fill",
                               productPrice: 29.99,
                               productDiscription: "Wireless earbuds")
        categories[4].products.append(product9)
        context.insert(product9)
        
        let product10 = Product(productPicture: "battery.100",
                                productPrice: 19.99,
                                productDiscription: "Portable power bank")
        categories[4].products.append(product10)
        context.insert(product10)
        
        // Clothing Category (index 5)
        let product11 = Product(productPicture: "shoe.fill",
                                productPrice: 49.99,
                                productDiscription: "Running sneakers")
        categories[5].products.append(product11)
        context.insert(product11)
        
        let product12 = Product(productPicture: "hat.fill",
                                productPrice: 15.99,
                                productDiscription: "Baseball cap")
        categories[5].products.append(product12)
        context.insert(product12)
        
        // Home Category (index 6)
        let product13 = Product(productPicture: "lightbulb.fill",
                                productPrice: 8.99,
                                productDiscription: "LED smart bulb")
        categories[6].products.append(product13)
        context.insert(product13)
        
        let product14 = Product(productPicture: "bed.double.fill",
                                productPrice: 24.99,
                                productDiscription: "Cotton pillow set")
        categories[6].products.append(product14)
        context.insert(product14)
        
        // Books Category (index 7)
        let product15 = Product(productPicture: "book.closed.fill",
                                productPrice: 14.99,
                                productDiscription: "Sci-fi novel bestseller")
        categories[7].products.append(product15)
        context.insert(product15)
        
        let product16 = Product(productPicture: "magazine.fill",
                                productPrice: 5.99,
                                productDiscription: "Monthly tech magazine")
        categories[7].products.append(product16)
        context.insert(product16)
        
        // Sports Category (index 8)
        let product17 = Product(productPicture: "figure.run",
                                productPrice: 39.99,
                                productDiscription: "Sports water bottle")
        categories[8].products.append(product17)
        context.insert(product17)
        
        let product18 = Product(productPicture: "basketball.fill",
                                productPrice: 24.99,
                                productDiscription: "Professional basketball")
        categories[8].products.append(product18)
        context.insert(product18)
        
        // Beauty Category (index 9)
        let product19 = Product(productPicture: "comb.fill",
                                productPrice: 9.99,
                                productDiscription: "Hair styling comb")
        categories[9].products.append(product19)
        context.insert(product19)
        
        let product20 = Product(productPicture: "paintbrush.fill",
                                productPrice: 12.99,
                                productDiscription: "Makeup brush set")
        categories[9].products.append(product20)
        context.insert(product20)
    }
    
    // This function uses the seeded categories from CategoryManager if needed.
    func getCategory(byName name: String) -> Category? {
        return CategoryManager.shared.getPredefinedCategories().first { $0.name == name }
    }
    
    // Returns products by accessing the Category's products array.
    func getProducts(forCategory category: Category) -> [Product] {
        return category.products
    }
}



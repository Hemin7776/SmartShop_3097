import Foundation
import SwiftData
import SwiftUICore



@Model
final class CartItemsModel {
    var product: Product
    var quantity: Int
    
    init(product: Product, quantity: Int) {
        self.product = product
        self.quantity = quantity
    }
    
    var totalPrice: Double {
        product.productPrice * Double(quantity)
    }
}


@Model
final class Product {
    var productPicture: String
    var productPrice: Double
    var productDiscription: String
    
    init(productPicture: String,
         productPrice: Double,
         productDiscription: String) {
        self.productPicture = productPicture
        self.productPrice = productPrice
        self.productDiscription = productDiscription
    }
}

extension Product {
    /// Returns the asset name to use for displaying the product image based on its category.
    func assetName(for category: Category) -> String {
        switch category.name {
        case "Food":
            if productPicture == "carrot.fill" {
                return "carrot"
            } else if productPicture == "fork.knife.circle.fill" {
                return "pizza"
            } else {
                return "spinanch"
            }
        case "Medication":
            if productPicture == "bandage.fill" {
                return "bandadge"
            }
            else {
                return "tablets"
            }
            

        case "Grocery":
            if productPicture == "leaf.fill" {
               return "spinach"
            }
          
            else {
                return "water"
            }
        default:
            return productPicture // fallback (could be a system image)
        }
    }
    
    var assetName: String {
        if productPicture == "carrot.fill" {
            return "carrot"
        } else if productPicture == "fork.knife.circle.fill" {
            return "pizza"
        } else if productPicture == "leaf.fill" {
            return "spinach"
        } else if productPicture == "bandage.fill" {
            return "bandadge"
        } else if productPicture == "pills.circle.fill" {
            return "tablets"
        } else if productPicture == "drop.fill" {
            return "water"
        } else {
            return productPicture
        }
    }
}
@Model
final class Category: Identifiable {
    @Relationship(deleteRule: .cascade)
    var products: [Product] = []
    
    var name: String
    var icon: String
    var color: String
    var isSelected: Bool
    
    init(name: String, icon: String, color: String, isSelected: Bool = false) {
        self.name = name
        self.icon = icon
        self.color = color
        self.isSelected = isSelected
    }
}

extension Category {
    var uiColor: Color {
        switch color.lowercased() {
        case "red": return .red
        case "orange": return .orange
        case "yellow": return .yellow
        case "green": return .green
        case "mint": return .mint
        case "teal": return .teal
        case "cyan": return .cyan
        case "blue": return .blue
        case "indigo": return .indigo
        case "purple": return .purple
        case "pink": return .pink
        case "brown": return .brown
        default: return .gray
        }
    }
}

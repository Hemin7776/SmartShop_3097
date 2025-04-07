import Foundation
import SwiftUI

class CategoryManager {
    static let shared = CategoryManager()
    
    func getPredefinedCategories() -> [Category] {
        return [
            Category(name: "Food", icon: "fork.knife", color: "orange", isSelected: false),
            Category(name: "Cleaning", icon: "hands.and.sparkles.fill", color: "cyan", isSelected: false),
            Category(name: "Grocery", icon: "basket.fill", color: "mint", isSelected: false),
            Category(name: "Medication", icon: "pills.fill", color: "green", isSelected: false),
            Category(name: "Electronics", icon: "desktopcomputer", color: "blue", isSelected: false),
            Category(name: "Clothing", icon: "tshirt.fill", color: "pink", isSelected: false),
            Category(name: "Home", icon: "house.fill", color: "brown", isSelected: false),
            Category(name: "Books", icon: "book.fill", color: "purple", isSelected: false),
            Category(name: "Sports", icon: "sportscourt.fill", color: "red", isSelected: false),
            Category(name: "Beauty", icon: "drop.fill", color: "indigo", isSelected: false)
        ]
    }
    
    func colorToString(_ color: Color) -> String {
        let colors: [Color: String] = [
            .red: "red",
            .orange: "orange",
            .yellow: "yellow",
            .green: "green",
            .mint: "mint",
            .teal: "teal",
            .cyan: "cyan",
            .blue: "blue",
            .indigo: "indigo",
            .purple: "purple",
            .pink: "pink",
            .brown: "brown",
            .gray: "gray"
        ]
        
        return colors[color] ?? "gray"
    }
        
    func stringToColor(_ string: String) -> Color {
        switch string.lowercased() {
        case "orange": return .orange
        case "cyan": return .cyan
        case "mint": return .mint
        case "green": return .green
        case "blue": return .blue
        case "pink": return .pink
        case "brown": return .brown
        case "purple": return .purple
        case "red": return .red
        case "indigo": return .indigo
        case "gray": return .gray
        default: return .gray
        }
    }
}
